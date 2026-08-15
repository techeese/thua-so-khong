# lab/ — the vigil's workbench

Everything in this directory is **scratch**. Prototypes, probe harnesses, measurements, throwaway
HTML. `lab/*` is gitignored except this file.

**Nothing in here ships.** That is the rule that lets the loop work here without limit while the
game itself sits still. A prototype that looks worth shipping does not get shipped — it becomes a
candidate in `SYNTHESIS.md` / `MILESTONES.md` and waits for the owner to open an era for it.

Findings accumulate below, newest first, so the next synthesis has evidence instead of opinions.
Each entry: what was measured or built, the number or the observation, and which candidate era it
argues for or against.

---

## Findings

<!-- ## YYYY-MM-DD — <what was probed/built>
     **Measured:** …
     **Argues for/against:** <candidate era>  -->

## 2026-08-15 — "watching the xóm IS reading the multiplication" — the errand governor as an information channel (`walks.py`)

v0.25's owner batch shipped the errand governor with one stated purpose (CHANGELOG: *"factor-weighted
walks to real buildings: watching the xóm IS reading the multiplication"* — fear walks to the đình
door and turns back, loneliness haunts the river, mastery stares at the stall) and a standing
directive, *buildings mean something*. Eight vigils have measured the label, the sheet, the zero
and the telling; none has measured the walks. Harness `lab/walks.py`, output `lab/walks-out.txt`
(gitignored): `execBeh` and `pickBeh` instrumented in paced headless 16-season runs, three players
(`watcher` taps everyone and never acts — the player who only looks; `hunter`; `idle`), two
pacings (5.2 s and 20 s per season), 4 runs each; `pickBeh()` sampled 3000× per (known, unstarted
person, season) — 679 snapshots — to get each person's true walk distribution, then a Bayesian
observer classifies the weakest factor from walks alone. Headless virtual time starves rAF, so
the governor was driven at 4 Hz by timer (landmine appended).

**Measured — the walks carry a real signal for two of the three factors, at a threshold the
label does not use, and at a rate a player will see once or twice a run.**

- **Signal (infinite-sample observer).** From a person's full walk distribution, an observer who
  knows the class profiles names the zero: **GAN 82%, BẠN 65%, TÀI 100% (n=30), "no zero" 71%**
  (4-way; chance ≈25%). The tells are real: `P(FALTER | gan≤3) = 0.14` vs **0.00** at gan≥4;
  `P(river | ban≤3) = 0.17` vs 0.03. But **there is no low-TÀI walk** — `pickBeh` (`index.html:573`)
  has no term that rises when TÀI falls; the market weight rises for TÀI≥7 (`P(market)` 0.07 → 0.28)
  and watch-shop is flat (0.07/0.09/0.09). A low-TÀI zero is legible on the map only as the *absence*
  of a walk a master makes; the 100% above is those 30 snapshots being the one person whose profile is
  otherwise unremarkable, not a tell. Cô Liên's BẠN-zero is confused with a TÀI-master 59/240 times
  because her TÀI 10 sends her to the market more than her BẠN 1 sends her to the river.
- **Finite samples.** A player does not see the distribution; at 20 s/season a `watcher` sees
  **7.8 walks per known person per run** (hunter 9.4). Classifying from k drawn walks: **k=3 →
  GAN 66% / BẠN 51% / none 31%; k=9 → 81% / 61% / 52%; k=30 → 82% / 63% / 69%.** At the 5.2 s
  pacing every prior probe used, the run has **1.8–4.5 errands total** — the walk layer is close to
  absent for a fast player. Signature walks per run at 20 s: **FALTER 1.0–1.8, river 1.0–2.8**, all
  by Bé Ngân and Cô Liên respectively (the two authored zeros); market 0.8–5.0. `idle` sees only
  forced arrival chains (21 of 21 errands by unknown people) because **the errand pool requires
  `p.known`** (`:611`): a person you have not tapped never walks, so the walk cannot be the reason you
  tap them.
- **Threshold mismatch — the walk and the label disagree on what a zero is.** The label prints
  `số không: gan` at min ≤3 (`zeroOf`, `:1035`); the falter fires only at gan≤2 (`pickBeh`:
  `p.gan<=2?3:2`): **`P(FALTER | gan==3) = 0.00` (n=27) while the label under the same name says
  "số không: gan"; at gan≤2 it is 0.18.** River likewise: `P(river | ban==3) = 0.03` (n=152) vs 0.31 at
  ban≤2. A gan-3 / ban-3 person is labelled a zero and walks like everyone else; the two systems that
  claim to show the same fact draw the line one point apart.
- **Redundancy.** Of 231 errands by known people, **37% (86) were performed by someone already
  carrying the printed `số không:` label** under their name; 31 of those were the label's own
  signature walk, 53 neutral, 2 another factor's. Because walks require `known` and the label prints
  on `known && !started`, **every walk that carries a factor tell is performed under a text label
  stating that factor** — the walk never precedes the label, only accompanies it. And 63% of errands
  are `home` / `đình-sit` / `own-shop` / `chick`, which carry no factor at all.
- **Variance and locks.** Runs at the same pacing ranged 3–42 errands (watcher @20 s) — the storm
  huddle (`S.luat<4` returns before any errand, `:597`) and the beat lock silence the governor for
  whole seasons; under storm only 2–9 of ~100 errands fired.

**Reading it.** The governor does what v0.25 said for GAN and BẠN — a faltering child and a woman
alone at the landing are real, class-separable tells — but (a) TÀI has no walk, so one of the three
zeros is mute on the map; (b) the tell fires at ≤2 while the label calls ≤3 a zero, so the two
"reading" surfaces disagree at exactly the boundary; (c) the pool's `known` gate means the walk is
never the first thing you learn about anyone — the label always got there first; (d) at the pace a
player actually plays, the number of signature walks per run is one or two, by the two people whose
zeros are already authored into their arrival scenes. "Buildings mean something" holds for the
đình door and the river landing and does not hold for the market as a *reading* — the stall is where
TÀI-10 goes, not where TÀI-1 fails to go.

**Argues for:** the reductive era on the zero — a surface that distinguishes 0 from 3 *as it happens*
would have to reconcile these two thresholds anyway; and the "either make it a factor or stop
presenting it" logic from `fourth.js` applies here to the market. **Argues against:** an era that
adds more walk behaviours or buildings — the channel is sample-starved before it is signal-starved,
and every tell it does carry is under a text label saying the same thing. If a synthesis wants the
walks to be the reading, the *label* is the thing to remove, not the walk to add — and that is a
balance decision (decide.js measured `labelOnly` at 92% of the hunter's blooms).

**Not shipped, per Gear 3.** `index.html` untouched. Small item with evidence for a Gear 1 tick or
the owner: the falter/river thresholds (≤2) vs `zeroOf` (≤3) — one of them is a copy of a rule that
moved.

## 2026-08-15 — is the thesis told, or felt? a telling audit (`tell.py`)

Owner gate #3 says the thesis must arrive *"without the game ever telling you."* Charter constraint
2 says *"one line per beat."* Both are claims about how many words the game spends **saying** the
arithmetic — measurable, unlike whether the player feels it. Two lenses: a static pass over every
authored bilingual string, and 6 paced headless 16-season runs per player (`hunter` tends the
weakest factor of the weakest known person; `idle` never taps), recording every `logMsg` /
`banner` / `bubble` / `floatOn` and the ending card's DOM. A string is a **thesis-tell** if it
names *thừa số · số không · bằng không · phép nhân · nhân với · ×* (EN: *factor · zero ·
multipl· · ×*). Harness `lab/tell.py`, output `lab/tell-out.txt` (both gitignored).

**Measured — the game tells the thesis at second zero, then almost never during play, then in a
155-word block at the end.**

- **Always-on.** The full sentence *"mười nhân với không vẫn bằng không"* is the header subtitle
  (`index.html:96`, `subttl`) — on screen every second of every run — and the intro card's tagline
  (`:140`). Owner gate #3 is unmet **by the frame, before the first tap**: the game does not let
  the arithmetic arrive, it prints it above the canvas for sixteen seasons.
- **Static corpus.** 141 bilingual pairs; **5 (3.5%)** are thesis-tells: the tagline, the title,
  the reveal line (`Bạn ngồi nghe. Giờ bạn nhìn thấy các thừa số.`), and two Cô Liên lines
  (`:1375`, `:1506`). Every villager quote, every ambient line, every seasonal line is thesis-free.
- **In play.** Hunter: **31.8 narrator lines / 383 words** per run, of which **1.2 lines** are
  thesis-tells — the reveal at season 0 (6/6 runs) and Cô Liên's departure line at season 11
  (1/6). Idle: 17.2 lines / 194 words, **0.8** tells, first at season 11. Bubbles: 47.2 per hunter
  run, **0.0** thesis-tells; floats 46.7. The play layer honours the constraint almost perfectly —
  between the intro and the ending the multiplication is spoken once (the reveal) and then shown,
  not said. Narration also decays hard: hunter log words per season run 60 → 58 (s3) → 5 (s10) → 0
  (s15); the back half of a run is nearly silent (see attach8: this is the same sag).
- **One line per beat — measured.** Grouping `logMsg` calls that land within 60 virtual ms as one
  beat: hunter **35% single-line, 25% two, 18% three, 21% four-to-six lines**; idle 67% / 21% /
  9% / 3%. Season resolution is where the stacks come from (bloom + tier + class + link + hụi all
  fire in one synchronous burst) — the log shows up to six narrator lines at once, ~65% of the
  hunter's beats carry two or more.
- **The ending is the telling surface.** 6/6 runs both players: card of **150–158 words** (the
  intro is 34), **3.3 (hunter) / 4.2 (idle) thesis-tell lines**, the `×` arithmetic beat in 100%
  of runs, and the unconditional closing line *"Đừng hỏi 'ai sẽ là Steve Jobs Việt Nam?' Hãy hỏi:
  'thừa số nào đang bằng không…'"* (`:1535`) in 100% of runs — the only place the game names a
  great man, and it does so to every player regardless of what they did.
- **And the ending can tell the thesis and its counterexample on the same card.** The card lists
  *Đã nảy mầm* by name and prints one villager's `tai × gan × ban`. Idle, 6 runs: **16 of 26 people
  the card calls bloomed (62%) have a weakest factor ≤3 — the game's own "số không" threshold
  (`zeroOf`, `:1035`)** — and the `×` beat itself shows a factor ≤3 in **6/6** runs (`Cô Liên
  10×6×1 ✿`, `Anh Tú 2×9×7 ✿`, `Bé Ngân 7×1×3` "the numbers never moved" beside a bloom list).
  Hunter: 4 of 41 (10%; `Cô Liên 10×10×3 ✿`). Cause is the known soft zero — `chance()` (`:419`)
  is `prod/1000·0.9·(0.6+0.4·von/10)+mom`, continuous in the product, so 10×6×1=60 still rolls —
  but the *new* fact is where it surfaces: the one screen that says "ten times zero is still zero"
  in words prints, in the same notation, a 1 that bloomed. A player who reads the card the way it
  asks to be read sees the sentence refuted by its own arithmetic.

**Reading it.** The telling problem is not the narrator — play is close to silent on the thesis
and the standing "less narration" directive has largely landed mid-run. It is the **frame**
(tagline on screen from t=0) and the **ending** (a 155-word block that both states the thesis and,
for the player who did nothing, contradicts it in numbers). Owner gate #3, as worded, cannot be
ticked while `subttl` and `inTag` carry the sentence; that is a design decision, not a bug.

**Argues for:** the reductive era on the zero already on the synthesis table gains a surface
argument — floors that bite would make the ending's arithmetic *agree* with its sentence, and
subtracting the tagline from the header (keep it for the og card / title only) is the cheapest way
to let the thesis arrive rather than be announced. Also argues for an **endings pass** that treats
the card as the second-longest text in the game — a "one line per beat" audit of season resolution
would fold in. **Argues against:** any era that adds explanatory copy anywhere; the play layer is
already the quietest surface, and the two places the game lectures are both outside play.

**Not shipped, per Gear 3.** `index.html` untouched. Two candidate items for a Gear 1 tick or the
synthesis: (1) the header/intro tagline vs owner gate #3; (2) the ending card can list a ≤3-factor
person as bloomed and print `× 1` beside "bloomed" — either the floor or the copy must move.

**Verdict:** confirms-known
*Grader:* The ending-card `× 1`-beside-bloomed finding is the soft zero of `zerohunt.js` and the witness/legibility lever of `zerowitness.js` restated on one more surface, the ending audit feeds the "Endings pass" already parked in MILESTONES.md, and the mid-run silence repeats attach8's sag — the tagline-vs-owner-gate-#3 observation is real but strengthens the existing reductive candidate rather than opening or killing an era.

## 2026-08-15 — the fourth factor: is capital a factor? the river and the hụi against the thesis (`fourth.js`)

The charter's thesis names **four** multiplying factors — *"Talent (TÀI), nerve (GAN), connection (BẠN),
and capital multiply."* Six vigils have measured the first three from every side (softness, witness,
what/who/when). None has asked about the fourth. In the game capital is the river, `S.von`, 1–10, xóm-wide,
raised by the hụi verb the player presses, by a quarterly clock, by the tier flywheel and by the Ba×Hoa
market payout. This probe asks whether it is a factor at all — arithmetically, in play, and on screen.

Harness: `check.js`'s sim verbatim, same seeds (`1009+i·53`, N=6000), paired; drift check exact
(hunter 6.99/15.86 · spreader 6.25/11.21 · linker 6.80/14.54 · idle 3.44/3.44). Added: a river mode
(natural / frozen at 1 / frozen at 10), the game's **Góp hụi** verb mirrored from `actHui`
(`index.html:1179`: unlocks s≥2, s0 in a flood year; max 3, 4 in flood; +1 river per act, one act
each), and attribution of every point of river rise to its source. `check.js`'s own strategies never
press the hụi, so the band's canonical player has never once contributed to it.

**1 · The river cannot be a zero, and the sheet knows it.** `S.von` enters the season math at exactly
one place — `chance()` (`index.html:419`) — as `(0.6 + 0.4·von/10)`. Floor 0.64 at von 1 (the save
sanitiser clamps it to `[1,10]`; no code path ever lowers it — the river only rises), ceiling 1.0: a
**1.56× swing**, against **10× (and 0)** for each personal factor. Tiers, stamps, build and entropy never
read it. The sheet prints `TÀI × GAN × BẠN = 288` and the river as a side tag (`· sông 7/10`); the
ending's arrived/left arithmetic is three factors. At a hypothetical von 0 the multiplier would still be
0.60. Unhelped Bé Ngân (1×9×9) blooms within 14 tries in 48.8% of lives at river 1, 65.3% at river 10,
46.5% at river 0. No river state moves anyone across the line between possible and impossible.
Constraint 3 is not violated — a zero on the river is unreachable — but "capital multiplies" is
something the charter asserts and the code does not do: the game computes a product of three.

**2 · The weight of the fourth factor, paired, over a range no run ever spans:**

| river frozen | hunter blooms / tiers | spreader | linker | idle |
|---|---|---|---|---|
| **1** | 6.99 / **16.13** | 6.04 / 10.98 | 6.73 / 14.53 | 3.19 / 3.19 |
| natural | 6.99 / 15.86 | 6.25 / 11.21 | 6.80 / 14.54 | 3.44 / 3.44 |
| **10** | 6.99 / **15.55** | 6.28 / 11.03 | 6.75 / 14.13 | 3.76 / 3.76 |
| Δ(10−1) | **0.00 ±0.00 / −0.58 ±0.02** | +0.24 / +0.06 | +0.01 / −0.40 | +0.57 / +0.57 |

The whole dynamic range of capital moves the diagnosing player's bloom count by **0.00** and *lowers*
tier depth by 0.58 (3.7%). It is worth +0.57 blooms (18%) to the player who does nothing. A hunter on the
worst river (16.13) beats a spreader on the best (11.03) and an idler on the best (3.76) — the fourth
factor cannot reorder the band. Attribution (§7): a fuller river fires the bloom **a season earlier**
(mean s5.22 → s4.29) at a **lower product** (478 → 438), before the hunter has finished raising the
person; tier-3 workshops standing 2.49 → 2.01, crushes unchanged (0.23 vs 0.25). Sim-frame caveat: the
sim has no post-bloom tending, so in the game that tier loss is recoverable with later acts; the
bloom-count reading (0.00) is not an artifact of the mirror. Per person, river 1→10 changes nobody's
bloom rate under the hunter (100% throughout); under idle it lifts the borderline people ~+10 pts
(Bé Ngân 25.8 → 36.4, Anh Tú 52.5 → 66.3, Cô Liên 17.8 → 26.3).

**3 · The river is downstream of the outcome, not upstream of it.** Points of rise per hunter run:
start 2.60 · quarterly clock 1.83 · **flywheel 5.58** · gtm 0.00. The flywheel (`tierSum() ≥ 4 → +1 per
season`, `:1324`) is 56% of all rise and is a *consequence* of workshops standing. Von reaches 10 by the
end in **100%** of hunter runs (99.4% spreader, 99.8% linker; idle 38%) and sits at 8.0 by s7. The mean
multiplier at the moment a bloom is rolled is 0.75–0.78 — i.e. blooms are decided while the river is
still ~4–5, and the river then fills *from* them. Seasons at von ≤2 (the bare-stall state): ~2 per run,
6.0 in the flood year.

**4 · The hụi verb, priced.** Paired against the same strategy without it:

| | blooms | tiers | Δ blooms | Δ tiers | hụi acts |
|---|---|---|---|---|---|
| hunter + hụi FIRST (from unlock, first acts, to max) | 6.98 | 15.17 | −0.01 | **−0.70 ±0.02** | 3.20 |
| hunter + hụi only in empty slots (nobody to tend) | 6.99 | 15.86 | 0.00 | 0.00 | 3.20 |
| hunter + hụi LATE (s12+) | 6.99 | 15.86 | 0.00 | −0.01 | 3.20 |
| huiOnly (idle + the 3 hụi acts, knows no one) | 3.63 | 3.63 | **+0.19** | +0.19 | 3.20 |

Pressing the hụi early costs the diagnosing player 4.4% of tiers and buys 0.00 blooms — in **every**
year card (−0.67 … −0.72), including the flood year whose card reads *"the xóm leans on the hụi"*
(4 acts, −0.67 tiers, 0.00 blooms; the river ends at 10.00 with or without them). Pressed in slots
where there is nobody to tend it is exactly free, because the river was reaching 10 anyway. Decomposed
by pinning the river (so the hụi can add nothing): the pure act cost of three hụi presses is −0.54
tiers; the river they buy is worth **−0.16** — the one thing the verb does (fill the river sooner)
is itself worth ≤0 to the hunter in the sim's frame. The intro card's *"tie one of your own hands? —
không hụi"* therefore prices at ≥0 for a diagnosing player: the tied hand was not doing anything.
For the idle player the three presses are worth +0.19 blooms — the fourth factor is a lever mostly
for the player who pulls no other.

**5 · What the game says about the river against what it computes.**
- `riverLow` (`:223`, fires s5 at von ≤3): *"The river runs low — any workshop stays a street stall."*
  Tiers never read the river; the river-1 hunter stands **more** tier-3 workshops (2.49) than the
  river-10 hunter (2.01). The line promises a mechanic that does not exist.
- `actHui` (`:1181`) floats `🌱 <round(chance·100)>%` on every known sprout — *"every named sprout
  visibly rises."* One point of river moves the multiplier by 0.04; on the authored cast at the hụi
  seasons the rounded integer is **unchanged in 62.0%** of sprout-floats, and in **80.6%** for products
  under 100 — the people nearest zero, the ones the thesis is about (mean change +0.38 points; ceiling
  of visibility for the weakest, floor for the strongest since tended products run higher).
- A save/load defect, minor and real: `cl(s.hui,0,3,0)` (`:473`) clamps the hụi counter to 3, but
  `huiMax()` is 4 in a flood year, so after four contributions a reload re-enables the button for a
  fifth (+1 river, one more act). Not shipped, per Gear 3.

**Argues for:** a reductive candidate that the six earlier findings did not contain — **the fourth
factor is decoration.** Either make capital a factor in the code's sense (a multiplicand that can bite:
part of the product or the tier, with a floor that can approach 0 — a balance decision that would put
the band gate on the table, like `schoolfirst` and `spreaderU`), or stop presenting it as one: drop
the hụi verb, the vow, the river tag on the sheet and the `riverLow` promise, and let the river be
what the charter already calls it — *"neither is anyone's to command,"* scenery on the same footing as
the sky. Every standing owner directive is reductive and this is the largest single subtraction the
lab has yet found with a number attached (one verb, one vow, one string, one tag; 0.00 blooms of
consequence). It also sharpens the "price of being wrong" lever: the hụi is a verb whose only price is
opportunity and whose reward is invisible on screen four times in five. **Argues against:** any era
that adds economy — more hụi, a market, capital per person — since the existing capital dial has no
leverage to build on; against reading the flood year as a capital challenge (its hụi return is 0.00
blooms, its river ends at 10.00 regardless); and against citing "four factors multiply" as something
the game demonstrates — it demonstrates three, and the sheet already says so.

**Not shipped, per Gear 3.** `index.html` and `check.js` untouched; probe `lab/fourth.js`, output
`lab/fourth-out.txt` (both gitignored).

**Verdict:** new-argument
*Grader:* No prior entry (zerohunt/zerowitness/decide all probe the three personal factors; attach8/thumb390/chatprobe are UI) and no parked candidate in MILESTONES.md addresses capital, the river or the hụi, so "the fourth factor is decoration — remove it or make it bite" is a subtraction candidate that did not exist before, and it also rules out any economy-adding era.

## 2026-08-15 — where is the decision? diagnosis decomposed into what · who · when (`decide.js`)

Owner gate #1 says *"Diagnosis feels like play. Finding which factor is zero is the fun part, not
homework."* Two vigils asked whether the zero is sharp and whether it is witnessed; this one asks what
the player's diagnosis is **worth** — how much of the hunter's margin comes from picking the right
**factor** (WHAT), how much from picking the right **person** (WHO), how much from acting at all, and
how often either is even a choice. Underneath it, a harness question: what exactly is the band gate's
spreader losing to?

Harness: `check.js`'s sim verbatim, same seeds (`1009+i·53`, N=6000), so every comparison is **paired**
— one seed is the same cast, year card and sky for every strategy, and the ±SE below is on the paired
difference. `idle`/`spreader`/`hunter` are bit-exact to `check.js` (drift check exact: 6.99/15.86 ·
6.25/11.21 · 3.44/3.44). Every ablation is **cap-faithful**: in the game a factor at 10 has its button
disabled (`index.html:1596-1598`), so an ablation whose preferred factor is capped falls through to
its next preference instead of silently wasting the act. No strategy here forms pairs, so the
elder-clock variant (LANDMINES) is moot — the clock runs identically under all of them.

**1 · The band's spreader loses to waste, not to diagnosis.** In act slots with someone still
unbloomed, `check.js`'s spreader aims **45.1%** of its acts at an already-bloomed person (the sim
discards these) and **5.5%** at a factor already at 10 (the game's button is disabled) — **50.7% of
its acts do nothing.** Remove the waste and keep the blindness — a random *unbloomed* person, a random
*uncapped* factor, no diagnosis of any kind:

| | blooms | tiers | Δ tiers vs hunter (paired) |
|---|---|---|---|
| hunter | 6.99 | 15.86 | — |
| `check.js` spreader | 6.25 | 11.21 | −4.65 ±0.03 |
| **spreaderU** (no waste, no diagnosis) | **6.96** | **15.53** | **−0.33 ±0.02** |
| idle | 3.44 | 3.44 | −12.42 |

Of the 4.65 tiers the gate calls "diagnosis beats spreading", **4.32 (93%) is the spreader throwing
acts away and 0.33 (7%) is diagnosis.** The predicate `tiers.hunter > tiers.spreader + 3`
(`check.js:135`) is not satisfiable by any diagnostic advantage the game contains; it is satisfied by
an opponent who plays half a game.

**2 · WHAT is worth 5–11% of tiers and ~1% of blooms.** Hold WHO = the hunter's own target (the
person holding the xóm's lowest single factor) and vary only the factor pressed:

| WHAT, on the hunter's target | blooms | tiers | Δ tiers |
|---|---|---|---|
| the weakest (hunter) | 6.99 | 15.86 | — |
| a random factor | 6.97 | 15.25 | −0.62 |
| the middle factor | 6.94 | 15.10 | −0.76 |
| **the strongest** — the inverse of the thesis | **6.93** | **14.53** | **−1.33** |

Feeding the weakest person's *strongest* factor costs 1% of blooms and 8% of tiers. Bloom count —
the banner, the gong, the petals — cannot see WHAT at all; only the tier pill can, and faintly.

**3 · WHO is inert, or inverted.** Hold WHAT = correct (that person's own weakest factor) and vary
the person: random **+0.26** · round-robin **+0.16** · "the first person you met, until they bloom"
**+0.70** · hunter's pick but stay until they bloom **+0.38** · largest marginal chance **+0.32** ·
lowest product **−0.17** · **highest product, i.e. closest to bloom: +1.24 ±0.02.** Every rule that
picks *a* person and presses their weakest button lands within ±0.3 tiers of the hunter or beats it.
The game's canonical diagnostician — "find the zero in the xóm" — is the worst sensible WHO rule,
beaten by 8% by "finish whoever is nearly done". Pure anti-diagnosis on both axes (`maxerU`: the
strongest person's strongest factor) keeps **98% of tiers** (−0.19) and 89% of blooms.

**4 · How often is it a choice at all?** On the hunter's own 24.8 acts per run: the target's
weakest factor is **tied** with another in 18.8%; two or more people share the xóm's minimum in
29.0%; in 18.2% exactly one unbloomed person is left (no WHO exists); mean candidates per act 2.92.
In **34.6%** the target's min is ≤3, so the map has already printed `số không: <factor>` and no
sheet is needed. A player who acts only on labelled people, presses the labelled factor, never opens
the sheet, and does nothing when no label shows (`labelOnly`) keeps **92% of the hunter's blooms**
(6.70; the deficit is tiers, 60%, from idling). And the hunter touches **6.68 distinct people per
run, 6.48 by season 8** — the diagnostician's play *is* spreading; what it does differently is press
a different button on each of them.

**5 · Quantity and timing.** One act per season with perfect diagnosis (`hunterOne`) keeps 94% of
blooms and 65% of tiers; the hunter idle until season 5 keeps 99%/86%; idle after season 8 keeps
98%/96%. Blooms saturate at the cast; tiers are the only channel with slack, and the slack is mostly
*how many* acts, not *which*. In the sim's frame the hunter has someone to tend in only 24.8 of 45.9
act slots (54%) — the sim has no post-bloom tending, so that is a limit of the mirror, not a game
measurement.

**6 · A correction to a banked row.** `zerohunt.js`'s `avoider` (4.75 / 6.13) and `maxer`
(4.93 / 7.14) raise `maxKey` with no cap check; once that factor is 10, every later act on that
person is a silent no-op that the game's disabled button would never permit. Cap-faithful, the same
two strategies score **6.93 / 14.53** and **6.60 / 15.67**. `zerohunt`'s headline (4.6× on tiers,
2.0× on blooms) was hunter-vs-**idle** and stands; its table row that reads "anti-diagnosis costs
60% of tiers" was measuring wasted acts, and the true cost under the game's rules is ~8%. Logged in
`LANDMINES.md`.

**Argues for:** the "sharpness of the zero" candidate, with a third lever after *floors* and
*witness* — **the price of being wrong.** Under the game's own arithmetic a wrong factor costs ~8%
of a number most players never read, and a wrong person costs nothing or pays; a player can play the
inverse of the thesis on both axes and keep 98% of the outcome. If diagnosis is to feel like play
there must be something the player can lose by, and today there is not. Concretely it argues for a
**fair opponent in the band gate** (`spreaderU`) — and against pretending that is free: `hunter.ts >
spreaderU.ts + 3` fails on the first commit (15.86 vs 15.53), so it is a ratchet with a balance
decision attached, exactly like `schoolfirst`. **Argues against:** any era that adds diagnosis *UI*
— hints, a detective mode, a clearer sheet — since the answer is already displayed (three numbers,
and a red label 35% of the time) and the reward for reading it is 3% of tiers; and against reading
`whoNear`'s +1.24 as an isolated balance bug — it is the same fact from the other side: tiers reward
whoever blooms earliest, not whoever stood nearest zero.

**Not shipped, per Gear 3.** `index.html` and `check.js` untouched; probe `lab/decide.js`, output
`lab/decide-out.txt` (both gitignored).

**Verdict:** confirms-known
*Grader:* It adds a third lever ("the price of being wrong", plus a fairer `spreaderU` band opponent) inside the same "sharpness of the zero" candidate that `zerohunt.js` opened and `zerowitness.js` already refined, so it strengthens an existing era rather than opening or killing one.

## 2026-08-15 — the literal zero: who produces it, and does anything witness it? (`zerowitness.js`)

The last vigil established the zero is *soft* — the authored floors are 1s and a 1 blooms about half
the time — and located the fable's absolute in "exactly one place: a crushed villager driven to GAN
0". This probe goes to that place and asks the next question, which is not frequency but **witness**:
every code path that can drive a factor to exactly 0, how long a 0 survives, and which of the game's
"someone fell" systems can see one while it is happening.

Harness: `check.js`'s sim verbatim plus instrumentation, 6000 runs × 4 strategies × 2 elder-clock
variants. **Drift check printed in the output and exact**: hunter 6.99n/15.86ts, spreader 6.25/11.21,
linker 6.80/14.54, idle 3.44/3.44 — identical to `check.js` and `zerohunt.js`, so the instrumentation
changed no roll.

**1 · Three paths can reach 0, and one of them is structurally dead.** `gan−3` on an erased tier-1
workshop (`index.html:1297`); `gan−2` on a stamped tier-2+ workshop (`:1293`); and the elder's clock,
`tai−1` every season from s8 while Chú Ba is unbloomed and unapprenticed (`:1384`). The stepdown path
produced **0 zeros in 48,000 runs** and cannot ever produce one: tier 2 needs `prod≥300`, and with
`tai,ban ≤ 10` that forces `gan ≥ 3`, so `gan−2 ≥ 1`. It is not rare; it is impossible.

**2 · The literal zero is anti-correlated with play.** Share of runs containing any factor at exactly
0, and person-seasons spent there:

| strategy | runs with a literal 0 | person-seasons at 0 / run | first 0 at season |
|---|---|---|---|
| hunter (diagnose) | **0.0%** (1 event in 6000 runs) | 0.00 | 14 |
| spreader | 1.9% | 0.01 | 5.0 |
| linker | 3.6% | 0.07 | 6.3 |
| idle (never acts) | **13.3%** | 0.39 | 10.2 |

The player the game is built to reward **never meets the arithmetic the game is about**. `10×0=0` is
reserved for the player who isn't playing: 7 of every 8 runs contain no zero even when nobody acts at
all, and a diagnosing player can play a hundred games and never see one.

**3 · When a 0 does happen, it is usually undone by something the player did not aim at.**

| strategy | ended by player act | by communal lift | by inspiration (someone *else* blooms) | still 0 at s16 | bloomed later anyway |
|---|---|---|---|---|---|
| spreader | 11.9% | 52.5% | 27.1% | 8.5% | **83.6%** |
| linker | 5.0% | 0.0% | **71.3%** | 23.8% | **63.5%** |
| idle | 0.0% | 0.0% | 0.0% | **100%** | 0.0% |

Every bloom hands `+1 GAN` to everyone present (`:84` in the sim, `index.html` inspiration) — so the
commonest exit from a literal zero is a stranger's good season. And 64–84% of people who touched 0
still bloom inside the same run. **The absolute is not absolute in play; it is a dip.**

**4 · The witness gap — the elder's zero is the one no "someone fell" system covers.** The despair
voice (`:341`, `:365`), the communal lift (`:1121`) and the ending's stamp tally (`:1512`) all key off
`p.crushCount>0`, which only the erase path sets. The elder's clock sets nothing. For `idle` — the
strategy where the literal zero actually lives — **58.3% of zeros arrive by the elder's clock** and
are invisible to all three. What the clock does have (a one-time "🕯 mắt Chú Ba mờ dần" log and a
per-season `−1 TÀI 🕯` float) is gated on `ba.known`, and a player who never taps him never sets that
— so in exactly the population that produces this zero, the float does not render either.

**5 · The vocabulary says "zero" ~125–1000× more often than the arithmetic contains one.** The map
hint prints `số không: <thừa số>` whenever `min ≤ 3` (`zeroOf`, `:1035`), and the ending prints
"*thừa số X vẫn nằm ở số không*" on the same ≤3 test (`:1436`, `:1519`):

| strategy | labelled person-seasons / run | of which truly 0 | ending "stayed at zero" lines / run | of which truly 0 |
|---|---|---|---|---|
| spreader | 20.12 | **0.1%** | 0.06 | 2.6% |
| linker | 12.20 | 0.5% | 0.08 | 11.3% |
| idle | 48.89 | **0.8%** | 1.38 | 3.1% |

And at the instant a life *does* become arithmetically impossible, **no on-screen state changes**: the
label already read `số không` three seasons earlier at 3, and keeps reading it; the only surface that
distinguishes 0 from 3 is the `multLine` product in a sheet the player must tap open (`8 × 0 × 4 =
0`). The word is doing the work the number is not.

**6 · Who carries it.** Zero entries per 1000 runs: idle — Chú Ba 97.0, Bé Ngân 36.7; linker — Bé Ngân
26.5, Chú Ba 9.0. The two authored 1s (Ngân's GAN, and the elder whose TÀI is spent by time) are
effectively the whole distribution. The apprentice-aware variant (`index.html:1384` stops the clock
when pair 0-1 exists; `check.js`'s sim has no apprenticeship) moves linker's elder path 1.7 → 0.3 per
1000 and changes nothing else — both variants are in the output.

**Argues for:** sharpening what the previous entry called soft — but the lever this one points at is
**witness, not floors**: a zero the diagnosing player never encounters, cannot be told apart from a 3
on any surface except a tapped panel, and is most often ended by a bystander's bloom. A reductive era
here would make the arithmetic legible at the moment it happens rather than add systems: one honest
option is to stop the game saying "số không" for a 3. **Argues against:** an era that reaches for the
zero by making stamps harsher — the erase path is already the only live producer, its victims are
already covered by all three witness systems, and 84% of them bloom anyway; and against any reading
of the elder's clock as a designed encounter with the absolute, since it is silent, unrecorded, and
lands almost exclusively on players who are not looking.

**Not shipped, per Gear 3.** `index.html` and `check.js` both untouched; probe is `lab/zerowitness.js`,
output `lab/zerowitness-out.txt` (both gitignored).

**Verdict:** confirms-known
*Grader:* It refines the "sharpness of the zero" era already opened by the `zerohunt.js` entry (soft zero, crush as the only true 0, reductive floor-tightening) — shifting the lever from floors to witness/legibility is a variant inside that same candidate, not a new era or a kill of one.

## 2026-08-15 — does the multiplication actually *decide*? (`zerohunt.js`)

Three previous vigils measured the game's **voice** (chatter rate, attachment curve) and its **hands**
(390px reach). This one goes at the charter itself. Constraint 3 says *any system that lets a player
route around a zero is off-limits* — and nothing has ever tested it. `check.js` tests a **strategy
band** (hunter > spreader > linker > idle), which is a different claim: it says diagnosis *wins*, not
that the weakest factor *decides*.

Harness: `check.js`'s sim verbatim (first re-verified undrifted from `index.html` at v0.28 — only two
read-only conditionals entered the file since `check.js` was written), plus per-bloom provenance
(*was that person's authored weakest factor ever raised by a player act before the bloom fired?*),
three adversarial anti-diagnostic strategies, and subsystem ablations. 6000 runs per strategy.

**1 · The fable's zero is a 1, and 14 seasons turn a 1 into a coin flip.** `chance()` is
`prod/1000·0.9·(0.6+0.4·von/10)`, rolled every season for every present villager whether or not the
player has ever looked at them. Frozen, unhelped:

| the person | per season | P(bloom in 14 tries) |
|---|---|---|
| 1×9×9 = 81 (Bé Ngân's shape) | 5.3 – 7.3% | **53 – 65%** |
| 1×8×4 = 32 (Cô Liên's shape) | 2.1 – 2.9% | 25 – 34% |
| 0×10×10 = 0 (only reachable by a **crush**) | 0.00% | **0.0%** |

Measured in play, `idle` — the player does *nothing at all*, all 16 seasons — still blooms **3.44 of
7** workshops. Bé Ngân (GAN 1) blooms unaided in **30.4%** of runs, Cô Liên (BẠN 1) in 20.9%, Chị Hoa
(TÀI 2) in 60.8%. The hunter's **marginal** blooms over doing nothing are **3.55 of 6.99 — half of
what a diagnosing player earns, they would have got by watching.** The literal ×0 exists in exactly
one place: a crushed villager driven to GAN 0, where the roll is exactly zero forever.

**2 · The separation is real, but it lives in the channel the player doesn't see.**

| | blooms/run | tiers/run |
|---|---|---|
| hunter (diagnose the zero) | 6.99 | **15.86** |
| linker (blind pairs) | 6.80 | 14.54 |
| spreader | 6.25 | 11.21 |
| maxer (feed the strongest) | 4.93 | 7.14 |
| avoider (**raise the weakest person's strongest factor**) | 4.75 | **6.13** |
| idle | 3.44 | 3.44 |

Diagnosis separates **4.6× on tier depth** and only **2.0× on bloom count**. A bloom is a banner, a
gong and a petal burst; a tier is a pill most players never read. **The thesis is proven in the
quiet channel and only hinted at in the loud one** — which is a sharper reading of owner gate #3
("the thesis lands from play alone") than any amount of writing would give.

**3 · The provenance number, and it is the charter's own question.** Share of blooms that fired
while the player had *never once* raised that person's authored weakest factor:

| strategy | routed | min factor was still ≤2 at bloom |
|---|---|---|
| hunter | 5.4% | 0.0% |
| linker | 58.4% | 10.5% |
| spreader | 39.3% | 13.0% |
| **avoider** | **99.9%** | **25.1%** |
| idle | 100% | 36.0% |

A quarter of the avoider's blooms happen with the weakest factor still at 1 or 2. Strictly, this is
not *routing around* a zero — 1×9×9 is 81, not 0, so the arithmetic is honest and the constraint is
not violated. What it does say is that **the game's zero is soft**: the fable's absolute (`10×0=0`)
is only ever reached through a crush, and the authored cast starts at 1, where patience substitutes
for diagnosis about half the time.

**4 · The school is an automated diagnostician — and the release band cannot see it.** `schoolfirst`
(diagnose exactly *one* person, Cô Mai, until her class opens; then link blindly forever, never
diagnosing again) scores **6.79 blooms / 15.02 tiers** against the hunter's 6.99 / 15.86. **88.9%**
of its routed blooms had their TÀI fed by the school or the mentor drip rather than by the player.
Ablations confirm the school is the carrier — the hunter's margin over the best non-diagnostic
strategy goes **0.84 → 2.13** with the school off, and **→ 2.82** with school and momentum both off.

Re-running `check.js`'s own band predicate (`check.js:132-136`) with `schoolfirst` added to the field:

```
PASS  hunter.n  > spreader.n + 0.5      6.99 vs 6.75
PASS  hunter.ts > linker.ts   + 1.0    15.86 vs 15.54
PASS  idle.n   <= 4.0                   3.44
FAIL  hunter.ts > schoolfirst.ts + 1.0 15.86 vs 16.02      ← not in the gate at all
FAIL  hunter.n  > schoolfirst.n  + 0.5  6.99 vs  7.29      ← not in the gate at all
```

The band is not broken — it is **blind**. Its margins were calibrated against three strategies
someone thought of, and the most natural non-diagnostic line in the actual game ("bloom the teacher,
then just introduce people") lands inside them. Note the trap for whoever picks this up: adding
`schoolfirst` to `check.js` would turn a green gate red *on the first commit*, and the only fix is a
design decision about Cô Mai's class. That is a ratchet with a balance question attached, not a free
gate. The v0.17 note at `check.js:137` already recorded the smell ("Cô Mai's school legitimately
compounds… margin recalibrated 1.5→1.0") — this is the number under that intuition.

**Argues for:** an era about **the sharpness of the zero** — the game's weakest link is currently a
1, softened further by a class that quietly fixes TÀI, and the evidence of diagnosis lands in tier
depth rather than in anything the player sees. The reductive version is the strong one: make the
authored floors bite (a true 0 in the cast, or a `prod` floor that idles at ~0), cut the free
blooms, and let the loud channel carry the thesis. **Argues against:** any era that adds a *new*
compensating system — the school already shows what an automated diagnostician does to the band, and
a second one would erase it. Also argues against treating `check.js`'s green as proof of the thesis:
it proves diagnosis wins a race, not that the weakest factor decides a life.

**Not shipped, per Gear 3.** `index.html` and `check.js` both untouched; the whole probe is a copy in
`lab/zerohunt.js` (gitignored), output `lab/zerohunt-out.txt`.

**Verdict:** new-argument
*Grader:* No prior entry (voice/attach8, thumb390, chatprobe) and no parked candidate in MILESTONES.md addresses the softness of the zero or a reductive floor-tightening era; the closest prior is only the check.js:137 v0.17 margin note, which this quantifies and extends into a candidate that did not exist before.

## 2026-08-15 — the attachment curve, and a dead ambient channel (`attach8.py`)

Owner gate #2 says *"You care about someone by season 8."* Last tick measured the **reachable**
half of the device gate; this measures the **fuel** half of the felt gate — not whether the player
feels it (only the owner can say), but how much authored, person-specific voice each villager
actually puts on screen, and where the curve sags. Instrumented `bubble()`/`logMsg()` over 7 paced
16-season runs (5.2s of real dwell per season, so ambient life gets its chance — the `gate.sh`
full-run driver advances all 16 seasons synchronously and cannot answer this).

**Measured — the curve inverts exactly at the gate's season:**

| season | personal lines/season | cast present | lines per present villager |
|---|---|---|---|
| 0–4 | 3.9 – 5.0 | 2.0 → 6.3 | **1.16** at s2 |
| 5–8 | 2.1 – 3.4 | 6.3 → 7.0 | **0.49** at s8 |
| 9–15 | 1.9 → 0.3 | 7.0 | **0.04** at s14 |

The xóm gets **fuller and quieter at the same time**. By season 8 the median villager says nothing
in a given season; Cô Mai is mute in **7.0 of the 9 seasons** she is present, Anh Vũ 6.4 of 8.
Longest present-but-mute stretch, per villager, runs to **12–14 consecutive seasons**.

**Measured — most of the writing never reaches the player.** Distinct authored lines seen by
season 8, against what is authored for that person: Cô Mai **2.3/7**, Chị Hoa 2.3/9, Anh Vũ 3.0/9,
Cô Liên 3.4/9, Anh Tú 3.6/10, Chú Ba 4.0/11, Bé Ngân 4.4/12. Aggregate ≈ **23 of 67 — a third.**

**The mechanism, and it is a defect: `chatter()` is unreachable.** Every season, `nextSeason()`
schedules the one ambient roll at **+1100ms** (`index.html:1404`, *"after the season banner
settles, the xóm talks"*) — but the line above it calls `banner(…,1600)`, and `banner()` beats for
`dur+600` = **2200ms** (`index.html:426`). So the roll lands *inside* the banner's own beat and
`chatter()`'s first guard correctly refuses it. Instrumented: **15 of 15 calls per run preempted at
`now<beatUntil`, 0 bubbles ever produced.** Confirmed independent of the player by an idle probe
that performs **no actions at all** — measured slack `beatUntil−now` = **+2400ms** at every call.
It is not a race and not a player-behaviour artifact; the timer simply never clears the banner.

Fallout — content that no player can reach, because `chatter()` is its only call site:
- `CHAT_SEASONAL` (`index.html:296`, cited only at `:344`) — 4 lines, Tết / harvest / mid-autumn /
  the cold coming back. **Dead.**
- every villager's `chatS` storm voice (cited only at `:343`) — 7 lines. **Dead.** The xóm has an
  authored reaction to the storm year and has never once spoken it.
- 22 authored bilingual strings in total, all counted as present by the 131/131 parity gate.
- Pair-talk survives at a reduced rate: `chatter()`'s pair branch is dead too, but `pairTalkAt()`
  is also reached from the dwell path (`:609`, 25% on arriving at a friend's, 25s cooldown) — so
  **the four authored pairs are the only villagers with any ambient voice at all.** Everyone else
  speaks only when the player clicks them, blooms them, or crushes them.

**Reading it:** the sag measured above is not a content shortage — the content exists, is written,
is bilingual, and is sitting behind a guard that has never opened. The late game is quiet because
after the early seasons the player stops clicking (everyone met, blooms slow) and the ambient
channel that was supposed to carry the xóm has been off the whole time.

**Argues for:** a candidate era around **the xóm having a voice of its own** — the cheapest version
is a one-line delay fix, but the interesting version is that the game already contains a written
ambient layer it has never played, and the owner should hear it before deciding how much more it
wants. **Argues against:** any era premised on *writing more villager dialogue*. The measured
ceiling is not authoring; two thirds of what is already authored has never been seen.

**Not shipped, per Gear 3.** `index.html` untouched. This is a real defect that would qualify under
the ship budget's clause (c), and it is exactly the kind of thing Gear 3 must hand to the owner
rather than quietly fix — see the `OWNER:` line in the tick report. Harness: `lab/attach8.py`,
output `lab/attach8-out.txt` (both gitignored).

**Verdict:** new-argument

## 2026-08-15 — 390px tap-reachability audit (`thumb390.py`, `zoneblame.py`)

Rasterised the real tap resolver (`index.html:1061-1097`) over the whole 960×600 logical plane at a
390px viewport, for 18 snapshots across all 16 seasons, and asked what a thumb can actually reach.
Geometry only — this measures the *reachable* half of the owner gate, not the *felt* half.

**Measured:**
- Canvas at 390px is **480.0 × 296.2 CSS px**, scale 2.000 logical-px per CSS-px. `hitR` resolves to
  44 logical px = **22.0 CSS px** exactly, i.e. the `max(34, 22*scale)` floor is doing its job and
  the slop does *not* degrade on a small screen.
- **ECLIPSE: 0.** Every villager, every season, holds a full undisturbed 1513 CSS px² tap disc
  (π·22²). Nobody is ever on-screen-but-unselectable. The "nearest wins" resolver was the suspected
  failure mode at small sizes; the cast is spread widely enough that it never bites. **Cleared.**
- **OCCLUSION: real, and it is the newest feature that pays.** The place-tap (hỏi thăm, shipped
  v0.26) only fires when *no* villager wins, and the villager whose home is a place is precisely the
  one standing on it. Pooled over all samples:
  | zone | taps stolen | by |
  |---|---|---|
  | market (`c`) | **20.7%** | Chị Hoa |
  | đình (`d`) | **14.0%** | Cô Mai |
  | river (`r`) | 1.0% | Cô Liên |
  Per-season peaks run to **27% of the market zone dead**, from season 3 onward. The figure drifts
  run to run (villagers wander): two runs gave 47 and 37 occluded zone-seasons.

**Reading it:** not a bug with a victim — a stolen tap selects that villager instead, and since
`S.looked[zone]` is only set on a *successful* place tap the player can retry. But the affordance
is quietly unreliable in exactly the wrong spot: aim at the stall, get Hoa's portrait. Roughly one
market tap in five misses, and the player has no way to know why. The irony is load-bearing —
*the villager who lives at the market is the one who hides the market.*

**Argues for:** a candidate era around **legibility of the place layer** — the places are currently
a hidden verb, competing with the cast for the same pixels and losing. Options worth prototyping if
the owner ever opens it: give zones priority when the tap lands inside the zone rectangle rather
than letting the villager pass win by proximity; or make the places visibly tappable at all.
**Argues against:** any "make tap targets bigger for phones" era — the slop floor already holds at
390px and eclipse is at zero. That worry is now retired with a number.

**Not shipped, per Gear 3.** `index.html` untouched. Harnesses live in `lab/` (gitignored).

**Verdict:** new-argument

## 2026-08-15 — the ambient layer, measured after the fix (`chatprobe.py`)

The owner's directive authorised the timing fix; this is the measurement that justified shipping it
and the numbers that should inform any later decision about the *rate* (which was NOT touched).

**Harness note, and it is the reason two earlier attempts read zero.** Counting ambient bubbles in
headless needs two artifacts defeated. (1) **Pacing** — the release gate advances all 16 seasons in
one synchronous loop, so every season's chatter timer fires at the same virtual instant and the
`bubbles.length>=2` guard eats them all. (2) **The render loop** — under `--virtual-time-budget`
the clock fast-forwards between timers and rAF is starved: **10 `drawScene` calls across 112
virtual seconds**. Bubbles are pruned only in the draw loop (`index.html:844`), so they accumulate
(measured `bubbles.length` of 40–74) and the same guard stays permanently tripped. Driving
`drawScene` by hand at 10fps fixes it; 60fps gives the same answer (4.33 vs 4.67 per run — noise),
so 10fps is the cheap fidelity.

**A/B, 8 paced 16-season runs each side, identical harness:**

| | calls | preempted by a beat | ambient bubbles |
|---|---|---|---|
| v0.27 (fixed +1100ms) | 120 | **120** | **0** |
| v0.28 (waits on `beatUntil`) | 120 | **0** | **36** (4.5/run) |

**What is now heard:** 20 distinct authored lines across 8 runs — all four `CHAT_SEASONAL` lines
(Tết / harvest / mid-autumn / the cold), three villagers' `chatS` storm voices (Bé Ngân, Anh Tú,
Chú Ba, plus Anh Vũ's in a later sample), and both `PAIR_TALK` openers of the 0-1 apprenticeship.
Every one of these had a lifetime play count of zero before this round.

**The rate, for the owner — reported, not tuned.** 4.5 bubbles per 16-season run is **~0.28 per
season**, i.e. the xóm speaks unprompted about once every 3–4 seasons. The risk the directive
warned about (chatty) did not materialise; the opposite is the live question. Where the calls go,
weighted over 120: **53 blocked by `bubbles.length>=2`**, ~27 by the deliberate `Math.random()<0.4`
mute roll, 36 spoke. The blocking figure is partly this harness (it fires all of a season's acts in
one burst, so stat floats — which share the same `bubbles` array via `floatOn`, `index.html:1208` —
are still on screen when chatter rolls), but not entirely: in real play a season's resolution
floats are also synchronous. **If the owner ever wants the xóm louder, the honest lever is not more
writing and not the mute roll — it is that ambient speech competes for a 2-slot queue with numeric
stat floats, which are not speech.** Separating those two arrays would roughly double the rate
without touching a single probability.

**Two visual observations, neither fixed (timing-only round):**
- At the true 390 canvas (480 CSS px wide, reproduced with `--window-size=500`), the longest
  ambient line wraps to two lines and stays inside the frame. Fine.
- Bubbles clip at the canvas top edge when the speaker stands in the upper band, and two
  simultaneous bubbles can overlap at 480px. Both are pre-existing `drawBubble` placement
  behaviour shared with arrival quotes — but the ambient layer will now surface them far more
  often than it used to. Candidate work, not this round's.

**Verdict:** new-argument

