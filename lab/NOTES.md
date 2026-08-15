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

