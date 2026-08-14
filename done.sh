#!/bin/bash
# done.sh — is Thừa Số Không finished?
#
# The loop's termination check. Machine gates are things the loop can fix by itself;
# owner gates (OWNER-GATE.md) are things only a human can judge.
#
# exit 0  → WORK REMAINS. A machine gate is red; the loop has convergent work to do.
# exit 10 → CONVERGED. Every machine gate is green; only owner gates remain. THE LOOP HALTS.
# exit 20 → COMPLETE. Everything is ticked. 1.0.
#
# Usage: ./done.sh          full check (runs gate.sh, hits the network)
#        ./done.sh --fast   skip gate.sh and the live-site check

set -u
cd "$(dirname "$0")"
FAST=0; [ "${1:-}" = "--fast" ] && FAST=1
RED=0
ok(){   printf '  ✅ %s\n' "$*"; }
no(){   printf '  ❌ %s\n' "$*"; RED=1; }
skip(){ printf '  ⏭  %s\n' "$*"; }

echo "── machine gates ──────────────────────────────────────"

# 1. Release gates green
if [ "$FAST" = 1 ]; then skip "release gates (--fast)"
elif ./gate.sh >/tmp/tsk-done-gate.out 2>&1; then ok "release gates green (band · syntax · fresh · nan · 16-season VI+EN)"
else no "release gates RED — $(grep '❌' /tmp/tsk-done-gate.out | head -2 | tr '\n' ' ')"; fi

# 2. Nothing stranded in the working tree
DIRTY=$(git status --porcelain)
[ -z "$DIRTY" ] && ok "working tree clean" \
                || no "uncommitted work stranded: $(echo "$DIRTY" | tr '\n' ' ')"

# 3. Local and origin agree
git fetch -q origin 2>/dev/null
AHEAD=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo '?')
[ "$AHEAD" = "0" ] && ok "pushed (origin/main == HEAD)" \
                   || no "$AHEAD commit(s) unpushed"

# 4. check.js mirrors index.html — the band is asserted against the real math
#    (gate.sh Gate 0 runs check.js; this catches check.js being stale vs a math edit)
MATHDATE=$(git log -1 --format=%ct -- index.html 2>/dev/null || echo 0)
CHKDATE=$(git log -1 --format=%ct -- check.js 2>/dev/null || echo 0)
if [ "$MATHDATE" -gt "$CHKDATE" ]; then
  skip "check.js older than index.html — confirm no math changed since $(git log -1 --format=%ad --date=short -- check.js)"
else ok "check.js not stale vs index.html"; fi

# 5. Bilingual parity — every player-facing string carries VI and EN
#    NB: match a delimiter before the key — a bare 'en:' also hits green:/when:/hen: (10 false
#    positives as of v0.26, which read as a phantom bilingual gap).
VI=$(grep -oE '[{, ]vi:' index.html | wc -l | tr -d ' ')
EN=$(grep -oE '[{, ]en:' index.html | wc -l | tr -d ' ')
[ "$VI" = "$EN" ] && ok "bilingual parity ($VI vi / $EN en)" \
                  || no "bilingual gap: $VI vi vs $EN en"

# 6. What is live is what is in the repo
REPO_V=$(grep -oE 'v0\.[0-9]+(\.[0-9]+)?' index.html | head -1)
if [ "$FAST" = 1 ]; then skip "live version (--fast) — repo is $REPO_V"
else
  LIVE_V=$(curl -s --max-time 20 https://techeese.github.io/thua-so-khong/ | grep -oE 'v0\.[0-9]+(\.[0-9]+)?' | head -1)
  [ -n "$LIVE_V" ] && [ "$LIVE_V" = "$REPO_V" ] && ok "live == repo ($REPO_V)" \
                                                || no "live is ${LIVE_V:-unreachable}, repo is $REPO_V — shipped work is invisible"
fi

echo
echo "── owner gates (OWNER-GATE.md) ────────────────────────"
# grep -c prints 0 and exits 1 when nothing matches — no `|| echo 0` fallback, that double-prints.
OPEN=$(grep -c '^- \[ \]' OWNER-GATE.md 2>/dev/null); OPEN=${OPEN:-0}
DONE=$(grep -c '^- \[x\]' OWNER-GATE.md 2>/dev/null); DONE=${DONE:-0}
grep '^- \[' OWNER-GATE.md 2>/dev/null | sed -E 's/^- \[x\] /  ✅ /; s/^- \[ \] /  ⬜ /; s/\*\*//g' | cut -c1-96
echo "  ($DONE ticked · $OPEN open — only the owner may tick these)"

echo
if [ "$RED" = 1 ]; then
  echo "🔧 WORK REMAINS — machine gates are red. The loop has convergent work."
  exit 0
fi
if [ "$OPEN" -gt 0 ]; then
  cat <<'EOF'
🟢 CONVERGED — every machine gate is green. Only owner gates remain.

THIS ERA IS DONE. That is a success state, not a failure.
Do NOT rotate to lateral work and do NOT pad the game with items that close nothing.
Report to the owner and name the open owner gates above.

The era closes when the owner answers them. Then run the SYNTHESIS
(MILESTONES.md → "The synthesis protocol") to choose the next era.
EOF
  exit 10
fi
cat <<'EOF'
🏁 ERA COMPLETE — machine and owner gates all green.

Now do the most important thing this loop ever does: run the SYNTHESIS.
See MILESTONES.md → "The synthesis protocol". Read the whole game as a stranger,
name what is load-bearing vs. decoration, find the unspent potential, and write
3–4 candidate next eras to SYNTHESIS.md — one of them reductive, one a real swing.

Then HALT. The owner picks the next era; the loop never picks for itself.
EOF
exit 20
