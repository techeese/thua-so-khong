# Milestones — the eras of Thừa Số Không

The loop is **convergent within a layer and infinite across layers.** Each era has a name and a
*closed* definition of done. When it closes, the loop runs a **synthesis**, picks a candidate,
defends it against critics, and opens the next — and when a whole layer runs out of road, it
escalates rather than halting (`LADDER.md`).

```
   layer opens ──▶ convergent iterations ──▶ done.sh: exhausted
        ▲                                          │
        │                                          ▼
   critics pass ◀── SYNTHESIS ──▶ nothing survives twice ──▶ escalate a layer
```

Drift is what happens when a compass rotates because the loop is bored. This is different: new
work is opened **deliberately**, at a moment of reflection, and only after surviving criticism.
Infinite development, finite iterations.

---

## Era 1 — "The fable is playable" · opened 2026-07-02 · **OPEN**

**Intent:** a xóm you can play in sixteen seasons, where the multiplication teaches itself.

**Done when:** `./done.sh` exits 10 or 20 — every machine gate green, and the owner's felt gate
in `OWNER-GATE.md` answered.

**Shipped:** v0.2 → v0.26. The Đông Hồ art pass, the cast and their pairs, year cards, workshop
tiers, the school, the hụi, the errand governor and the living xóm, the endings and the chronicle,
PWA + share kit, the full 16-season VI/EN gate.

**Interrupted:** 2026-07-02 → 2026-08-14, 43 days. The loop's continuity lived in a session
instead of on disk; Pages stalled and nothing checked the live URL. Both fixed in the v3 loop.

---

## The synthesis protocol (runs when an era closes)

Not a retrospective. A **design act** — the one moment where unbounded ambition is correct,
because it costs nothing to ship and happens once per era.

1. **Read the whole thing as a stranger.** Play it end to end. Read the CHANGELOG as a single
   narrative. What did this actually become — not what was intended?
2. **Name what's load-bearing.** Which systems carry the thesis, and which are decoration that
   survived because nobody removed them? Decoration is a subtraction candidate for the next era.
3. **Find the unspent potential.** What does the game now make *possible* that it doesn't yet do?
   The best next era is usually latent in what already shipped, not bolted on beside it.
4. **Propose 3–4 candidate eras**, each with: a one-line intent, what it would add or remove, what
   its `done.sh` gates would be, and honestly — what it would cost and what it might ruin.
   At least one candidate must be **reductive** (an era that makes the game smaller and sharper),
   and at least one must be **a real swing** (something that changes what the game is).
5. **Write it to `SYNTHESIS.md`.** Then, under full autonomy, **pick one yourself** — and defend
   the pick against the adversarial review below before anything is written.

## How an era ends — three ways, all routing to synthesis

| | condition | detected by |
|---|---|---|
| **Completed** | every gate green, felt gate included | `done.sh` exit 20 |
| **Exhausted** | converged, and the lab has stopped producing new arguments | 3 consecutive vigil ticks with no `new-argument` verdict |
| **Superseded** | the owner says so | an `OWNER-GATE.md` directive, any time |

Under full autonomy the felt gate is **non-blocking**, so *exhausted* is the normal ending.

**Measuring exhaustion.** Every `lab/NOTES.md` entry carries a verdict line:

```
**Verdict:** new-argument | confirms-known | dry
*Grader:* <one sentence naming the prior entry or candidate it does or does not duplicate>
```

**The tick that ran the investigation does not write its own verdict.** An independent grader —
a separate process on a different model (`claude-fable-5`), with no view of the investigator's
reasoning — appends it after the tick ends, and is instructed to default to `confirms-known` when
torn. This is the load-bearing safeguard for exhaustion: an agent asked whether its own work
mattered says yes, so a self-graded loop would score every tick `new-argument`, never exhaust an
era, and never transform the game. The grader lives in `.claude/tsk-loop-runner.sh`.

`new-argument` = opens or strengthens a candidate era. `confirms-known` = re-measures something
settled. `dry` = nothing worth recording. Three ticks without a `new-argument` means the cheap
evidence is gone and the frame itself is now the limit. A rising ratio of *argues-against* to
*argues-for* is the same signal, earlier.

## Exhaustion escalates — it never halts

An era that runs out of road hands the problem **one layer up the ladder** (`LADDER.md`): era →
form → thesis. Two consecutive syntheses with no surviving candidate is the escalation signal, and
escalation is *earned* — the rejections must be on record in `SYNTHESIS.md`, never chosen because a
layer looked slow. Criticism scales with altitude: 3 critics at L2, 5 at L3, 7 at L4. "The charter
is the limit" is no longer a stopping point; it is the entry condition for L4.

## Adversarial era review — what replaces the owner's signature

Before a transition executes, spawn independent critics on the chosen candidate — **3 at L2, 5 at
L3, 7 at L4** (`LADDER.md`) — each briefed to attack it and to **default to rejecting**:

1. *Does this era make success easier to achieve than the last one?* (the drift lens)
2. *Does it abandon or route around a `CHARTER.md` constraint?* (the thesis lens)
3. *Is this ambition, or is it lateral motion dressed as ambition — would a stranger see the game
   get better, or just different?* (the substance lens)

**Majority reject → the transition does not execute.** Record why in `SYNTHESIS.md`, pick the
runner-up or re-synthesize, and try again next tick. A candidate that cannot survive its critics
was never worth an era. **Two consecutive syntheses with nothing surviving escalates a layer** —
increment `failed_syntheses` in `LADDER.md`; the loop never halts for want of a candidate.

## The transition manifest — one commit, all of it

A transition rewrites the loop's own definition of success. It happens **atomically** so a bad era
is one `git revert` away, and it happens **completely** so it can never half-apply.

Write `TRANSITION-PLAN.md` first (every file, every section, exact before/after), then execute all
of the following in **one commit**, tagged `era-N-closed`:

- [ ] `MILESTONES.md` — close the old era (what shipped, what it cost, how it ended); open the new
- [ ] `HISTORY.md` — append the closed era's entry **with a fresh screenshot committed**
- [ ] `done.sh` — add the new era's machine gates
- [ ] `GATES-LEDGER.md` — append every new gate; **remove nothing**
- [ ] `OWNER-GATE.md` — add the new era's felt questions (never delete the old ones)
- [ ] `ROADMAP.md` — the new era's engineering queue
- [ ] `LOOP.md` — replaced `Next` pointer
- [ ] `lab/NOTES.md` — mark the findings that fed the pick as spent
- [ ] `SYNTHESIS.md` and `TRANSITION-PLAN.md` — deleted
- [ ] `CHARTER.md` — **untouched at L2 and L3.** Verify the lock still passes before committing.
      Only an **L4** transition may rewrite it, and only by appending to `CHARTER-LINEAGE.md`
      first, re-keying `CHARTER.lock`, and tagging the commit `thesis-N-opened` (`LADDER.md`).

Then re-run `./done.sh`; the new era should return Gear 1 with real work.

## Candidate directions parked for future synthesis

Ideas that arrive mid-era with no gate to close land here instead of in the game. They are not
promises — they are raw material for the next synthesis.

- Đông Hồ art pass proper — woodblock outlines, điệp-shell ground, đỏ son/vàng nghệ pushed further
- More authored arcs — a second special pair, per-character bloom vignettes
- The law lock as a live beat — "hỏi thăm trên xã" reveals next season's sky
- Endings pass — authored diptychs per outcome-shape, a "fates seen" replay hook
- Audio pass beyond the current pentatonic motif; haptics

### From the owner's mechanic loop (2026-08-15, v0.30–v0.68) — measured, parked with numbers

Every item below was measured with `check.js` (1200 seeded runs unless noted) or a scripted
headless play-through, and deliberately *not* shipped by a tick because it is balance or form —
the fair-opponent era's work, or the owner's. Numbers are as of v0.68 (ceiling · witness ≤5).

- **The year cards do not move a diagnosing player.** Per card (600 runs): hunter 6.96–6.99
  blooms / 15.5–16.6 tiers across all six; spreader 4.91 (flood) → 5.64 (quiet-hands); idle 2.39 →
  2.59. Cards change the story and the price of spreading, not the diagnosis. Candidate: give one
  or two cards a *diagnostic* identity (e.g. the strict year's stamps 25 %/10 % so probe → shelter
  is a real loop; the flood year's tier cap held until the river is *earned*).
- **The river reaches 10 in ~100 % of hunter runs** (lab `fourth.js`; still true post-v0.31) — capital
  stops being a factor mid-game. Candidate: a river that can fall (the pot already dips it once);
  the flywheel needing tiers ≥6 in every year, not just the flood year.
- **The back half is the tier climb now** (v0.57): a tending player climbs 13 → 21 by s14 with all
  43 hands used; the sim's non-tending hunter sits at 12.3. Nothing threatens the climb but the sky
  (5 % established / season; the whole stamp mechanic moves the hunter ~1 % of tiers). Candidate:
  the last year needs a pressure the neighbour cannot buy off (a second clock, a harder sky) — or
  the run is shorter (the engine's G, rejected at L3 for form reasons, not for being wrong).
- **The pot costs the hunter −1.45 tiers and serves non-diagnosers most** (lab `hui.js`); early hụi
  pay-in costs −0.82; spare-hand pay-in ±0. The river verbs are a *spare-hands* channel and a
  crutch. Candidate: fold the pot into a rarer, stronger event (a real hụi rotation once a year)
  or let it stand as a priced trap — its price is printed since v0.45.
- **Pair-spam** (same two lowest-BẠN people every hand): 5.84 / 10.4 — above spreader and random
  linker, under the hunter. Semi-diagnostic by construction; not an exploit. Left open.
- **Storm damage is small**: ~6 storm seasons a run, hunter loses 0.35 roofs + 0.9 step-downs;
  shelter for every roof (v0.48) and the sheet's ⬛ odds (v0.41/v0.64) make it a legible decision
  at the margin, not a threat.
- **The hidden row costs a fair player one hand per misread** (misreader 6.90 vs hunter 6.89) —
  information is play, not punishment. If a future era wants information to *cost*, the lever is
  the ceiling table (2 → 4 %, 3 → 8 %, 4 → 15 %, 5 → 25 %), not the reveal rule.
- **Two of the candidates above, priced (800–1200 runs, v0.68 rules):** *strict-year stamps 25 %/10 %*
  → hunter 6.90 / 12.3 → **6.77 / 12.1**, idle 2.42 → 2.11 — a modest, distinguishable bite (the sim
  never shelters, so a real player who does loses less; that is the point of the loop). *Flywheel at
  ≥6 tiers in every year* → **no change at all** (12.3 → 12.4): the flywheel threshold is not a lever;
  the year-end +1s carry the river to 10 regardless, so a river that can *fall* is the only capital
  lever left.
- **A river that can fall — priced, and it does not bite** (1200 runs): *no roof standing at year-end
  → river −1* moves idle 2.47 → 2.43 and nothing else; *year-end rise needs a roof* moves nothing.
  Structural reason: since v0.38 `chance = min(ceiling, product × river)`, and for everyone whose
  weakest factor is ≤5 the ceiling binds, so the river multiplier is *irrelevant to exactly the
  people a low river would hurt*. Capital now matters only above the ceiling (weakest ≥6) and as
  the tier cap. That is thesis-consistent (no amount of capital compensates a zero) — but it means
  the "fourth factor" is, in play, a tier cap plus a late multiplier, and any era that wants capital
  to *decide* must let it act on the ceiling (e.g. a river ≤2 lowering every ceiling one step),
  which is a charter §3 conversation, not a tick.
- **The year cards, closed (v0.72):** three now carry a diagnostic identity — *strict* (stamps 25/10,
  v0.70), *flood* (the river never rises on its own, v0.71), *wind* (hands +3, fade 50 %, v0.72). Two
  had one already: *quiet-hands* is the year breadth pays (spreader 5.64, its best), *reunion* is
  the year people are on the clock (fates per card, 600 runs: Chú Ba's craft dies in **44 %** of
  idle reunion runs vs 0–1 % elsewhere; Liên leaves 62 % of spreader runs there). *Market-road* stays
  a story card: it is about capital, and under the ceiling capital cannot move the diagnosis
  (see the river entry) — deliberately left as flavour rather than forced. Also measured: since the
  witness bound, the fates bite spreaders far more (Ngân leaves 14–18 % of spreader runs, was 5 %;
  Liên 62–78 %) and hunters not at all — the people, not the numbers, now price neglect.
- **The witness bound (v0.57)** is the one balance change a tick did ship, because it converts idle
  back-half hands into work: hunter 16.0 → 12.3 tiers in the sim, unchanged blooms, every band
  clause held. If the fair-opponent era finds it too steep, the knob is the cap (5), not the rule.

