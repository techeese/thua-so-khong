# GATES LEDGER — the ratchet

**Append-only. Gates may be added. Gates may never be removed or weakened.**

This is what makes an autonomous, self-modifying loop safe to leave running. A transition rewrites
`done.sh` — the loop's own definition of success — and a loop free to relax its own standard will,
over enough eras, relax it to nothing. The ratchet makes *easier* structurally unavailable: every
era can raise the bar, none can lower it.

`done.sh` verifies this ledger on every tick. If an entry here no longer exists in `gate.sh` or
`done.sh`, every gate fails and the loop drops to Gear 1 to restore it.

Rules:
- A new gate is appended with the era that introduced it and what it protects.
- **Removing an entry is never a valid change.** Not to simplify, not to refactor, not because a
  gate "no longer applies." If a gate is genuinely obsolete because the feature it guarded is
  gone, mark it `RETIRED — <era> — <why>` and leave the line. Retirement is the owner's call.
- A gate may be made *stricter* freely. Record the tightening.

---

## Release gates — `gate.sh`

| id | era | what it protects |
|---|---|---|
| `Gate 0` | 1 | the thesis band: diagnosis beats spreading beats idling — the multiplication in executable form |
| `Gate 1` | 1 | every script block parses |
| `Gate 2` | 1 | fresh headless run: talk, act, link, 4 seasons, no JS errors |
| `Gate 3` | 1 | a poisoned save is sanitized, not fatal |
| `Gate 5` | 1 | full 16-season playthrough VI and EN — ends, chronicle written, zero errors |
| `Gate 6` | 1 | the xóm has a voice — a PACED run must actually produce ambient bubbles (v0.28) |

## Convergence gates — `done.sh`

| id | era | what it protects |
|---|---|---|
| `charter-lock` | 1 | `CHARTER.md` matches `CHARTER.lock` — the loop cannot rewrite what the game is for |
| `gates-ledger` | 1 | every entry in this file still exists and still runs |
| `release-gates` | 1 | `gate.sh` is green |
| `tree-clean` | 1 | no work stranded uncommitted |
| `pushed` | 1 | `origin/main == HEAD` |
| `checkjs-fresh` | 1 | `check.js` not stale against `index.html` math |
| `bilingual-parity` | 1 | every player-facing string carries VI and EN |
| `live-equals-repo` | 1 | the deployed version string matches the repo — a push is not a ship |
| `no-open-directives` | 1 | an owner note in `OWNER-GATE.md` forces Gear 1 and cannot be ignored |
| `loop-structure` | 1 | the engine stays mechanism-only and every loop document is tracked in git |

## Proxy gates — measurable stand-ins for felt questions

Added when an era proposes a measurable correlate for something only a human can truly judge.
**A proxy is added alongside its felt question, never in place of it.** The felt question stays
open in `OWNER-GATE.md` forever, so the honest version of the answer is always still available.

| id | era | proxies which felt question | threshold |
|---|---|---|---|
| *(none yet — era 2 candidates in `SYNTHESIS.md` will propose the first)* | | | |

---

## Tightenings

Record here when an existing gate is made stricter, with the old and new threshold.

- *(none yet)*
