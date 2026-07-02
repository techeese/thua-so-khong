# Changelog — Thừa Số Không

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
