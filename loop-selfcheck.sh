#!/bin/bash
# loop-selfcheck.sh — is the loop's own structure still sound?
#
# Checks the SEPARATION, not the game. The engine (the skill) must contain mechanism only; every
# project fact must live here in the repo, in git. Without a test, that boundary erodes one
# convenient sentence at a time.
#
# exit 0 = structure sound.

set -u
cd "$(dirname "$0")"
SKILL=/Users/Admin/Desktop/coding/.claude/skills/improve-thua-so-khong/SKILL.md
BAD=0
ok(){ printf '  ✅ %s\n' "$*"; }
no(){ printf '  ❌ %s\n' "$*"; BAD=1; }

echo "── loop structure ─────────────────────────────────────"

# 1. The engine must not know what the project is about.
if [ -f "$SKILL" ]; then
  # -w is load-bearing: a bare 'thesis' matches inside 'synthesis', which is engine vocabulary.
  # Same bug class as 'en:' matching 'green:' — see LANDMINES.md.
  HITS=$(grep -inwE 'xóm|thesis|đình|multiplication|villager|villagers|season|seasons|bilingual|chatter|index\.html|check\.js|hụi' "$SKILL" | grep -v '^[0-9]*:description:' || true)
  if [ -z "$HITS" ]; then ok "engine is project-agnostic (no domain vocabulary)"
  else no "engine contaminated with project facts — move these to the repo:"; printf '%s\n' "$HITS" | head -6 | sed 's/^/       /'; fi
else no "engine not found at $SKILL"; fi

# 2. Every document the contract names must exist.
for f in CHARTER.md CHARTER.lock LOOP.md OWNER-GATE.md LANDMINES.md GATES-LEDGER.md \
         MILESTONES.md HISTORY.md CHANGELOG.md ROADMAP.md lab/NOTES.md done.sh gate.sh; do
  [ -e "$f" ] || no "missing document: $f"
done
[ "$BAD" = 0 ] && ok "all contract documents present"

# 3. The charter is locked and matches.
if [ -f CHARTER.md ] && [ -f CHARTER.lock ]; then
  [ "$(shasum -a 256 CHARTER.md | cut -d' ' -f1)" = "$(tr -dc 0-9a-f < CHARTER.lock)" ] \
    && ok "charter lock matches" || no "charter lock MISMATCH"
fi

# 4. Everything the loop relies on is versioned. The engine is NOT (it lives outside any repo),
#    which is exactly why it must stay thin and why lessons belong in the repo.
UNTRACKED=$(git ls-files --others --exclude-standard -- CHARTER.md LANDMINES.md GATES-LEDGER.md HISTORY.md 2>/dev/null)
[ -z "$UNTRACKED" ] && ok "loop documents are tracked in git" \
                    || no "untracked loop documents (they must be in git): $UNTRACKED"

# 5. Lab entries must carry a verdict — era exhaustion is measured from these.
if [ -f lab/NOTES.md ]; then
  ENTRIES=$(grep -c '^## 20' lab/NOTES.md 2>/dev/null); ENTRIES=${ENTRIES:-0}
  VERDICTS=$(grep -c '^\*\*Verdict:\*\*' lab/NOTES.md 2>/dev/null); VERDICTS=${VERDICTS:-0}
  if [ "$ENTRIES" -le "$VERDICTS" ]; then ok "every lab entry carries a verdict ($VERDICTS/$ENTRIES)"
  else no "$((ENTRIES-VERDICTS)) lab entr(ies) missing a '**Verdict:**' line — exhaustion cannot be measured"; fi
fi

echo
[ "$BAD" -ne 0 ] && { echo "🚫 LOOP STRUCTURE BROKEN — fix before the next tick."; exit 1; }
echo "🟢 LOOP STRUCTURE SOUND."
