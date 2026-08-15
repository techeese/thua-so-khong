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
| `Gate 25` | 1 | elbow room — villagers do not print on top of one another: three villagers standing on one spot separate to ≥26px apart in the drawn frame, and `p.x` is provably unchanged, so the separation is draw-time only and the simulation never sees it (v0.45) |
| `Gate 26` | 1 | the hand that crosses a threshold says so — a bloomed person's per-verb hint reads `→ 360 ↑bậc 2` on the hand that lifts the product past a tier line the river can carry, plain `→ 360` when the river holds it, no arrow under the line (v0.45) |
| `Gate 27` | 1 | the middle hand misses too — Chú Ba at 9×3×2: a failure night (GAN 3, not his weakest) draws his answer in his own voice; a link (BẠN 2, the zero) draws none (v0.44) |
| `Gate 28` | 1 | the pot's price is printed — the hint carries the river's multiplier before → after and, when the dip would drop a tier cap, ↓bậc for N roofs; no tier warning when no roof would fall (v0.45) |
| `Gate 29` | 1 | speech has its own lane — with three stat floats up and no beat, chatter() still produces a speech bubble; with two speech bubbles up it still refuses (the two-slot rule counts speech, rate untouched) (v0.47) |
| `Gate 30` | 1 | an unread factor does not look like a zero — an unseen factor hatches its whole track instead of drawing width:0 (which was emptier than a factor genuinely at 1); revealing it at 1 removes the hatch and shows a real width (v0.47) |
| `Gate 31` | 1 | the roster's dots say which factor — the three touched/untouched dots carry the sheet's own factor colours (asserted equal to the `barTai`/`barGan`/`barBan` backgrounds, so roster and sheet cannot drift apart), filled for touched and hollow for not, in a lighter key on the selected chip (v0.48) |
| `Gate 32` | 1 | the partner's gain is on the chip — with Kết nối armed, each candidate's roster chip reads +2 BẠN (no bonds yet) or +1 BẠN (already bonded); disarmed, no gain shows (v0.52) |
| `Gate 33` | 1 | a ceiling is not an empty hand — a verb switched off because its factor stands at 10 names the ceiling and promises no delta, keeps that face when the hands also run out, and is visually distinct from a verb merely unaffordable; bilingual (v0.52) |
| `Gate 34` | 1 | every GAN move prints — an erased stall floats −3 GAN ⬛ on its owner, a stepped-down shop −2 GAN ⬛, and finishing your own roof +1 GAN 🛠 on everyone you have met (v0.51) |
| `Gate 36` | 1 | a partial row prints its bound — with one factor seen the sheet says trần ≤ ceilOf(it), the hand on the lowest seen factor says the bound it would reach, hands on unseen factors stay silent, and still no `→ N%` anywhere until the row is known (v0.53) |
| `Gate 35` | 1 | you can tap what you can see — at a true 390px the thumb target is ≥22 CSS px of radius and a real click dispatched at each villager's DRAWN position selects that villager; negative-tested by putting the hit test back on `p.x`, which misses 3 of 4 (v0.54) |
| `Gate 37` | 1 | the fate warnings do not tell — Bé Ngân's season-9 line (and Cô Liên's at 11) names the factor in the log only if it has been touched; untouched, the log states the fact and the person's bubble stays the clue (v0.54) |
| `Gate 38` | 1 | mechanic state survives a refresh — a guess-answer already given and the circle's first-time line round-trip through save/load; an older save without the fields loads them unset, not as garbage (v0.55) |
| `Gate 39` | 1 | a card taller than the window still has a way out — at a true 390px and three viewport heights (673/533/433) the ending card's `Chơi lại` button is reachable by scrolling the overlay; it was unreachable at the two short heights before, the overlay having no scroll at all (v0.56) |
| `Gate 40` | 1 | the print fits a phone held sideways — in landscape the canvas is capped at ≤72% of viewport height (the stylesheet's 70vh intent, which `fit()`'s inline height had been silently overriding since it was written), aspect preserved so nothing crops, and in portrait/desktop it still fills its container's width (v0.57) |
| `Gate 41` | 1 | witnessed courage stops at 5 — when a neighbour blooms, a known person at GAN 4 rises to 5 (float printed), a known person at GAN 5 stays 5 (no float), an unknown person is untouched (v0.57) |
| `Gate 42` | 1 | the year no one dared — with constraint 4 tied the failure night is refused (no hand, GAN unchanged, button struck through), the intro offers the fourth tied hand, a save carries it back; without it the failure night works (v0.58) |
| `Gate 43` | 1 | Reduce Motion is obeyed by the print — with `prefers-reduced-motion: reduce` the drifting petals, rain streaks, bloom confetti and idle bob all stop (0/0/0/0.0) while the motes keep flying, and without it they all still run; asserted by running the same probe under both settings (v0.59) |
| `Gate 44` | 1 | the keyboard can see where it is — focus draws a 3px ring in the xóm's own ink with a paper halo, inverted to paper-on-ink over the red button and the selected chip; every roster chip is Tab-reachable (was 0 of 6, plain divs) and Enter on a focused chip picks that villager (v0.60) |
| `Gate 45` | 1 | every word on the page is readable — walks the live DOM pairing each text node's computed colour with its effective background and measures WCAG contrast; zero failures required (five were failing when written, the worst at 2.89:1). Guards the palette against a future colour change that makes text unreadable (v0.61) |
| `Gate 46` | 1 | a tied hand is named at the ceiling — when the factor that caps a known row is this year's tied hand, the sheet says "tay ấy bị trói năm nay"; with no tie the line ends at the percentage (v0.61) |
| `Gate 47` | 1 | the ladder has a top — the tier pill reads N/21 with the whole xóm present, N/22 once your own stall stands, N/18 after a neighbour has left; the left number is the live tierSum (v0.63) |
| `Gate 48` | 1 | a name is never buried by a body — with villagers staggered down the bank (the arrangement the elbow-room nudge does not touch), every label is painted after every body: asserted by paint order, not geometry, and non-vacuous (at least one body-overlap must exist). 4 of 4 were buried before, including a ×0 zero-tag (v0.63) |
| `Gate 49` | 1 | a paid forecast prints next season's odds — clear sky today with the forecast read: a young roof reads ⬛ 15% mùa tới, an established one ⬛ 5% mùa tới; unread, nothing; a heavy sky today still says mùa này (v0.65) |
| `Gate 50` | 1 | the ending title never runs under the stamp — measured on the title's LINE BOXES (not the full-width h2 box, which always spans the seal) at card widths 288px and 520px in English: zero overlap. Was 51×24px on the narrow card and 6px even on the wide one (v0.65) |
| `Gate 51` | 1 | the risk is beside the raise — a known un-bloomed row with a raised factor prints the fade odds (35 %/mùa; 18 in the quiet-hands year, 50 in the restless wind); an unraised row and a bloomed row print none (v0.67) |
| `Gate 52` | 1 | Aa reaches the print — with larger text on, the canvas fonts grow by the same factor the DOM does (±0.15) and both sit at base size with it off; a canvas cannot be reached by CSS, so the villager names and ×0 tags had been left behind by the control meant to help read them (v0.67) |
| `Gate 53` | 1 | a hand the year tied says so — a verb banned by the year's constraint names the constraint (`🚫📖 năm không dạy` / `the no-teaching year`) instead of advertising a `+2` it cannot deliver, in both languages and for the right constraint per verb; all four verb states (live · unaffordable · at its ceiling · tied) stay distinguishable (v0.68) |
| `Gate 54` | 1 | the tier climb shows in the ledger — a season in which a bloomed roof's product crosses 300 ends with a divider carrying 🪜+1, and a season with no tier movement carries none (v0.68, `/loop 3m`; row added by the graphics loop after finding the gate present in `gate.sh` but absent here — `done.sh` only checks ledger→gate.sh) |
| `Gate 55` | 1 | the pot names what stops it — the no-hụi year reads `🚫🪙 năm không hụi` and an unpaid circle reads `chưa góp hụi — góp rồi mới hốt được`, instead of both falling through to the generic `🌱 +6% · 1⚡` the button cannot deliver; bilingual, and the eligible state still shows its answer (v0.69) |
| `Gate 56` | 1 | hụi and nghe ngóng name what stops them — 🪙 Góp hụi in a no-hụi year reads `🚫🪙 năm không hụi` and 🔍 Nghe ngóng once used reads `mùa này đã nghe`, instead of quoting a price they cannot honour; bilingual, and the working and already-covered states are untouched (v0.70) |

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
- **Gate 24 (v0.47):** extended from the Sổ tay alone to **every vertical strip on the shared
  `edgeFadeY` helper** — the log now asserts the same three states (bottom edge only at the top, both
  in the middle, top edge only at the end). Old: the Sổ tay's body and its always-visible exit. New:
  that, plus the log strip, which keeps 24 lines, shows about four and taps open to a page while
  `cursor:pointer` was its only affordance. Every prior clause kept.
- **Gate 23 (v0.48):** now also asserts the established roof reads 🛡 0% after the hand and that the real coverable count is 2 (shelter tarps every standing roof, not only young ones).
- **Gate 21 (gate repair, 2026-08-15):** the subject's own bloom roll is pinned to 0 during the two lift
  seasons (`chance` wrapped for Ba only, restored after) so `lifted` can no longer read false on a 4 % die.
  Old: the same six assertions, flaking about one run in 25. New: the same six assertions, deterministic
  for the subject; every other roll in the season stays live. Negative-tested: with every roll forced to
  land the unpinned probe fails exactly as observed and the pinned one passes.
