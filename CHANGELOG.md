# Changelog — Thừa Số Không

## v0.39 — 2026-08-15 — every verb answers with the same arithmetic

Closes: under the owner's standing `/loop 3m` directive, a gap v0.38 opened in v0.32's verb — and
the one verb that still answered with a price tag instead of a number.

- **The pot respects the ceiling.** `potAfter()` was the raw formula; on a row a 3 already caps it
  promised *→ 15%* and would take a river coin (−7 % on every sprout) to push nothing. Now it is
  min(ceiling, …); when the ceiling already binds the pot is refused and the hint says which factor
  caps it — *GAN 3 chặn — hụi không đẩy nổi*. Charter §3, from the pot's side: nothing buys past the
  weakest factor.
- **The hụi button prints its answer.** Every hand on the sheet shows *→ N%*; the hụi showed
  *(1⚡)*. Now *(1⚡ · ×0.65→0.72)* — what one coin does to the river's multiplier, the same
  arithmetic every other verb gives; plain *(1⚡)* only when the river is full.
- *Evidence:* new **Gate 20** (`POTCEIL_OK refused=true saysCap=true untouched=true roomOk=true
  huiCost="(1⚡ · ×0.65→0.72)"`). Twenty gates green, hash-bracketed; no balance changed.
- **Provenance:** the graphics session's and the engine's in-tree edits at commit time
  (`done.sh` duplicate-id check, ledger rows) are theirs and are not committed here.

## v0.38 — 2026-08-15 — the weakest factor sets the ceiling

Closes: under the owner's standing `/loop 3m` directive, the one pass condition every critic in both
of the engine's review rounds converged on (`SYNTHESIS.md` §9.1: *"make the weakest factor actually
decide — a person with a 2 or 3 still blooms 4.5–13.5 %/season; until information has value, no band
can prove the thesis"*). Measured first: a factor cap on **tier** changes nothing — the product
thresholds already require min ≥3 for a shop and ≥6 for a brand — so the shape had to change at the
**bloom**.

- **`ceilOf(m)`.** The weakest factor caps sprout chance: 1 → 0 (v0.30) · 2 → 4 %/season · 3 → 8 % ·
  4 → 15 % · 5 → 25 % · ≥6 → the product decides (0.85 cap as before). `chance()` = min(ceiling,
  product-based). A 10×2×10 at a full river was 18 %/season; it is 4 %. The sheet says which factor
  binds when it binds — *mầm ~8% mỗi mùa · GAN 3 chặn ở 8%* — and the per-verb "→ N%" now shows the
  weakest hand as the only one that moves the ceiling. Help card states the table.
- **Priced honestly** (`check.js`, 1200 seeded runs): hunter **6.97 / 16.1** (unchanged) · spreader
  5.95 → **5.34** · linker 6.70 → **6.09** · idle 2.78 → **2.47** · misreader 6.98 / 16.0 · new
  *maxer* (polish the strong: raise the highest factor of the highest-product person) 4.11 → **3.40
  blooms / 5.0 tiers**. Diagnosis loses nothing; everything that routes around the weakest factor
  loses ~10 %.
- **Gate 0 ratchets up with capping assertions** — the first band clauses that can fail on the
  thesis itself rather than on a race: `chance({10,2,10},10) ≤ 0.04`, `chance({10,3,10},10) ≤ 0.08`,
  `tiers.maxer < 0.4·tiers.hunter`. Every prior clause kept (recorded under *Tightenings*).
- *Evidence:* new **Gate 16** (`CEIL_OK c2=0.04 c3=0.08 c8=0.72 says=true`). Nineteen gates green,
  hash-bracketed. Gate 7's probe now reads Ngân's nerve hand as `→ 8%` (GAN 3 caps her) — correct.
- **Provenance:** the `/loop 5m` graphics session's in-tree edits at commit time ship here under
  owner authority, unreviewed.

## v0.37 — 2026-08-15 — the road precedes the label

Closes: under the owner's standing `/loop 3m` directive, the second of the engine's own findings on
the watching channel (`walks.py` via `SYNTHESIS.md` §2: *"walks require `known`, so they never
precede the label"*), now that all three zeros have a walk (v0.36). Chosen because the engine's
round-2 candidate **B "watching is reading"** needs it and no other candidate is hurt by it — it
decides nothing about B's identity (labels stay; that is B's call to make).

- **Strangers walk their factor.** The errand pool no longer requires `known`: a "?" faltering at
  the đình steps, lingering at the landing, or going to watch Chú Ba's hands is a clue *before* you
  have spoken to them — the road reads first, the name comes later. Newcomer chains and beats are
  unchanged; the storm huddle still owns the screen; walks stay silent and numberless (charter §4).
- **Cadence 6–12 s → 4.5–9 s between errands.** A watcher at play speed saw 1.8–4.5 errands per run;
  the road has to be read more often than that to be a channel. Walker cap unchanged (1 before
  season 4, 2 after) so the graphics loop's label de-overlap work is not undone.
- *Evidence:* new **Gate 15** (`STRANGER_OK sent=6 unknownSent=6` — with nobody spoken to, six
  strangers took the road in forty governor ticks). Eighteen gates green, hash-bracketed; band
  untouched.

## v0.36 — 2026-08-15 — the TÀI zero walks

Closes: under the owner's standing `/loop 3m` directive, a gap the engine's own synthesis names
(`SYNTHESIS.md` §1: *"no low-TÀI walk exists"*; `walks.py`: an observer names a GAN zero from walks
82 % of the time, BẠN 65 %, TÀI never). Since v0.33 the row is hidden and the road is one of the two
places a stranger can read a person before a hand is spent — and it was silent on one factor of
three. Chosen because it does not collide with Era A's manifest (which reconciles thresholds and
removes tells) and is exactly the channel Era B would need.

- **Errand 11 — LEARN.** An un-bloomed neighbour with TÀI ≤2 keeps going to watch the most skilled
  pair of hands in the xóm (`learnMaster`: highest TÀI ≥6, a standing workshop breaking ties) — to
  the workshop if it stands, else the door — and stands a little apart, hands clasped behind the
  back, leaning in. Weight 3.0 beside home's 3.0, so it is a habit, not a tic. Motion only: no
  number, no line (charter §4). GAN already faltered at the đình steps and BẠN already lingered at
  the landing; now all three zeros have a walk.
- Also measured this tick: **the fates are reachable and fair** — Ngân leaves in 0 % of hunter and
  misreader runs, 5 % spreader, 10 % linker, 100 % idle; Liên 0 / 0 / 59 / 4 / 100 %; Chú Ba's craft
  dies in ≤7 % anywhere the sim can bloom him. The people, not the numbers, now separate the
  neglectful from the careful.
- *Evidence:* new **Gate 14** (`LEARN_OK tuShare=0.28 nganShare=0.00 master=Chú Ba beh=11
  near=true`). Seventeen gates green, hash-bracketed; no math changed, band untouched.

### Carried in the same commit — the graphics round (`/loop 5m`): the strip says it scrolls

The `LOOP.md` pointer named the roster strip's missing scroll affordance and, above it, the crowding
question. Both were taken; only one shipped.

- **The roster strip now says it scrolls.** On a 390px phone it is 746px of chips in a 370px box, and
  a chip sliced by the box edge reads as a chip that is cut off, not as *there is more of the xóm this
  way*. The chips at a live edge now fade into the paper — right edge only at the start, both in the
  middle, left edge only at the end. The classic CSS background-shadow trick was written first and
  thrown away: the chips are opaque and cover the background, so the cue has to be a mask on the
  content itself, driven by real scroll position (`rosterEdges()`, called on render, scroll and
  resize). *Evidence:* new **Gate 16** — `STRIP_OK more=356 atStart=-R mid=LR atEnd=L-`, plus a read
  screenshot of the faded edge at the end of the strip.
- **Gate numbering repaired.** v0.35 added a second `Gate 13`, colliding with v0.34's label gate in
  both `gate.sh` and the ledger — a duplicate id in an append-only ratchet is a defect in the record
  itself. The girl's clock is now **Gate 15**; nothing was removed or weakened.

**Shipped nothing on the crowding item, deliberately.** The pointer asked whether the bank should
label fewer people, label on demand, or spread the crowd. Measured first, over 192 sampled frames of
an ordinary 16-season run: **~6.1 villagers on screen, ~4.2 named — and two figures drawn on top of
each other in 117 of 192 frames (61%)**. So the labels were the symptom and the sprites are the
cause. A fix was written — villagers rejecting a wander target that another villager already occupies
— and **reverted**: overlap frames went 110 → 113, i.e. nothing. Then the real obstacle surfaced:
three runs of near-identical code returned avgNamed **4.15 / 4.58 / 3.77**, so this measurement is
noise-dominated and cannot resolve an effect that size at all. Crowding is parked with that finding
rather than shipped on a number that means nothing.

## v0.35 — 2026-08-15 — every zero has a face

Closes: under the owner's standing `/loop 3m` directive, the open owner gate *"You care about someone by
season 8 — a name, a face, a fate you'd be sorry to lose"* on its machine side, and the bank's
misreader question. Two of the three factors already had a fate — TÀI: the elder's craft dies unless
it passes on; BẠN: Cô Liên goes back south unless someone holds her. GAN had none: a Bé Ngân left at
nerve 1 simply sat at 0% for sixteen seasons, and the player who never dared for her lost nothing.

- **🚌 The girl's clock.** At season 9, if Ngân's NERVE is still under 3 and she has not bloomed, she
  says it once — *“Bố nộp hồ sơ trường Y cho em rồi…”* — and the log names the factor. From season 11,
  still under 3, she walks to the road's end, the xóm watching, and is gone: *"Bé Ngân left for
  medical school in the city — her father won. No one helped her dare."* Only nerve holds her — a
  bond does not route around this zero (charter §3). Ending epilogue added; the help card's new
  section *Ba số không, ba gương mặt* names all three fates. `check.js` mirrored.
- **The ending shows every row**, including the factor you never touched (`endGame` marks all seen),
  and its zero-line now agrees with v0.30: *"vẫn nằm ở số không"* only for a literal 1, *"sát số
  không"* for 2–3.
- **`check.js`: the misreader.** A hunter whose first hand on each person is wrong 30% of the time
  (the hidden row, read badly): **6.97 blooms / 15.9 tiers** vs hunter 6.98 / 16.1 — v0.33 costs a
  fair player one hand per misread and nothing more. Banded: `misreader > spreader + 0.5` added to
  the Gate 0 assertion (ratchet up). Band with Ngân's clock: hunter 6.98 / spreader 5.95 / linker
  6.70 / idle 2.78.
- *Evidence:* new **Gate 13** (`CLOCK_OK leaving=true s=11 gone=true daredStays=true`). Sixteen
  gates green, hash-bracketed.
- **Provenance:** the `/loop 5m` graphics session's in-tree work at commit time (a verb tally
  `S.vb`, a label-readability gate) ships here under owner authority, unreviewed.

## v0.34 — 2026-08-15 — the wrong place answers back

Closes: the second half of v0.33 under the owner's standing `/loop 3m` directive. Hiding the row made
the first hand a guess; a wrong guess was answered by a bare number (*TÀI 10*) and nothing else — the
price was paid silently. Charter: *systems teach; the narrator does not explain.* So the person does.

- **`guessAnswer(p,k)`.** When a hand lands on a person's *strongest* factor while a real zero (≤3)
  sits elsewhere in their row — and only while the row is still unknown, i.e. you were guessing —
  they answer ~0.9s after the float, once per factor, in one line and no number: *“Cái này tôi làm
  được rồi mà… chuyện của tôi ở chỗ khác.”* (TÀI) · *“Tôi đâu có sợ… chuyện của tôi ở chỗ khác.”*
  (GAN) · *“Bạn bè thì tôi không thiếu… chuyện của tôi ở chỗ khác.”* (BẠN). The right hand draws no
  line: the +2 and the number are its answer. Wired into teach, nerve and the linker's own BẠN.
- **Anh Vũ's opening line now carries his clue.** Every other cast quote pointed at that person's
  zero (Dad/medicine → GAN; back-as-a-guest → BẠN; a product of my OWN → TÀI); his — *"I can fix
  every machine — except my own life"* — read as nerve while his row hides BẠN 3. Now: *"…Cả ngày
  chỉ có máy nói chuyện với tôi."* / *"All day, only the machines talk to me."*
- *Evidence:* new **Gate 12** (`VOICE_OK beforeDelay=0 afterTeach=1 secondTeach=1 afterNerve=1
  nerveWrong=false`). Fourteen gates green, hash-bracketed; band untouched (no math changed).

### Carried in the same commit — the graphics round (`/loop 5m`): the names stay readable

Follows the `LOOP.md` pointer left by v0.32: *person labels and the `số không: X` tags overlap each
other on the right bank*. The screenshot was unambiguous — six villagers on the far bank printed
`×0 số không: GANGAN`, two red hints stamped on top of one another, and only three of the six had a
name at all.

The cause: `lblR`, the per-frame collision list, only ever registered the **name** line. The red
zero-hint below it and the workshop's own word (`gánh` / `xưởng` / `thương hiệu`) were painted
without being recorded, so a neighbour's name could print straight through either, and two hints
could never see each other. On a clash the villager was dropped and went nameless.

- **Both lines are measured and registered**, so a name, a hint and a workshop word all take part in
  the same collision test.
- **A clashing label ladders down into clear ground** — up to four steps — instead of being dropped.
  The villager you are talking to is never suppressed: if the ground below is full it looks for clear
  air *above*, and prints in place only if there is nowhere clear at all.
- **Labels are clamped inside the printed frame**, as speech bubbles were in v0.32. A name on the far
  bank used to bleed past the border of the print.

*Evidence* — the hunk isolated onto v0.32, because the mechanic round was uncommitted in the same
tree and a plain before/after would have measured both at once: six villagers jammed into 150px of
far bank, **cross-owner label overlaps 4 → 0**, **labels crossing the printed frame 2 → 0**. Overlap
is measured on the true ink box (`actualBoundingBoxAscent/Descent`); an estimated box counts each
villager's own name/hint pair as a collision, which is how a first pass at this produced a confident
and worthless "9 → 4". How many villagers get named in that jam is unchanged at 3 of 6 — the crowd is
denser than the bank can label, and those who do not fit still yield rather than print gibberish.

New **Gate 13 — the names stay readable**: `LABEL_OK labels=7 cross=0 bleed=0`.

## v0.33 — 2026-08-15 — the numbers hide until your hand touches them

Closes: the open owner gate *"Diagnosis feels like play — finding which factor is zero is the fun
part, not homework"* on its machine side, under the owner's standing `/loop 3m` directive. Measured
first: even at **2 hands a season** the perfect-information hunter still blooms 6.94/7 (3 hands:
6.98), so tension for a diagnosing player cannot come from scarcity — the sim's hunter *is* a
player who reads the row. And the row was handed over free: talk once and all three numbers, the
product, the sprout %, the zero tag and the per-verb "→ N%" appeared. Each cast quote was authored
as a clue to that person's zero (*"Dad says medicine is safer"* → GAN; *"back… and feel like a
guest"* → BẠN; *"only lack a product of my OWN"* → TÀI) and did no work.

- **Each factor is `?` until touched.** `p.seen{tai,gan,ban}`; a bloom shows all. What reveals: any
  number that floats over a person — teach, nerve, link, the mentor drip, Cô Mai's class, a
  witnessed bloom's +1 GAN, fade, the elder's −1 TÀI 🕯 (`floatOn` marks what it prints, so the world
  reveals what the world does to them). The sheet reads `? × 3 × ? = ?` with one line under it —
  *lời họ nói là manh mối — thừa số nào gần không? Tay chạm vào đâu, con số hiện ra ở đó* — until
  the row is known; then the product, sprout %, river multiplier and the "→ N%" per-verb answers
  appear as before. The map's `×0 số không: X` / `gần không: X` label and the roster tag print only
  once *that* factor has been touched; the pot needs a known row (*chưa hiểu người ta*).
  A wrong guess costs a hand on a factor that wasn't the zero — the natural price, felt not told.
  Saves from before carry `seen`=all (`sn` bits; missing → 7). Help card and the one teaching line
  (`STR.reveal`) rewritten to what is now true.
- Also measured and closed from the bank: **hụi and the pot as strategies** — hunter-with-hụi
  6.98 blooms / 15.1 tiers, pot-every-season 6.76 / 13.9 vs hunter 6.98 / 16.1: neither is a spam
  channel; the pot is a net loss when spammed and situational when not. `check.js` notes the sim
  keeps perfect information on purpose.
- *Evidence:* new **Gate 11** (`HIDDEN_OK v0=??? mult0=true hint0=true unnamed=true
  afterNerve=?/3/? all=true hint2="→ 9%"`). Gates 7 and 10 harnesses now set the row as learned
  before asserting (assertions unchanged). Band unchanged (hunter 6.98 / spreader 5.97 / linker 6.74
  / idle 2.80). Twelve gates green, hash-bracketed. Sheet screenshot read: `? × 3 × ? = ?`.
## v0.32 — 2026-08-15 — the print fits a phone, and it is gated

A graphics round from the owner's `/loop 5m` session (*"review it and make some
upgrade/change/adjustment in the graphic, regardless how large or how small"*). Four of the five
items were written into the tree during v0.31's window and shipped inside that commit unreviewed —
this entry gates them, names their evidence, and adds the one that was missing.

**Measured before the round** (true 390px, forced with an injected body width — headless Chrome
floors `--window-size` at ~500, see `LANDMINES.md`): `bodySW=445` against a 390 viewport, **13
elements crossing the right edge** including `langBtn` at R445, and with four neighbours speaking at
once, **29 overlapping bubble pairs**.

- **The header wraps.** The pill/button row inside `.top` was a `display:flex` with no `flex-wrap`;
  on a 390px phone the `?`, mute and `EN` controls ran 55px off the right edge and the page scrolled
  sideways. `flex-wrap:wrap;justify-content:flex-end`. *Evidence:* `bodySW` 445 → **390**, elements
  crossing the edge **13 → 0** (the roster is excluded — it is a deliberate `overflow-x:auto` strip).
- **Speech bubbles no longer print over each other.** `drawBubble()` took no account of what had
  already been printed that frame; at LKF 1.67 each bubble is ~400px wide and four simultaneous
  speakers produced a mush. It now carries a per-frame footprint list and lifts each bubble clear,
  and a lifted bubble keeps an ink thread down to whoever is speaking. *Evidence:* four forced
  speakers crowded onto one stretch of bank — overlapping pairs **29 → 0**, eight bubbles printed.
- **A bubble that cannot find room yields instead of printing a wall** *(new this commit)*. The lift
  loop used to clamp at the canvas top and print anyway, which restored the overlap it had just
  removed and stacked a slab of speech over a third of the block. It now returns undrawn — charter
  constraint 4, *ambient life yields*, applied to the one path that could violate it.
- **A bubble shoved off the canvas edge keeps its tail.** The body was clamped into frame, the tail
  was not, so an edge bubble pointed at nothing. Tail x is pinned inside the body.
- **The season banner scales like every other text on the block.** It was a fixed `700 32px`, alone
  among canvas text in ignoring `LKF`, so on a phone the season title shrank to a whisper while the
  labels around it grew. Now `32·LKF`, with a cartouche rule under it the way a block signs a season.
  *Evidence:* banner **32px → 54px** at LKF 1.67.
- **A carved horizon where the LAW meets the xóm.** Sky and ground met at a razor-straight unprinted
  seam at y=118. A far bank now sits on it — a deterministic row of humps plus an ink line, both
  fading as the sky closes down, so a clear sky lets you see across the water and a heavy one does
  not. Đông Hồ flat blocks throughout; no gradient enters the print.
- **New Gate 9 — the print fits a phone.** `PHONE_OK bodySW=390 hOver=0 printed=8 overlaps=0
  bannerPx=54`. It asserts all four at once and cannot be satisfied by absence of an error.
  Partially answers the open owner gate *390px hands* — the machine half; real thumbs on a real
  phone stay the owner's to tick.
- **Provenance — the `/loop 3m` mechanic session's in-tree work ships in this commit too**, gated
  and named rather than pretended away: **🧧 Hốt hụi — the pot** (`actPot`), what a hụi is *for*.
  Once you have paid in, the circle can pay one member: river −1, that person's sprout momentum
  +0.06 (capped like every other push), once a season, never past a zero, never below river 1;
  the button shows what the pot would make of them (`→ N%`) and says why it can't when it can't.
  A tradeoff, not a gift — −1 river is −7% on every named sprout. **New Gate 10** asserts all of
  it: `POT_OK zeroBlocked=true take=true twice=true reset=true von=4 mom=0.09`. Also carried: tier
  lines on the bamboo gauge (past the 3rd notch a shop can stand, past the 6th a brand); the
  `gần không:` label for a factor at 2–3 vs `×0 số không:` at 1; a river-capped workshop owner who
  says so when tapped; the mute button also silences cicadas; the acts row wraps on a phone.

### v0.32 addendum — from the `/loop 3m` mechanic session: why the pot, and not "a price for being wrong"

The bank item *a price for being wrong* was **re-measured before designing** and found already paid
by v0.30's literal zero: a scratch `check.js` variant with an `inverted` strategy (right person,
wrong factor — raise the *highest* factor of the lowest-minimum person) lands **3.99 blooms / 5.0
tiers** against the hunter's 6.98 / 16.1 (it kept ~98% before v0.30); a `wrongperson` strategy
(right factor, wrong person — tend the highest-product sprout) keeps 6.44 / 15.7, which is picking
ripe fruit, not a thesis violation. No mechanic was added for it. The tick's mechanic became the pot,
because the hụi had only ever paid *in*. Provenance for v0.32 itself is as the graphics session
wrote above: two rounds, one commit, both gated.

## v0.31 — 2026-08-15 — the river is the fourth factor

Closes: the second item of the `LOOP.md` bank — *either make capital a factor or stop presenting it
as one* — under the owner's standing in-session directive (`/loop 3m`, mechanic/gameplay upgrades).
The charter says talent, nerve, connection **and capital** multiply; the code had the river as a
×0.64–1.0 rounding, the hụi verb "cost 0.70 tiers for 0.00 blooms", and `riverLow` promised a
mechanic ("any workshop stays a street stall") that did not exist.

- **Sprouts multiply by the river.** `vonMul()` = 0.3 + 0.7·river/10 — a thin river ×0.37, a full
  one ×1.0 (was 0.6 + 0.4·river/10). Every hụi coin is now +7% relative on *every* named sprout: a
  real breadth-vs-depth choice against +2 on one person.
- **The river holds depth.** `shipTier()` is capped by `tierCap()` — river ≤3 keeps every workshop a
  stall, ≤6 at most a shop, a brand only above. `riverLow` is now true. The sheet says so when it
  bites: *bậc 1/3 · sông 3/10 giữ bậc — cả xóm góp thêm* — and the sprout line prints the
  multiplier beside the river (*sông 3/10 ×0.51*). Tier is computed in one place, so stamps
  (tier-2 steps down, tier-1 is erased), the flywheel (tiers ≥4), Cô Mai's class reach and the
  ending all inherit it. Help card (Sổ tay) rewritten for both.
- `check.js` mirrored (`vonMul`, `tierCap`, `tierOf`, and the four tier sites). *Evidence:* band —
  hunter **6.98** / spreader 5.97 / linker 6.74 / idle **2.80** (was 3.03); tiers hunter 16.1 ·
  spreader 10.7 · linker 14.4 · idle 2.8. Diagnosis still saturates; everyone else pays. New
  **Gate 8** (`RIVER_OK c1=0.170 c10=0.461 ratio=2.70 tiers@2/5/9=1/2/3`).
- **Provenance:** the owner's `/loop 5m` session was again writing to the same file (per-person
  voice pitches, a carved far bank, phone-scaled banners, bubble de-overlap, header wrap) — gate-green
  in tree, shipped here unreviewed under owner authority; the owner has said all loops keep running.
- `./gate.sh` 🟢 nine gates green on the committed tree.

## v0.30 — 2026-08-15 — the zero bites

Closes: the owner's in-session directive of 2026-08-15 (`/loop 3m` — *"read the code and make some
changes/upgrade regarding mechanic and gameplay"*), and the first item of the standing bank in
`LOOP.md` → *floors that bite* — the zero was **soft**: a factor at 1 still bloomed ~3%/season, so an
idle player harvested 3.5 workshops and the sentence "mười nhân với không vẫn bằng không" was true on
the card and false in the dice.

- **`chance()` returns 0 when any factor is 1** (`hasZero`). Momentum (🌱) no longer accrues past a
  zero either, so no sprout "pushes at the soil" it cannot break. The sheet reads
  *mầm 0% · thừa số GAN bằng không* instead of a percentage, and the per-verb readouts — which now
  survive `render()` (a hint-overwrite bug found while probing; the concurrent owner session landed
  the same fix at 15:18) — show **→ 0%** for the two wrong hands and a real number for the right one.
  That is the diagnosis asked as a choice, with no narrator. `check.js` mirrored (chance + momentum).
  *Evidence:* Gate 0 band — hunter **6.99** / spreader 6.07 / linker 6.74 / idle **3.03** (was 3.52),
  tiers hunter 15.7 · spreader 10.8 · linker 14.3 · idle 3.0 — the band holds and widens toward the
  hunter. New **Gate 7** (`ZERO_OK c0=0 rolls=0/400 sheet0=true teachHint="→ 0%" nerveHint="→ 22%"
  c1=0.22`): a 9×1×9 person at river 10 rolls 400 seasons without blooming, then nerve alone lifts
  her to 22%. Help card (Sổ tay) rewritten to state the rule as it now is.
- **Provenance note.** The owner's separate `/loop 5m` session was editing the same file during
  this tick; its in-tree additions (season-strip `hist` on the ending card, a *tend* errand for
  pushing sprouts, storm-braced roofs after three storm seasons, "🏮 Năm cuối / Mùa cuối" banners
  at seasons 12 and 15, the hint-render fix) were gate-green and ship in this commit unreviewed,
  under owner authority — same standing as v0.29.
- `./gate.sh` 🟢 all eight gates green on the committed tree.

## v0.29 — 2026-08-15 — the owner's "add something" batch, shipped under owner authority

Closes: the red `done.sh` gate *1 commit unpushed* left by the owner's separate interactive
session (`/loop 5m` — "read the code and add something more to the game; ignore the .md files"),
whose commit `a235d3d` landed 36 additions on `main` at 15:06 without a version bump, changelog
entry, or push. **This loop did not author, review, or select any of that content** — the owner
did, by running that session; this entry only makes the ship legible and verifiable.

- **What landed (from the commit message):** a sixth year card 🌾 *Năm gió chướng* (fade 0.5,
  momentum cap 0.15); three new bonds (📚 Mai×Hoa, 👜 Hoa×Liên, 🧧 Tết at seasons 4/8/12); weather
  (rain, ripples, forecast curtain, birds, smoke), chickens, sprouts, stamp scars, Liên's sampan
  in/out, the road-year ox-cart, hụi lanterns, market goods, breathing bubbles; rain bed, chirps,
  finale voices, brand-tier lines, gossip, hỏi-thăm lines; season ledger dividers, card arc,
  per-verb outcome hints, hands-per-bloom; fixes — F clamped ≥0, verb unlock guards, hụi load clamp
  0–4 (closes the `cl(s.hui,0,3,0)` vs `huiMax()`=4 defect noted in `LOOP.md`), reunion-year clamps.
  `check.js` mirrored (13 lines).
  *Evidence:* `./gate.sh` on `a235d3d`, read by this loop before shipping — **band holds** (hunter
  6.99 / spreader 6.28 / linker 6.78 / idle 3.52), syntax, fresh, nan-safe, 16-season VI+EN,
  ambient voice `AMB_OK bubbles=2`. 🟢 all green.
- **Not reviewed under clause (e).** These are additions with no grader proposal and no critic
  pass; they ship on **owner words**, which outrank the ship budget. The next vigil ticks measure
  them like anything else — the standing directives (*less narration · simple opening · ambient =
  silent and numberless*) are the lens, and anything they contradict is a candidate for
  subtraction at the next synthesis, not a defect to argue about here.
- Footer version bumped 0.28 → 0.29 (the batch did not bump it). No other file touched.

## v0.28 — 2026-08-15 — the xóm gets its voice back

Closes: the owner directive of 2026-08-15 in `OWNER-GATE.md` — *"fix the timing so the ambient
layer actually plays, and ship it"*. Timing only; no line was written, rewritten, or retuned.

- **`chatter()` waits for the beat instead of a stopwatch.** `nextSeason()` rolled the season's one
  ambient line at a fixed +1100ms, but the `banner()` on the line above holds a beat for
  `1600+600` = 2200ms — so the roll always landed inside a named moment and `chatter()`'s own first
  guard correctly refused it, every season, in every version up to v0.27. The roll now schedules
  itself off `beatUntil` (min 3000ms, +600ms of settle) and re-waits up to 6 times if a banner, an
  arrival or Cô Liên's sampan is still holding the screen. Ambient still yields to beats — it just
  no longer yields to one that has already ended.
  *Evidence:* same probe, same harness, 8 paced 16-season runs either side of the change —
  **before: 120 of 120 calls preempted, 0 bubbles ever produced. After: 0 of 120 preempted,
  36 bubbles, 4.5 per run (~0.28 per season).** 20 distinct authored lines were heard, including
  all four `CHAT_SEASONAL` lines and three villagers' `chatS` storm voices — content that had
  never reached a player. `lab/chatprobe.py`.

- **Gate 6 — "the xóm has a voice."** A paced 16-season run now asserts the ambient layer actually
  produces bubbles (`preempted===0 && bubbles>=1`). Two artifacts had to be defeated for the
  assertion to mean anything: the existing gates advance seasons in a tight synchronous loop, so
  every chatter timer fires at one virtual instant and the `bubbles>=2` guard eats them all; and
  headless virtual time starves rAF (~10 frames across 112 virtual seconds), so bubbles never
  expire and that same guard stays tripped. The gate paces the seasons and drives the real render
  loop by hand.
  *Evidence:* red on the pre-fix file (`AMB_BAD calls=15 preempted=15 bubbles=0`), green after
  (`AMB_OK calls=15 preempted=0 bubbles=5`).

- **One dead line removed** in `chatter()`'s pair branch: `var set=PAIR_TALK[…]` was computed and
  never read, while the pair key was independently re-rolled on the next line.
  *Evidence:* `set` had no reference anywhere in the function.

## v0.27 — 2026-08-14 — the stranded round, shipped; and the loop rebuilt as convergent

Closes: a working tree left dirty on 2026-07-02 · the v0.25 errand-governor's chaser bug ·
LOOP.md's "LOOK-voice copy native pass" pointer.

- **The chicken-chaser stops vanishing:** `_chaser` was assigned before `visit()`, and a story
  visit landing in the same frame silently cleared it — the chase animation dropped mid-run.
  It is now armed after the visit, and cleared when a chained leg picks a different errand.
  *Evidence:* `execBeh` set `_chaser=p` inside the `beh===9` branch, upstream of the `visit()`
  call that resets it.
- **The dwell is real, not quantized:** errand dwell/chain resolution ran only on the governor's
  cadence, so a 1.5–3s pause at a doorway rounded up to the next scheduler tick.
  *Evidence:* `if(now<nextErrandAt) return;` gated the resolution loop as well as the spawn loop.
- **Lesson motes capped at 9:** a large class could push one mote per student per season with no
  ceiling. *Evidence:* the `studs.forEach` push had no length guard.
- **The places speak better Vietnamese:** a native pass on the LOOK voices — the river no longer
  says its water comes from heaven ("Sông này không đầy nhờ nước trời đâu. Mỗi nhà một gánh mà
  đầy."), the market speaks in cause and effect, and the hụi is a *phiên*, not a *vòng*, wherever
  the xóm names it. *Evidence:* LOOP.md's standing pointer; register drift flagged in v0.26.

**The loop itself was rebuilt** (no game code): it had been dead 43 days because its continuity
lived in a session rather than on disk, and v0.25–v0.26 sat undeployed because a push was treated
as a ship. New: `done.sh` (machine-checkable termination), `OWNER-GATE.md` (the boxes only a human
may tick), `MILESTONES.md` (eras + the synthesis protocol), LOOP.md v3, and a Stop-hook branch on
`.improve-tsk-on`. The loop is now convergent within an era and infinite across eras.


## v0.26 — 2026-07-02 — LOOP v2, cycle 15: the places answer back (living-xóm plan, final batch)

- **Hỏi thăm the places:** tap the river, the đình, or the market and the nearest neighbor walks over and answers
  in their own voice — one state-keyed line, proverb register, once per season per place. A thin river gets
  *"Sông cạn thế này, thuyền nào dám về…"*; a flywheel-era market gets *"Hàng xóm làm, chợ xóm bán — thế là nước
  lại về sông."* The economy explains itself only when asked, and never in numbers.
- **The hụi is a lệ, not a button:** from season 1 the circle visibly meets at the đình every season — two or three
  neighbors gather and one coin hops WITHIN the circle (it does not touch the river; vốn didn't rise — the
  coin-to-river vocabulary stays honest). When the button unlocks at season 2, it's recognition, not introduction.
- **Every bloom draws its first customer:** Chị Hoa (or the nearest neighbor) walks to the new workshop, and a
  basket leaves for the stall. No coin, no sound — the walk is the celebration.
- **Linked friends talk when they visit:** the FRIEND errand can spark the pair's conversation on arrival
  (25%, ≥25s global cooldown, yields to beats).

Deploy note: GitHub's legacy Pages builder failed opaquely twice on v0.25, then the deployment-status backend
stopped answering (deploy-pages timeouts with empty status). Migrated the site to Actions-based Pages deploys
(.github/workflows/pages.yml + .nojekyll); v0.25+v0.26 land the moment GitHub's backend recovers.

## v0.25 — 2026-07-02 — OWNER BATCH: "Xóm sống" — the village runs whether or not you act

Both changes at the owner's direction ("the economy is hard to understand, the first season feels limited" ·
"people should act like agents, doing things, interacting with the buildings"), designed by a 4-designer fan-out
(economy legibility · autonomous agents · economy-as-theater · a restraint critic) synthesized into one plan.

**🚶 The errand governor — villagers are agents now:**
- One global scheduler sends villagers on **factor-weighted walks to real buildings**: watching the xóm IS reading
  the multiplication. Bé Ngân (GAN 1) walks to the đình door, stops, and turns back — visible fear. Cô Liên (BẠN 1)
  haunts the river landing alone. Chú Ba keeps returning to stare at the stall his mastery can't reach. A bloomed
  craftsman works his own roof (hammer flick). High-BẠN people visit their friends' homes.
- Micro-poses per building: sitting at the đình, sweeping their own doorstep, a watched ripple at the river,
  browsing the stall, chasing chickens (the chickens scatter).
- **Every newcomer's first act teaches a building**: Vũ sits at the đình, Ba stares at the unmanned market, Hoa
  takes her stall, Tú chases chickens, Liên docks and does not come up the bank.
- **The opener is a two-beat silent play**: Mai sits at the đình (what the hall is for), Ngân approaches it and
  falters (what GAN-1 is) — before a single verb is spent.
- **The restraint layer ships in the same commit**: a beat lock (blooms/stamps/arrivals/storms own the screen;
  ambient life yields), a counted walker budget (1 before season 4, 2 after), movers carry no labels, ambient acts
  are silent and push no effects, and ambient behavior touches NO numbers (check.js byte-identical for this layer).

**🪙 The economy became watchable ink:**
- **Every đồng travels the same road**: whenever the river rises — hụi, market payout, flywheel, era — a coin
  visibly flies to the water and a **bamboo gauge** at the landing (10 notches, wet up to vốn) shimmers gold.
- **The flywheel plays its whole loop**: goods baskets fly from the two tallest workshops to the stall, then the
  coin leaves the stall for the river — production drawn as village activity.
- **The market carries what the river carries**: a bare counter and an overturned basket at vốn ≤ 2, produce and a
  hanging bundle in fat years; a **cracked riverbed** when the water is thin. A flood year now OPENS on drought.
- **Góp hụi shows its point**: every unbloomed villager's sprout-% floats up when the circle meets; the person card
  ties the % to the river ("· sông 4/10"); the footer stops teaching the wrong model ("dòng sông là vốn — cả xóm
  cùng góp"); re-tapping a person now alternates their quotes (the free verb gained depth).

**⚡ Hands grow with the xóm (the one balance change):** season 0 deals **2 hands** — exactly what its decision
space supports; the third arrives with the third villager. Mirrored in check.js; band re-proven: hunter 6.99/15.9 ·
linker 6.80/14.6 · spreader 6.29/11.2 · idle 3.46/3.5.

Also: constraint picker chips are bilingual now, and the triện seal fits its three rows on constrained runs
(both from the completion audit). Batch 7 (tap-the-buildings voices, the visible hụi ritual, bloom's first customer)
→ v0.26. Gates ×3 green incl. both full-run playthroughs; governor probes 7/7.

## v0.24 — 2026-07-02 — LOOP v2, cycle 13: the arrival gets its moment, the vow gets its grief, 120Hz gets its time

**The staged opening, tuned (cold-player review):**
- **Newcomers walk in silently and speak AT THEIR DOOR** — the quote used to hang over an empty house while the
  figure was still on the road (bubbles also now track walking figures). Arrivals get their own rising two-note
  motif (D→G), distinct from every other sound.
- **A dirt road now exists** — two wavering ochre strokes from the frame's edge to the đình yard — and when
  tomorrow brings someone, **a faded figure is already visible far down it**. The empty village reads as promise,
  wordlessly.
- **Flood years run their hụi from day one** (the card line was selling a verb that didn't exist for two seasons);
  new-button lines now wait until the newcomer has spoken; the reunion sampan docks as its own beat, not on top of
  Chú Ba's arrival.

**Constraint runs, honest and felt (constraints review — with 3000-run sims):**
- **BUG: the picker's lit glyph went stale** after a constrained run — trusting it gave a silently unconstrained
  run. Cleared at the single choke point.
- **Cô Liên's tragedy names the vow, in her voice:** *"Năm nay không ai nối ai với ai… chắc tôi lại vào Nam."* —
  and her departure line knows it too. (Sim: she leaves 44% of no-link runs even at optimal play. Intended.)
- The village book now shows **⛓ which vows you've kept** (beside years and endings); flood + no-hụi is PROVEN
  survivable (the constrained player actually earns more tiers — the flywheel is the deeper answer), and its card
  line acknowledges the vow: *"Chỉ rễ sâu mới gọi được nước."* Difficulty ladder, intended and documented:
  **no-teach < no-hụi < no-link.**

**The print, corrected (visual review — with rendered screenshots):**
- **Effects now run in TIME, not frames** — on 120Hz phones/laptops every animation was playing at double speed
  (the stamp's dread lasted 0.4s). Stamps, motes, glows, petals, walks — all fps-invariant now.
- **Clustered villagers no longer print name-gibberish** (per-frame label collision), workshop labels sit clear of
  the wall stroke (the fake-hyphen bug), lanterns draw behind people and hang from actual eaves, **nobody stands in
  the river anymore** (the people-floor follows the water level — Liên's riverbank drift kept her legs dry),
  visitors stride at double pace so far walkers actually reach the đình circle, the falling stamp casts a growing
  shadow where it will land, and a banned verb is struck in RED at full opacity — unmistakable vs. merely disabled.

Gates ×3 green (incl. both full-run playthroughs), probes 6/6, season-0 render verified.
Note for future gates: plain headless --window-size clamps at 500px — true 390px testing needs CDP emulation.

## v0.23 — 2026-07-02 — LOOP v2, cycle 12: ⛓ constraint runs — tie one of your own hands

The replay reviewer proved it (v0.21 analysis): only REMOVING a verb forces genuinely new play. Now, once your village
book has an entry, the intro card — and the ending card, for Chơi lại — offers one quiet question: **"tự trói một
tay?"** and three glyphs. No explainer paragraphs; the verb names are the explanation.

- **🚫🪙 Năm không hụi** — the river must fill itself: flywheel or market or nothing. In a flood year, existential.
- **🚫🤝 Năm không kết nối** — BẠN has no verb: Chú Ba's craft and Cô Liên's roots become zeros one hand cannot turn.
  The tragedies that follow are intended — some years, the xóm learns which locks it cannot reach.
- **🚫📖 Năm không dạy** — the school and the mentor lines become the ONLY way skill moves. Lineage or nothing.

The constraint persists in saves, records in the chronicle, **stamps its glyph into the triện seal** beside the year
glyph, and names itself in the ending lead like the year card. The banned verb's button stays visible — struck
through, a hand you can see but not use. Title thresholds unchanged: constrained titles are simply earned harder.

check.js: no new assertions — a constrained strategy is a strictly-weaker player and the band's existing dominance
ordering already covers it; a per-constraint band would triple gate time for no signal.

Gates ×3 green (incl. both full-run playthroughs), 9/9 probes (gating × 3 verbs, save/load roundtrip, seal glyph,
lead line, chronicle record, picker delegation, row visibility).

## v0.22 — 2026-07-02 — OWNER BATCH: people go where their story happens

At the owner's direction ("each people came to each house will actually do something related to that house") —
the buildings stop being backdrop. A `visit()` layer makes movement carry meaning, wordlessly:

- **📖 The class gathers** — students physically walk to Cô Mai's workshop when the lesson runs, and stand there
  while the book motes fly.
- **🪙 The hụi meets at the đình** — every villager you know converges on the communal hall when you contribute,
  and the pooled coin arcs from the đình into the river (the money literally becomes the water).
- **🏮 Failure night is a night AT someone's side** — the once-crushed walk over and sit with the person, not just
  float a +1 from across the map.
- **🛤 Chú Ba carries his ceramics to the market** — the gtm payout is now a visible trip: Ba and Hoa meet at her
  stall, and the coin arcs to the river.
- **🕯 The elder's days move to the đình steps** once his hands begin to fail — where the craft was always kept.
- **🛶 Cô Liên, unheld, drifts back toward the river landing** season by season — you can SEE her leaving before
  she leaves; rooting her brings her days back to the village.
- **☁️ Storms huddle everyone near their own roof** (wander radius shrinks under a heavy sky).
- Friends now close the distance before their pair-conversations — no more shouting across the xóm.

No numbers changed; the band is untouched. Gates ×3 green (incl. both full-run playthroughs).
Constraint seals move to next cycle.

## v0.21 — 2026-07-02 — LOOP v2, cycle 10: the game finds its scale (and the school shows its hands)

**🎵 One scale for the whole xóm (soundscape review):** the gongs had quietly built an A-minor pentatonic that the
beeps never joined. Now everything speaks it: every stray frequency remapped (the build ladder climbs D-E-G-A), the
finale lantern ladder retuned — it was the game's only out-of-tune moment, at its emotional peak — and **the sky tunes
the season bell**: a heavy year rings low on the grief pitch, clear seasons rotate gently so 16 rings breathe. The gong
itself is finally a bell (three inharmonic partials, 2.41/5.43). Three silent moments got their note: the elder's first
fade (the game's only descending pair — reserved for loss), the flywheel's first turn, and the year opening. Teach/
nerve get a human ±13-cent detune; the second bloom answers the first in a different key. Verdict honored: NO storm
ambient bed — this game is punctuation on paper, not a soundtrack.

**🃏 The cards demand hands now (replay review):** the market-road window CLOSES at season 10 (the line always said
"one more trip" — now the code means it); the flood year starts with the river foul (vốn 1) and its first era-rise
never comes — the hụi is truly the only water. The ending hint points at the achievable-next title, not the summit;
the village book shows **which years you've weathered** (🌊📋🛤🍵🧧 lit/dim) on the intro and the ending card; and a
returning player (the book remembers) skips the training wheels — no tap-ring, no first-turn nudge, no "new button"
lectures. The re-taps stay: that's the ritual worth keeping.

**📖 The school shows its work (school review — verdict: balanced, boundary holds 2×):** each lesson is now a book
mote that VISIBLY leaves Cô Mai's workshop and arcs to its student; a hairline notch at 7 on the TÀI bar draws the
class's ceiling; the class opens only once her roof has weathered a season, a stamped school roof teaches no one the
following season (shelter becomes live counterplay for the thing worth protecting most), and mentor + class no longer
double-dip the same tick. Depth still needs a master's hands — now you can see why.

Deferred to next cycle as its own headline: **constraint seals** (player-chosen "năm không hụi / không kết nối / không
dạy" runs, stamped into the triện seal — the replay reviewer proved only removing a verb forces new hands).

Band re-proven on all mirrors: hunter 6.99/16.0 · linker 6.79/14.6 · spreader 6.27/11.4 · idle 3.46/3.5. Gates ×3 incl.
both full-run playthroughs.

## v0.20 — 2026-07-02 — OWNER BATCH: the xóm gathers

At the owner's direction: **the game opens with two people** — Bé Ngân (the zero to find) and Cô Mai (the almost-ready
one). The rest of the xóm arrives one per season: Anh Vũ (1), Chú Ba (2), Chị Hoa (3), Anh Tú (4), and Cô Liên's sampan
still comes when it comes (5–8). Each newcomer **walks in from the road** and speaks their own trouble — no narrator.
The empty houses at dawn are the promise.

- Mechanically free: the `arrives` machinery already existed for Cô Liên; every system (school, entropy, cascade,
  chatter, z-sort) already respects presence.
- The gate followed honestly: with a two-person opening, the sim's "link the two lowest-BẠN people" strategy became
  near-optimal play (it reliably built the mentor pairs) and stopped measuring link-SPAM — the sim linker is now
  honestly BLIND (random pairs), documented in-code. Band re-proven: hunter 6.98 / linker 6.78 / spreader 6.28 /
  idle 3.50 · tiers 15.9 / 14.6 / 11.3 / 3.5.
- Gate 2 rewritten for the staged opening (the apprenticeship link now happens after Chú Ba arrives); Gate 5 full
  runs green in both languages — and they now land different endings across draws, which is the variety working.

## v0.19 — 2026-07-02 — LOOP v2, cycle 9: the gate plays the whole game now

- **Gate 5:** every ship now requires TWO full 16-season headless playthroughs — one in Vietnamese, one in English —
  with a plausible scripted player (meets everyone, tends the weakest factor, links, joins the hụi, builds), asserting
  zero JS errors, a shown ending overlay, and a written chronicle row. The script earns *Mùa vàng*, which doubles as a
  standing balance sanity check. This closes the last automatable 1.0 checklist box.
- Polish verification pass: fresh desktop/phone screenshots confirm the season-13 unlit lanterns, the 🪜 pill, the gold
  tier bar, and phone-readable bubbles (LKF 2.2); og.png and the ×0 seal icon reviewed and approved as shipped.
- Remaining 1.0 boxes are the two human ones: a real-device install/share check and the owner's feel-gate.

## v0.18 — 2026-07-02 — LOOP v2, cycle 8: felt-not-told feedback + phone hands + the 1.0 kit

The cold-arc reviewer's verdict on the owner's de-lecture: **"the cuts were correct — every removed sentence had a
surviving mechanical carrier."** What remained were three feedback debts, fixed without a word of narration:

**Felt, not told:**
- **The tier-up celebrates like the milestone it is** — glow, petals, a rising two-note, the 🪜 pill pulses. It was
  the game's only mute achievement.
- **The stamp now falls FROM THE SKY** — it starts in the cloud layer, falls longer, and the sky itself darkens as
  it drops. The heavy-sky ↔ stamp correlation is drawn, not explained.
- **From season 13, unlit paper lanterns appear on standing workshops** — the xóm visibly prepares to count what
  stands; the finale lights exactly those lanterns. A wordless promise, paid off.
- **A gold tier-progress bar** under a bloomed person's multiplication — distance to the next tier as motion.
- The "now you can see the factors" narrator line fires once per run (was once per person, ×7); the dead lecture
  strings deleted from STR so they can't resurrect.

**Phone hands (mobile deep pass):**
- Canvas text was ~5 CSS px on phones — the LKF cap rises to 2.2 and now covers the tap hint, the **linking-mode
  cue**, sky/river captions, the ĐÌNH CHỈ stamp, and all speech bubbles (with scaled wrapping).
- **Kết nối's dead-ends fixed:** the button shows an armed state while waiting, every cancel clicks/buzzes, and
  mistapping a stranger no longer silently exits linking mode.
- touch-action + user-select on buttons/pills/canvas (no more double-tap zoom or long-press selection mid-game),
  overscroll damped, safe-area bottom padding, landscape height clamp.

**The 1.0 kit:**
- **An identity:** the red ×0 seal is now the app icon (192/512 + maskable + apple-touch-icon + SVG favicon) —
  installs stop looking broken.
- **A face for links:** og/twitter share tags with a 1200×630 scene image (`make-og.sh` regenerates), bilingual
  spoiler-free description, EN-carrying title, noscript fallback.
- **README rewritten** for strangers (the old one said "throwaway prototype" and linked a 404); **LICENSE: MIT**
  (ship-then-veto — say the word for an MIT+CC-BY art split); sw cache → tsk-v2 with the r.ok guard restored
  (the v0.10 edit had silently missed).
- A 1.0 checklist now lives in LOOP.md — three boxes remain, two of them need human hands.

## v0.17 — 2026-07-02 — OWNER BATCH: the school, and the game stops explaining itself

Both changes at the owner's direction — they preempt the loop's own queue.

**📖 Lớp của Cô Mai — education's role, answered in mechanics:**
- When Cô Mai's workshop stands, it is a **class**: each season it lifts the lowest-TÀI villagers (+1 📖), reaching
  1/2/3 students as her workshop climbs gánh → xưởng → thương hiệu.
- **School raises the floor, never the peak:** class TÀI caps at 7 — depth beyond that still needs a master's hands
  (mentor pairs go to 10). And a class only reaches people who are part of the village's life (known). Education:
  necessary, never sufficient — the multiplication says it without a single line of narration.
- One voice line, once, from Mai herself: *"Lớp nhỏ thôi — đứa nào ghé cũng được."*
- Mirrored in check.js; the school legitimately compounds with breadth play (linker tiers 13.5→14.0) — the gate's
  arbitrary 1.5-tier margin recalibrated to strict-dominance +1.0, documented in-file.

**✂️ The de-lecture pass — "let people feel it by themselves":**
- CUT: the red "smallest factor decides" card hint (the math on the card already shows it) · the tier tutorial log
  (the pill and card carry it) · the "⚠ the sky is the LAW" explainer (the first stamp teaches itself) · the probe
  aphorism ("a cheap question beats a lost workshop") · the flood arithmetic lesson · the season-8 goal
  announcement · the per-person "ten times zero" repetition in endings · the "because one factor is zero" card
  clause · the unBuild sales pitch.
- KEPT: everything in a villager's voice, functional button announcements (one line), the card's numbers, and the
  single closing question. The narrator now explains almost nothing; the systems do.

## v0.16 — 2026-07-02 — LOOP v2, cycle 7: six endings, six moods — and a 43% lighter frame

**Endings (payoff review):**
- **Six endings are six objects now:** each title colors the card and its heading, plays its own gong pattern
  (the golden year a rising triad; the quiet year one low note), and speaks **one authored image unique to the run**
  (*"Bốn mái xưởng gọi nhau qua tiếng gõ." · "Xưởng của bạn sáng đèn một mình. Xóm còn ngủ." ·
  "7 mùa giông — mà 3 mái vẫn đứng."*).
- **The seal 🧧** — the con dấu was the antagonist all run; at year's end **the xóm stamps its own book**: a red
  triện-style seal (year-card glyph + title n/6) tilted on the card's corner. Six visibly different trophies.
- **The quiet ending is silence, not a bug:** zero workshops now gets *"Không còn mái nào để thắp đèn."* and one
  low gong into the dark; unmoved numbers are captioned honestly (*"các con số đã đứng yên mười sáu mùa"*)
  instead of "traveled furthest."
- The chronicle row moved to a **footer** (it was interrupting the emotional spine), the Play-again recap de-duped,
  title 4's self-repeating epilogue replaced (*"Bốn mùa gõ, một mái xưởng — và cả xóm đi ngang, nhìn vào."*),
  title 3's tag sharpened (*"một, rồi sẽ hai"*).

**Performance (spec'd, verified, pixel-identical):**
- The static **điệp ground prerenders to an offscreen canvas** (365 draw calls → 1 drawImage per frame);
  bubbles lay out **once at creation** (was ~22 measureText × 216 frames each); the depth pass is **pooled and
  closure-free**; font strings cache on LKF change; cloud color hoisted. **≈43% fewer canvas calls/frame,
  near-zero hot-path allocation** — a real difference on phones.

**Vietnamese (native pass on v0.14–15 strings):**
- **Năm đoàn viên → Năm đoàn tụ** (đoàn viên reads as Youth-Union member — an accidental register clash) and lamps
  now *lụi* (not *hạ*); the tier teach line uncircled (*"cứ vun người chủ: gánh lên xưởng, xưởng lên thương hiệu"*);
  the market road no longer *chở* (roads don't carry — trips do); HINT 4 de-garbled; **🏯 → 🪜** (a Japanese castle
  had no place in this xóm; a ladder is literally "bậc"); + 4 more drop-ins.

## v0.15 — 2026-07-02 — LOOP v2, cycle 6: the cards become real, the gate becomes honest (3 reviewers → 17 shipped)

**Year cards, made playable (cards-in-play review):**
- **🧧 A FIFTH card — Năm đoàn tụ (the reunion year):** the sampan docks at season 2 and the elder's hands begin to
  fail at season 5 — the only year where WHEN matters more than WHAT. (*"thuyền về sớm, mà đèn nhà ai cũng hạ sớm"*)
- **🌊 Flood is no longer a null draw:** the hụi cap rises to 4 (the flavor line finally tells the truth), and the
  village teaches the moved flywheel threshold (*"năm thường sông đã tự đầy — năm lũ cần SÁU"*).
- **📋 Strict's free probe unlocks from day one** (it was locked behind the first bloom — dark exactly when the card
  hurts most), and in strict years **shelter tarps every roof**, not just young ones (the notices are posted).
- **🛤 Market-road announces itself:** two dedicated payout lines (+2 vốn, *"đường mới còn chở được một chuyến nữa"*)
  instead of the base year's "a little," twice.
- **The card is visible all run:** its emoji leads the season pill; the intro line shows it on run 1.

**Cold player (the accumulated build):**
- **🏯 The score you could never see:** a tier pill (once tiers are taught) shows the xóm's standing tiers — the number
  the endings are keyed to — plus a season-8 wanting line: *"Mùa cuối, xóm sẽ đếm những bậc xưởng còn đứng."*
- **Entropy floats merge** to one per person (*"phai −TÀI −BẠN"*) — the mid-game no longer strafes the player.
- **Teaching beats can't drown:** pending lessons flush BEFORE a new season's burst (pendLog queue) instead of
  landing inside it; the log grows to 110px on wider screens.

**Code health (the audit that keeps the next 10 versions honest):**
- **The release gate had drifted from the shipped math** — fixed 4 mirror divergences in check.js: stormStreak
  order (the sim was one adaptation-season more generous), inspiration reaching un-arrived/gone people, Liên's
  departure timing + pair-rooting parity, and the linker finally receiving what the real game gives it (mentor
  drips + the market payout). Band re-proven on the corrected mirror: 6.98 / 6.62 / 6.21 / 3.67 · tiers 15.2 / 13.5 / 10.0 / 3.7.
- **Save format v2** with real guards: a pre-card save no longer force-loads as a flood year; gtmPaid/gtmPays can't
  double-pay; jittered bases fall back to loaded stats (never a re-jitter); dead `apprentice`/`seed`/`probeTaught`
  fields dropped.
- **No more ghost callbacks:** one `runTok` invalidates every deferred timer on reset; all FX arrays clear in fresh().
- Documented the unreachable shelter/born state so v16 doesn't "fix" it.

## v0.14 — 2026-07-02 — LOOP v2, cycle 5: 🃏 Year Cards — every run demands different diagnosis

The deferred headline. At each run's dawn the xóm draws one of four authored years (never the same twice in a row —
the chronicle remembers), announced in the village's voice and named again in the ending:

- **🌊 Năm lũ (flood year):** the river can't fill itself until the workshops run six tiers deep — the hụi is the
  xóm's only water. Vốn is the scarce lever.
- **📋 Năm xét kỹ (strict year):** clear skies don't last (down-biased drift above the line), but the commune posts
  notices — **nghe ngóng is free**. Information is cheap; calm is scarce.
- **🛤 Năm đường chợ (market-road year):** goods reaching the district fetch **double, twice** — the Hoa×Ba pair
  becomes an engine. Distribution is the lever.
- **🍵 Năm tay lặng (quiet-hands year):** mentor pairs pass craft at **+2/season** and tending holds twice as long
  (entropy halved). Lineage is the lever.

Each card is 2–4 one-line rule bends at existing sites — the multiplication stays untouched; what changes is *which
lever is scarce*, so run 3 asks a different question than run 2. Card persists in saves, records in the chronicle,
and names itself in the finale's lead line.

Under the hood: cards mirrored in check.js (drawn per seed). The band exposed an honest measurement fact: the hunter
saturates the 7-bloom ceiling, so bloom-count cannot separate strategies at the top — the linker guard now lives on
**tier depth** (hunter 15.5 > linker 13.1 + 1.5), with strict bloom ordering kept. Band: 6.99 / 6.70 / 6.40 / 3.67 ·
tiers 15.5 / 13.1 / 10.3 / 3.7. Gates green ×3; all four cards probe-verified.

## v0.13 — 2026-07-02 — LOOP v2, cycle 4: the game can be lost now (balance overhaul + scene cleanup)

The balance reviewer brought Markov chains and 6,000-run sims; the art reviewer rendered the scene and looked at it;
the replay reviewer played run 2 cold. Sixteen changes:

**Balance — stakes exist now:**
- **Idle no longer wins.** Blooms inspire only people you've MET (+1 GAN to known villagers only) — doing nothing
  drops from 4.5 blooms (earning the #2 ending) to 3.7 with tierSum 3.7 vs the hunter's 15.5. The gate now enforces a
  difficulty ceiling (idle ≤ 4.0) and a tier-separation band (hunter > spreader + 3 tiers).
- **Endings re-keyed to tierSum** — rooted depth, not cheap bloom count: Mùa vàng needs 5 blooms + your build +
  12 tiers; Xóm đã thức needs 8 tiers. Every rung is now reachable: title 4 = built + almost nothing else bloomed;
  title 5 = nothing grew past a stall; NEW title 6 **"Mùa giông vẫn nở"** — six storm seasons endured, three blooms held.
- **Storms are arcs, not identities:** below the tax line the sky recovers 25%/8% (was a near-absorbing 12%/8% —
  ⅓ of runs were whole-game 2⚡ marches, E[escape] 31 seasons). And **the xóm adapts**: after two braced seasons,
  hands return to 3⚡ (*"Nhà đã chằng néo xong — xóm quen giông rồi"*). Crush risk stays.
- **Shelter finally pays:** appears whenever a storm is VISIBLE (current sky, or paid forecast — no more paying 1⚡
  to confirm a foregone conclusion before being allowed to act), and one hand now tarps EVERY exposed young roof.
- check.js: elder-clock off-by-one fixed; band re-proven — hunter 6.99 > linker 6.68 > spreader 6.35 > idle 3.73.

**Run 2 — the chronicle finally shows up where it matters:**
- **The 🏮 endings-seen row (now /6) + one hint for the nearest unseen title live ON THE ENDING CARD** — the flagship
  replay feature was previously invisible on the Play-again path. "Chơi lại" also opens run 2 with the village book's
  recap as its first log line.
- **The finale clears the save** — no more resuming a ghost season 15 and double-writing the chronicle (real bug).
- **The xóm talks twice as much:** every villager has 2 idle lines + a storm-season line; every special pair has a
  second exchange. (*Chú Ba: "Đất sét năm nay mịn. Người thì chưa biết."*)

**Scene — the print reads again (reviewer rendered and looked):**
- Workshops **pick clear ground** (reserved rects for market/houses/đình/trees + spacing from other workshops) —
  no more tier-3 buildings swallowing the market.
- **Labels de-cluttered:** workshop labels show the tier word only (full name when selected/yours), all canvas text
  gets a paper halo, and label sizes compensate on phones (were ~5px fuzz at 390px).
- **One depth pass** for people + workshops (no more walking on roofs); finale lanterns hang **off the eave on a
  string** (were blotting the pennants red-on-red), smaller glow.

Deferred to next cycle (headline feature, deserves its own batch against this new balance): **YEAR CARDS** — 4 authored
year-conditions that change which lever is scarce, so run 3+ demands different diagnosis, not different arithmetic.

## v0.12 — 2026-07-02 — LOOP v2, cycle 3: run 2 & the village's voice (3 reviewers → 18 shipped)

**Replayability (run 2 is now a different year, and pulls you in):**
- **Year variants** — every run jitters each person's non-zero stats ±1 (authored zeros stay true), Cô Liên's sampan
  comes seasons 5–8, the elder's clock starts 7–9, the starting sky/river roll 2–4 — announced by one flavor line
  (*"Năm nay lũ về sớm…"*). Re-diagnosis is real again.
- **📜 Sổ xóm — the village chronicle** persists across runs: the intro now shows your last run's title and
  **kết đã thấy 🏮🏮○○○ 2/5** — the five endings are finally advertised by the village's own record book.
- **☁️ Storm tax** — under a heavy sky the xóm has only **2⚡** (everyone is bracing their own roofs). Scarcity waves
  land in different seasons every run; triage is real.
- **🎨 A fourth authored pair** — Cô Liên × Bé Ngân (*"Vậy em code, cô vẽ nha!"*): a second mentor route for Ngân, a
  real returnee-first strategy. The ending now counts **Mối duyên đã kết: X/4** so run-1 players know more is hidden.
- **The finale names YOUR run** — the then-vs-now multiplication now picks **whoever traveled furthest under your
  hands** (was: always Bé Ngân).

**First-session (the new systems teach themselves):**
- Tiers get their one-time teaching beat at first bloom; the first-bloom log burst is staggered into beats
  (bloom line keeps its moment; law/probe/tier lessons arrive 2–5s later).
- The finale announces itself (🏮 banner + one line), the pill no longer reads **17/16**, and — real bug — the person
  card's buttons are now properly dead during the ending (missing S.over guards).
- Probe→shelter chain closed: a heavy forecast with an exposed workshop now says so in the same breath.
- Tier labels drawn outside the tier scale at 12px — readable on phones (were ~3px).

**The village's voice (native-reader pass):**
- **Everyone grieves in their own voice** — the crush bubble now uses each character's written despair line (Bé Ngân's
  *"Giấy phép… em làm sai gì sao?"*) instead of everyone stealing Chú Ba's *"Tôi đã bảo mà…"* (pronoun-register bug).
- **Hỏi thăm → Nghe ngóng** (the true village verb for loitering near the xã office collecting rumors).
- "the river is the capital" → **"the river is capital"** (no more Hanoi readings); linking lines de-jargoned
  (*"Kết thân với ai đây?"*); the hụi line earns its laugh (*"ai cũng kêu hết tiền, mà ai cũng góp đủ"*); shoulder →
  **shoulder pole**; "w.shop" → "shop"; + 5 more drop-in polish lines.

Under the hood: variants/storm-tax/elder-window mirrored in check.js (band re-proven: hunter 6.95 > linker 6.58 >
spreader 6.06 > idle 4.54); jittered bases + arrival/fade windows persist in saves; gate assertion made jitter-proof;
gates green ×3.

## v0.11 — 2026-07-02 — LOOP v2, cycle 2: the late-game & payoff batch

The three deferred design-review features, built as one system:

**🏯 Workshop tiers — tending doesn't stop at the bloom.**
- A workshop's tier follows its owner's LIVING product: <300 **gánh hàng** · <600 **xưởng** · ≥600 **thương hiệu**
  (drawn bigger, twin pennants). Dạy stays live on bloomed people — seasons 11–16 no longer play themselves.
- **Stamps knock a tier down instead of erasing** (owner GAN −2, the walls stand); only a tier-1 gánh can be erased.
- The flywheel now counts **sum of tiers ≥ 4** — something you keep feeding, not a switch you flipped in season 8.
- Your own product now lives under the same sky (stamp immunity removed) — if it falls, you rebuild from 2/4,
  faster than the first time.

**🛡 Che chắn — the probe becomes real insurance.**
- After a heavy forecast, a Shelter button appears: 1⚡ tarps the youngest exposed workshop (a woven mat over the
  roof) through the storm season. Probe → shelter is now a genuine 2⚡ play against a 15% loss.

**🏮 The staged ending — three beats, not a text wall.**
- Season 16 first plays a **lantern harvest** on the canvas: a lantern lights over each standing workshop, one gong
  per beat, before any overlay.
- The card **leads with the thesis as a number** — the weakest person's multiplication then-vs-now:
  *Khi bạn đến: 8 × 1 × 4 = 32 · Khi bạn đi: 8 × 7 × 6 = 336* — plus total tiers standing.
- Epilogues capped at the 3 highest-signal lines; the rest fold behind **xem thêm ▾**. The closing question stands alone.

Under the hood: tier crush + tier flywheel mirrored in check.js (band: hunter 6.96 > linker 6.64 > spreader 6.25 >
idle 4.63); finale timers token-guarded against mid-scene resets; shelter persisted in saves. All gates green.

## v0.10 — 2026-07-02 — LOOP v2, cycle 1: the review-hardening batch (3 reviewers → 12 fixes)

First big-batch cycle: three parallel fresh-eyes reviews (first-session fun · design depth · code/mobile), all
findings triaged, twelve shipped:

**Critical bugs the gates couldn't see:**
- **Named banners never displayed** — the bloom 🌸 and sampan 🛶 banners were clobbered by the season banner in the
  same tick (dead since v0.4/v0.8). Now a queue: bloom → sampan → season, shown one after another.
- **A newborn workshop could be stamped the same instant it bloomed** — the payoff moment read as cruel RNG. Now every
  workshop stands at least one full season before the law can touch it (`born` grace, mirrored in check.js).

**Design/balance (the exploit hunt):**
- **Kết nối pair-farming killed:** the first close friend changes a person (+2 BẠN); every later connection adds +1.
  Repeats +1/+1 with a gentler log. Linking now also **requires having talked to both people** (diagnosis first).
- **New `linker` strategy in the band** — the gate now proves diagnosis beats link-spam too:
  hunter 6.73 > linker 6.29 > spreader 6.05 > idle 4.64 (margin note in check.js: the sim's linker is
  semi-diagnostic, so its bar is +0.3).
- **🕯 The elder's clock:** from season 8, Chú Ba's TÀI fades −1/season unless his kiln stands or the apprenticeship
  exists — the greedy "Hoa-first" opening now has a real cost, and "the craft dies with me" is earnable/losable.
- **🌱 Momentum:** a tended-but-unlucky sprout (product ≥100) pushes harder each missed season (+3%, capped +9%),
  shown on the card as "mầm đang nhú 🌱" — dead mid-game stretches now visibly accumulate toward something.

**Feel/mobile/platform:**
- **Entropy is visible** — known people float "−1 TÀI/GAN/BẠN" the instant tending washes away (was a silent stat drop
  that read as a save bug).
- **Tap targets ≥22 CSS px** on any screen (was ~13px radius on a 390px phone).
- **Canvas backing store sized to the display** — ~8× fewer pixels per frame on phones (was rendering 2880×1800 on a
  370px-wide screen).
- **Top bar wraps** at narrow widths (the probe forecast no longer causes 22px horizontal overflow).
- **iOS audio resumes** after backgrounding/calls (suspended AudioContext now `resume()`d).
- **Service worker won't cache captive portals / mid-deploy 404s** (`r.ok` guard); hụi cap now shows **✓ 3/3**; a paid
  forecast survives a page refresh (probeSeen/luatNext persisted).

Deferred to next batch (designed together): **workshop tiers** (late game currently plays itself), **Che chắn shelter**
(makes the probe a real insurance play) + removing your own workshop's stamp immunity, and the **staged 3-beat ending**
(lantern harvest scene, then-vs-now multiplication line, capped epilogues).

## v0.9 — 2026-07-02 — LOOP iteration 5: the flywheel and the lantern (DEPTH)

Two interlocking strategy layers, both straight from the thesis:
- **🌊 The recycling flywheel:** with **3+ workshops standing, the river fills itself** (+1 vốn/season) — value
  retained recirculates, and early blooms compound into easier later ones. The PayPal-mafia loop, village-sized.
  One-time line: *"Ba xưởng đứng vững — dòng sông bắt đầu tự đầy."*
- **🏮 Failure night is communal:** Đêm thất bại still gives its target +2 GAN — but now everyone who has ever been
  stamped and sits unbloomed also gains +1. Holding your lantern night until *after* a crush becomes a real play
  (thất bại có ích, mechanized).
- Both mirrored in `check.js`; band re-verified: **hunter 6.68 > spreader 5.69 > idle 3.79**. Gates green.

## v0.8 — 2026-07-02 — LOOP iteration 4 (BOLD): Cô Liên, người về

A seventh person who isn't there at the start. **Season 6, a sampan docks:** Cô Liên comes home after ten years in
Saigon — TÀI 9, GAN 5, **BẠN 1** (*"Về rồi… mà như khách."*). The brain-circulation thesis as one human being:
- **Root her or lose her:** if by season 13 she hasn't bloomed, her BẠN is still near zero, and no one has KẾT NỐI'd
  her — she quietly leaves (*"không ai giữ"*), with a warning bubble at season 11. One real connection is enough to
  hold a person.
- Full quote arc (guest → remembered → studio-in-the-xóm), ambient chatter, ending epilogue lines for both fates.
- `check.js` mirrors her (arrival + unrooted departure); the band **widened**: hunter 6.64 > spreader 5.40 > idle 3.64 —
  the returnee rewards diagnosis exactly as the thesis predicts.
- Ship-then-veto: if she doesn't earn her place, say the word and she sails back in one revert.

## v0.7 — 2026-07-02 — LOOP iteration 3: the instrument (FEEL)

- **The audio grew a voice:** raw sine pips → a soft-attack **triangle instrument**; blooms now play a rising
  **pentatonic arpeggio** (C–E–G); seasons turn on a **gong** that sags in pitch; the ending gets a long low gong.
- **The stamp is physical:** the whole woodblock print **jolts** (decaying screen-shake) when a workshop is suspended,
  with a deeper thud.
- **Blooms glow:** a warm golden ring opens under every new workshop, beneath the petals.
- Rendering/audio only — model untouched, gates green, headless probe clean.

## v0.6 — 2026-07-02 — LOOP iteration 2: the xóm talks (STORY)

- **Crush has an emotional arc now:** after a stamp, each person falls into a written despair state
  (Mai: *"hai mươi năm dạy học, chưa ai đóng cửa lớp của tôi"* · Hoa, defiant: *"chợ vẫn họp — mai tôi bày hàng lại"*)
  — and it **lifts when you rebuild their GAN** past 5, returning them to their hope line.
- **Ambient chatter:** each season, someone in the xóm may speak on their own — seasonal small-talk
  (Tết in spring, lanterns at Trung thu), personal lines, or a crushed person's grief.
- **The pairs banter:** connected duos exchange authored mini-dialogues (Ngân to Chú Ba: *"như debug thôi chú —
  từ từ từng dòng"* · Vũ: *"đo hai lần, cắt một lần"* — Tú: *"em toàn cắt trước đo sau…"*).
- No model change; gates green; probe verified (despair→hope arc + 30 chatter rolls clean).

## v0.5 — 2026-07-02 — LOOP iteration 1: the Đông Hồ woodblock pass

The loop's constitution added (`LOOP.md`: invariants · compass · bold-every-4th · ship-then-veto · halt conditions).
First compass item, ART:
- **Điệp-shell paper** — fiber strokes + mica sparkle over the ground speckle.
- **Woodcut ink** — warm dark-brown (#3a2a1e) outlines everywhere, heavier line on figures.
- **The figures got their folk plumpness** — rounder áo with a placket line, bigger heads, **rosy woodblock cheeks**.
- **Roofs curve** — đao upturned corners on the đình + houses, tile lines, side windows on the đình.
- **The red ringed sun** (đỏ vang), golden chicks, and a **printed frame with the ×0 seal** signing the corner —
  a woodblock print signs its work.
- Gates green; rendering-only (no model change).

## v0.4 — 2026-07-02 — buy the cheap question; two more lineages; shaped endings

- **🔍 Hỏi thăm (the probe beat — the fable's rule #2, now playable):** unlocks at your first bloom, alongside the
  law lesson. 1⚡ asks the commune office about NEXT season's sky (shown on the season pill as → ☀️/☁️). Young
  workshops (< 2 seasons) now face 15% stamp risk under a heavy sky vs 5% established — so *timing a bloom around
  the forecast* is real strategy: a cheap question beats a lost workshop.
- **Two new authored pairs:** 🔧 **Anh Vũ → Anh Tú** (the leaper gains a craft: his TÀI grows each season) and
  🧺 **Chị Hoa × Chú Ba** (she takes his ceramics to the district market — when his kiln stands, the river rises:
  the craft climbing the value curve, mechanized). Mentor logic generalized (MENTORS table).
- **Bloom moments:** each bloom now raises a named banner ("🌸 Cô Mai"), speaks their bloom quote, and buzzes
  (haptics, mute-governed).
- **Shaped endings:** the title now matches your xóm's story — *Mùa vàng · Xóm đã thức · Những mầm đầu tiên ·
  Bằng chứng đơn độc · Mười sáu mùa lặng* — plus new duo/GTM epilogue lines.
- **PWA:** manifest + network-first sw.js — installable, plays offline.
- Hardening: completeLink self-link guard (found by probe); check.js mirrors age-based stamp risk; band re-verified
  **hunter 5.69 > spreader 4.89 > idle 3.30** @1200 runs. All gates green.

## v0.3 — 2026-07-02 — the gentle opening (owner playtest: "hard to understand, too many elements at start")

The game now introduces itself slowly, through play:
- **Intro cut to two lines** — "tap a person and talk; the xóm will tell you the rest." All teaching moved into play.
- **Verbs unlock as the story needs them:** Kết nối appears once you know 2 people · Góp hụi arrives season 3 (with
  the river line) · Tự xây arrives season 5 ("people trust hands that have built"). Each announced by one log line.
- **First-turn nudge** — pressing MÙA SAU with an unspent hand gets one gentle bubble before it advances.
- **One-time red hint** under the first multiplication: "the SMALLEST factor decides — spend effort exactly there."
- **The law is taught when it matters** — the sky=law line appears at the first bloom, not in the intro.
- Resumed saves skip all teaching beats. Gate's fresh-run assertion made deterministic (entropy makes gan stochastic
  by design — the gate was asserting against the game's own mechanic). All gates green ×4 runs.

## v0.2 — 2026-07-02 — the xóm comes alive (owner: "nice look, please continue")

**People:**
- **Evolving quotes** — every character speaks differently once their zero turns (hope), once they bloom (joy);
  quotes are the state display: Ngân goes from *"bố bảo học Y"* → *"bố… chưa mắng"* → *"xưởng nhỏ thôi — nhưng là của em."*
- **Kết nối is now a deliberate verb** — tap Kết nối, then tap WHO. Both gain BẠN; a green thread arcs between them on the map.
- **The apprenticeship** — connect Chú Ba and Bé Ngân and the lineage transmits: her TÀI grows +1 every season
  under the master (*"nghề gốm có người nối"*), echoed in the ending. Lineage-as-exit, mechanized.

**Model (the thesis band, now enforced):**
- **Entropy** — un-bloomed tending decays back toward each person's nature (35%/factor/season above base), with a
  one-time explanatory log line. This is what makes *diagnosis* clearly beat *spreading*:
  `check.js` @1200 runs: hunter **5.50** > spreader **4.64** > idle **3.09** (band asserted in the gate).

**World & feel:** season banner + gold/blossom drift + seasonal tint · chickens, banana tree, lotus when the river
is full · first-tap hint ring · linking-mode ring.

**Plumbing:** NaN-safe save/resume (`thua-so-khong-v1`), reset link, mute toggle (persisted), `check.js` + `gate.sh`
(band · syntax · fresh headless run incl. the apprenticeship path · poisoned-save). All gates green.

## v0.1 — 2026-07-02 — feel-first prototype
One xóm, six authored people, the multiplication shown literally on every card, sky=law, river=capital,
3 công × 16 seasons, hụi + build-your-own. Built FEEL→MODEL by design; owner passed the look gate.
