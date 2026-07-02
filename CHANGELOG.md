# Changelog — Thừa Số Không

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
