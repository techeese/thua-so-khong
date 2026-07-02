# Changelog — Thừa Số Không

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
