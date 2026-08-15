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

# 7. Open owner directives — a note under "OWNER NOTES BELOW" outranks everything and MUST open
#    Gear 1. Without this the loop reads the note, finds every gate green, and goes back to vigil.
#    A directive is a `## ` heading in the notes section; it is closed by a `> RESOLVED …` line
#    under it (the loop writes that when it ships the work).
DIRECTIVES=$(python3 - <<'PY'
import io,re
try: s=io.open('OWNER-GATE.md',encoding='utf-8').read()
except Exception: print(0); raise SystemExit
notes=s.split('<!-- OWNER NOTES BELOW -->',1)
if len(notes)<2: print(0); raise SystemExit
blocks=re.split(r'^## ',notes[1],flags=re.M)[1:]
open_=[b.split('\n',1)[0].strip() for b in blocks if not re.search(r'^> *RESOLVED',b,flags=re.M)]
print(len(open_))
for t in open_[:3]: print('   ↳ '+t[:88])
PY
)
NDIR=$(printf '%s' "$DIRECTIVES" | head -1)
if [ "${NDIR:-0}" != "0" ]; then
  no "$NDIR open owner directive(s) — these outrank every gate"
  printf '%s\n' "$DIRECTIVES" | tail -n +2
else ok "no open owner directives"; fi

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

▶ GEAR 3 — VIGIL. The loop does NOT stop and does NOT touch index.html.
  Each tick: re-verify (a regression here re-opens Gear 1), then do LAB work —
  evidence, probes and throwaway prototypes in lab/ for candidate next eras.
  Unbounded effort, zero drift risk: nothing in lab/ ships.
  Hold the synthesis until the owner answers the felt gate — a synthesis written
  without knowing whether the core lands is guesswork.
EOF
  exit 10
fi
if [ -f SYNTHESIS.md ]; then
  cat <<'EOF'
🕯  ERA COMPLETE · SYNTHESIS WRITTEN — awaiting the owner's pick.

▶ GEAR 3 — VIGIL. Keep watch and keep prototyping in lab/ for the candidates
  already proposed in SYNTHESIS.md. Do not pick an era for yourself.
EOF
  exit 20
fi
cat <<'EOF'
🏁 ERA COMPLETE — machine and owner gates all green.

▶ GEAR 2 — SYNTHESIZE. The most important thing this loop ever does.
  MILESTONES.md → "The synthesis protocol". Read the whole game as a stranger,
  separate load-bearing from decoration, find the unspent potential, and write
  3-4 candidate next eras to SYNTHESIS.md — one reductive, one a real swing.
  Then drop to Gear 3 and keep watch. The owner picks; the loop never picks.
EOF
exit 20
