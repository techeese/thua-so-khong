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
| `Gate 7` | 1 | the zero bites — a factor at 1 reads 0% on the sheet and in the per-verb hints and cannot bloom until raised (v0.30) |
| `Gate 8` | 1 | capital is a factor — the same person sprouts ~2.7× likelier on a full river than a thin one; a 640-product workshop is a stall at river ≤3, a shop at ≤6, a brand only when the water is high (v0.31) |
| `Gate 9` | 1 | the print fits a phone — at a true 390px nothing outside the `overflow-x:auto` roster crosses the edge (`bodySW≤390`), no two speech bubbles print over each other however many neighbours talk at once, and the season banner scales with `LKF` like every other text on the block (v0.32) |
| `Gate 10` | 1 | the pot — hốt hụi pays one member from the river: river −1, that sprout +0.06 momentum, once a season, only after paying in, never past a zero, never below river 1 (v0.32) |
| `Gate 11` | 1 | the factors are hidden until touched — a fresh talk shows `? × ? × ?` and no per-verb answer, one hand on GAN reveals GAN alone, answers appear only once the row is known, a bloom shows everything (v0.33) |
| `Gate 12` | 1 | a hand in the wrong place gets an answer — teach Bé Ngân on her strongest factor while GAN sits at 1 and she says so in her own voice once, ~0.9s after the float; a second teach says nothing more; nerve (the zero) draws no such line (v0.34) |
| `Gate 13` | 1 | the names stay readable — six villagers jammed into 150px of the far bank produce no label printed over another villager's label and no label crossing the printed frame; overlap measured on the true ink box, not an estimate (v0.34) |
| `Gate 17` | 1 | the girl's clock — Bé Ngân with NERVE under 3 at season 11 walks to the road and is gone; with NERVE ≥3 she stays (v0.35) |
| `Gate 19` | 1 | the intro yields — while the intro card is up the xóm does not also point at a villager: the pulsing first-tap ring and its words are absent before Begin and back after it (v0.39) |
| `Gate 16` | 1 | the strip says it scrolls — on a 390px phone the roster is wider than its box, and the chips at a live edge fade into the paper: right edge only at the start, both in the middle, left edge only at the end (v0.36) |
| `Gate 14` | 1 | the TÀI zero walks — a low-TÀI neighbour picks the LEARN errand ≥20% of the time and it carries them to the most skilled pair of hands; a high-TÀI neighbour never picks it (v0.36) |
| `Gate 15` | 1 | strangers walk — with nobody yet spoken to, the errand governor still sends people on the road: the road precedes the label (v0.37) |
| `Gate 18` | 1 | the ceiling — the weakest factor caps a life: 10×2×10 at a full river sprouts ≤4 %/season, 10×3×10 ≤8 %, and the sheet names the capping factor; Gate 0 gains the capping assertions `chance(10,2,10)≤0.04`, `chance(10,3,10)≤0.08`, `tiers.maxer < 0.4·tiers.hunter` (v0.38) |
| `Gate 20` | 1 | the pot respects the ceiling — a row a 3 already caps refuses the pot and names the capping factor, a row with room takes it, and the hụi button prints what one coin does to the river's multiplier (v0.39) |
| `Gate 22` | 1 | the ending card owns the screen — with the card up, speech bubbles pushed behind it are cleared before they paint; with the card down the same push survives, so the guard is conditional (v0.40) |
| `Gate 21` | 1 | the world is honest about the ceiling and lifts BẠN — a sprout the ceiling binds gains no momentum over a season while one with room does; once you have paid into the hụi the circle raises the loneliest known neighbour's BẠN by 1 a season, never past 3, and not before (v0.40) |
| `Gate 23` | 1 | the law's number is printed — under a heavy sky a young roof's sheet says ⬛ 15% this season, an established one 5%, a tarped one 🛡 0%, nothing under a clear sky; the shelter button says how many roofs one hand covers (v0.42) |
| `Gate 24` | 1 | the Sổ tay keeps its way out — the heading and the Đóng button stay in view at every scroll position, and the body's live edge fades: bottom only at the top, both in the middle, top only at the end (v0.42) |
| `Gate 25` | 1 | elbow room — villagers do not print on top of one another: seeded overlap fraction ≤0.13 across three fixed seeds (v0.42 baseline 0.240). The first gate to drive BOTH `Math.random` and `performance.now` from the harness, so a before/after difference is real rather than dice (v0.43) |
| `Gate 26` | 1 | the hand that crosses a threshold says so — a bloomed person's per-verb hint reads `→ 360 ↑bậc 2` on the hand that lifts the product past a tier line the river can carry, plain `→ 360` when the river holds it, no arrow under the line (v0.43) |
| `Gate 27` | 1 | the middle hand misses too — Chú Ba at 9×3×2: a failure night (GAN 3, not his weakest) draws his answer in his own voice; a link (BẠN 2, the zero) draws none (v0.44) |

## Convergence gates — `done.sh`

| id | era | what it protects |
|---|---|---|
| `charter-lock` | 1 | `CHARTER.md` matches `CHARTER.lock` |
| `charter-lineage` | 1 | the live charter hash appears in `CHARTER-LINEAGE.md` — the loop may change the thesis at L4, but never unrecorded |
| `gates-ledger` | 1 | every entry in this file still exists and still runs |
| `release-gates` | 1 | `gate.sh` is green |
| `tree-clean` | 1 | no work stranded uncommitted |
| `pushed` | 1 | `origin/main == HEAD` |
| `checkjs-fresh` | 1 | `check.js` not stale against `index.html` math |
| `bilingual-parity` | 1 | every player-facing string carries VI and EN |
| `live-equals-repo` | 1 | the deployed version string matches the repo — a push is not a ship |
| `no-open-directives` | 1 | an owner note in `OWNER-GATE.md` forces Gear 1 and cannot be ignored |
| `no-open-defects` | 1 | a grader-classified defect forces Gear 1 — the loop's own licence to ship what it found |
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

- **Gate 0 (v0.38):** three capping clauses added — `chance({10,2,10},10) ≤ 0.04`, `chance({10,3,10},10) ≤ 0.08`, `tiers.maxer < 0.4·tiers.hunter` (a new anti-diagnosis strategy, *polish the strong*). Every prior clause kept.
- **`gates-ledger` (done.sh, v0.39):** the presence check now also asserts **id uniqueness** in both
  `GATES-LEDGER.md` and `gate.sh`. Old threshold: every ledger id must exist in `gate.sh`. New: that,
  plus no id may appear twice in either file. A duplicate passed the old check — the number *did*
  exist in `gate.sh` — while two rows silently claimed one gate. That happened **four times in a
  single tick** with two sessions allocating numbers concurrently. Negative-tested: an injected
  duplicate row fails the gate.
