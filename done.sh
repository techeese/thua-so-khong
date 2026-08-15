#!/bin/bash
# done.sh — is Thừa Số Không finished?
#
# The loop's gear selector. The loop NEVER exits; it always has a gear.
#
# exit 0  → GEAR 1 CONVERGE.    A machine gate is red. Ship until it is green.
# exit 10 → GEAR 3 VIGIL.       Nothing legitimate to ship: watchdog + one lab investigation.
# exit 20 → GEAR 2 SYNTHESIZE.  The era is over — propose candidate next eras, then transition.
#
# Under full autonomy (LOOP.md v4) the owner's felt gate is ADVISORY and does not block an era;
# an era ends by EXHAUSTION — three consecutive lab ticks with no 'new-argument' verdict.
# Exhaustion never halts the loop; it ESCALATES one layer up the ladder (LADDER.md): era → form
# → thesis. What keeps a self-modifying loop safe is no longer an unreachable charter but
# AUDITABILITY + A RATCHET: gates may be added and never removed, and every thesis the artifact
# has held stays on record in CHARTER-LINEAGE.md, each required to be no easier than the last.
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

# 0a. CHARTER LOCK — the loop may not change what the game is for.
#     This is the fixed point that makes an autonomous, self-modifying loop safe: a loop free to
#     rewrite its own definition of success will eventually rewrite it into something easy.
# [gate:charter-lock]
if [ -f CHARTER.md ] && [ -f CHARTER.lock ]; then
  HAVE=$(shasum -a 256 CHARTER.md | cut -d' ' -f1); WANT=$(tr -dc 0-9a-f < CHARTER.lock)
  [ "$HAVE" = "$WANT" ] && ok "charter locked (unchanged)" \
    || no "CHARTER.md CHANGED — the loop must never edit it. Restore it (git checkout CHARTER.md) or, if the OWNER changed it, re-lock: shasum -a 256 CHARTER.md | cut -d' ' -f1 > CHARTER.lock"
else no "charter lock missing (need CHARTER.md + CHARTER.lock)"; fi

# 0a2. CHARTER LINEAGE — the loop MAY change the charter, but only at an L4 transition and only
#      by appending the successor thesis to CHARTER-LINEAGE.md first. Requiring the live hash to
#      appear there is what replaced the old absolute lock: the charter is no longer unreachable,
#      it is auditable. A charter rewritten without a lineage entry is a red gate.
# [gate:charter-lineage]
if [ -f CHARTER.lock ] && [ -f CHARTER-LINEAGE.md ]; then
  H=$(tr -dc 0-9a-f < CHARTER.lock)
  grep -q "$H" CHARTER-LINEAGE.md \
    && ok "charter lineage records the live thesis ($(grep -c '^## Thesis ' CHARTER-LINEAGE.md) thesis/es on record)" \
    || no "CHARTER.md changed with NO lineage entry — append the successor thesis to CHARTER-LINEAGE.md (never edit a prior entry); see LADDER.md → L4"
else no "charter lineage missing (need CHARTER.lock + CHARTER-LINEAGE.md)"; fi

# 0b. GATES RATCHET — every gate ever added must still exist. Gates may be added, never removed.
#     Each done.sh gate carries an inline `[gate:<id>]` marker, so deleting the gate deletes its
#     marker and this check fires. Iterate on gate NUMBERS — `for g in $(... 'Gate [0-9]+')` word-
#     splits "Gate 0" into "Gate" and "0" and reports every gate missing.
# [gate:gates-ledger]
MISSING=""
for n in $(grep -oE '^\| `Gate [0-9]+`' GATES-LEDGER.md 2>/dev/null | grep -oE '[0-9]+'); do
  grep -q "^# Gate $n:" gate.sh || MISSING="$MISSING Gate-$n"
done
for k in $(grep -oE '^\| `[a-z][a-z-]+`' GATES-LEDGER.md 2>/dev/null | tr -d '|` '); do
  grep -q "\[gate:$k\]" done.sh || MISSING="$MISSING $k"
done
[ -z "$MISSING" ] && ok "gates ratchet intact (nothing removed)" \
                  || no "GATE(S) REMOVED:$MISSING — the ledger is append-only; restore them"

# 0c. LOOP STRUCTURE — the engine must stay mechanism-only and every loop document must be in git.
# [gate:loop-structure]
if ./loop-selfcheck.sh >/tmp/tsk-selfcheck.out 2>&1; then ok "loop structure sound"
else no "loop structure broken — $(grep '❌' /tmp/tsk-selfcheck.out | head -2 | tr '\n' ' ')"; fi

# 1. Release gates green  [gate:release-gates]
if [ "$FAST" = 1 ]; then skip "release gates (--fast)"
elif ./gate.sh >/tmp/tsk-done-gate.out 2>&1; then ok "release gates green (band · syntax · fresh · nan · 16-season VI+EN)"
else no "release gates RED — $(grep '❌' /tmp/tsk-done-gate.out | head -2 | tr '\n' ' ')"; fi

# 2. Nothing stranded in the working tree  [gate:tree-clean]
DIRTY=$(git status --porcelain)
[ -z "$DIRTY" ] && ok "working tree clean" \
                || no "uncommitted work stranded: $(echo "$DIRTY" | tr '\n' ' ')"

# 3. Local and origin agree  [gate:pushed]
git fetch -q origin 2>/dev/null
AHEAD=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo '?')
[ "$AHEAD" = "0" ] && ok "pushed (origin/main == HEAD)" \
                   || no "$AHEAD commit(s) unpushed"

# 4. check.js mirrors index.html  [gate:checkjs-fresh] — the band is asserted against the real math
#    (gate.sh Gate 0 runs check.js; this catches check.js being stale vs a math edit)
MATHDATE=$(git log -1 --format=%ct -- index.html 2>/dev/null || echo 0)
CHKDATE=$(git log -1 --format=%ct -- check.js 2>/dev/null || echo 0)
if [ "$MATHDATE" -gt "$CHKDATE" ]; then
  skip "check.js older than index.html — confirm no math changed since $(git log -1 --format=%ad --date=short -- check.js)"
else ok "check.js not stale vs index.html"; fi

# 5. Bilingual parity  [gate:bilingual-parity] — every player-facing string carries VI and EN
#    NB: match a delimiter before the key — a bare 'en:' also hits green:/when:/hen: (10 false
#    positives as of v0.26, which read as a phantom bilingual gap).
VI=$(grep -oE '[{, ]vi:' index.html | wc -l | tr -d ' ')
EN=$(grep -oE '[{, ]en:' index.html | wc -l | tr -d ' ')
[ "$VI" = "$EN" ] && ok "bilingual parity ($VI vi / $EN en)" \
                  || no "bilingual gap: $VI vi vs $EN en"

# 6. What is live is what is in the repo  [gate:live-equals-repo]
REPO_V=$(grep -oE 'v0\.[0-9]+(\.[0-9]+)?' index.html | head -1)
if [ "$FAST" = 1 ]; then skip "live version (--fast) — repo is $REPO_V"
else
  LIVE_V=$(curl -s --max-time 20 https://techeese.github.io/thua-so-khong/ | grep -oE 'v0\.[0-9]+(\.[0-9]+)?' | head -1)
  [ -n "$LIVE_V" ] && [ "$LIVE_V" = "$REPO_V" ] && ok "live == repo ($REPO_V)" \
                                                || no "live is ${LIVE_V:-unreachable}, repo is $REPO_V — shipped work is invisible"
fi

# 7. Open owner directives  [gate:no-open-directives] — a note under "OWNER NOTES BELOW" outranks everything and MUST open
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
echo "── owner gates — ADVISORY under full autonomy ─────────"
# grep -c prints 0 and exits 1 when nothing matches — no `|| echo 0` fallback, that double-prints.
OPEN=$(grep -c '^- \[ \]' OWNER-GATE.md 2>/dev/null); OPEN=${OPEN:-0}
DONE=$(grep -c '^- \[x\]' OWNER-GATE.md 2>/dev/null); DONE=${DONE:-0}
grep '^- \[' OWNER-GATE.md 2>/dev/null | sed -E 's/^- \[x\] /  ✅ /; s/^- \[ \] /  ⬜ /; s/\*\*//g' | cut -c1-96
echo "  ($DONE ticked · $OPEN open — only the owner may tick these; they do NOT block an era)"

# EXHAUSTION — the lab has stopped producing new arguments, so the frame itself is the limit.
# Reads the verdict line every lab/NOTES.md entry must carry.
EXH=$(python3 - <<'PY'
import io,re
try: s=io.open('lab/NOTES.md',encoding='utf-8').read()
except Exception: print('0 0'); raise SystemExit
v=re.findall(r'^\*\*Verdict:\*\*\s*([a-z-]+)',s,flags=re.M)
# lab/NOTES.md is NEWEST-FIRST (entries are prepended), so the newest three are v[:3].
# v[-3:] reads the three OLDEST — frozen forever — and EXHAUSTED could never become 1,
# meaning the transition chain could never fire. Silent: the loop looks healthy forever.
last=v[:3]
print(('1' if len(last)==3 and 'new-argument' not in last else '0'), len(v))
PY
)
EXHAUSTED=$(printf '%s' "$EXH" | cut -d' ' -f1); NVERD=$(printf '%s' "$EXH" | cut -d' ' -f2)

# LADDER — exhaustion never halts, it escalates one layer up (LADDER.md).
LSTATE=$(grep -o '<!-- STATE layer=[0-9]* failed_syntheses=[0-9]* -->' LADDER.md 2>/dev/null)
LAYER=$(printf '%s' "$LSTATE" | grep -o 'layer=[0-9]*' | cut -d= -f2); LAYER=${LAYER:-2}
FAILS=$(printf '%s' "$LSTATE" | grep -o 'failed_syntheses=[0-9]*' | cut -d= -f2); FAILS=${FAILS:-0}
case "$LAYER" in
  2) LNAME="L2 · ERA — a system, a pass, a direction";   LCRIT=3 ;;
  3) LNAME="L3 · FORM — genre, structure, medium";       LCRIT=5 ;;
  4) LNAME="L4 · THESIS — what the artifact is about";   LCRIT=7 ;;
  *) LNAME="L$LAYER";                                    LCRIT=3 ;;
esac
if [ "$FAILS" -ge 2 ] && [ "$LAYER" -lt 4 ]; then
  ESCALATE="  ⚑ ESCALATE: $FAILS consecutive syntheses produced no surviving candidate.
    Move to L$((LAYER+1)) and synthesise THERE — update the STATE line in LADDER.md.
    Escalation is earned, never chosen: the rejections must be on record in SYNTHESIS.md."
else ESCALATE=""; fi

echo
if [ "$RED" = 1 ]; then
  echo "🔧 WORK REMAINS — machine gates are red. The loop has convergent work."
  echo "▶ GEAR 1 — CONVERGE. Ship until they are green."
  exit 0
fi
if [ -f SYNTHESIS.md ]; then
  cat <<'EOF'
🕯  SYNTHESIS WRITTEN — pick a candidate, run the adversarial review, and if it
   survives, execute the transition manifest (MILESTONES.md) as ONE commit.

▶ GEAR 2. Under full autonomy the loop picks for itself — but only a candidate
  that survives 3 critics briefed to reject. Charter stays locked; gates ratchet
  up only. If nothing survives, say why and re-synthesize next tick.
EOF
  exit 20
fi
if [ "$EXHAUSTED" = "1" ]; then
  cat <<EOF
🏁 ERA EXHAUSTED — gates green and the last 3 lab ticks produced no new argument.
   The frame itself is now the limit.

▶ GEAR 2 — SYNTHESIZE at $LNAME
  Read the game as a stranger, separate load-bearing from decoration, find the
  unspent potential, write 3-4 candidates to SYNTHESIS.md — one reductive, one a
  real swing — then face $LCRIT critics briefed to reject. Protocol: MILESTONES.md.
  The loop NEVER halts: if nothing survives twice, escalate a layer (LADDER.md).
$ESCALATE
EOF
  exit 20
fi
cat <<EOF
🟢 CONVERGED — every machine gate is green; nothing is legitimate to ship.
   Lab verdicts recorded: $NVERD. Era ends when the last 3 show no 'new-argument'.

▶ GEAR 3 — VIGIL. Do NOT ship and do NOT touch index.html.
  Watchdog first (a red gate re-opens Gear 1), then ONE focused lab investigation
  in lab/. Write the finding and the evidence — do NOT write its '**Verdict:**'
  line. An independent grader (separate process, different model) appends that
  after your tick, because an agent grading its own work always says it mattered,
  and an era whose every tick self-grades 'new-argument' never ends.
  Do NOT invoke the grader yourself either — leave the entry with no verdict and
  exit. Choosing your own scorer and writing its brief is the same conflict.
EOF
exit 10
