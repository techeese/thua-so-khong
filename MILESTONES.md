# Milestones — the eras of Thừa Số Không

The loop is **convergent within an era and infinite across eras.** Each era has a name and a
*closed* definition of done. When an era closes, the loop does not stop forever and it does not
drift sideways — it runs a **synthesis** (see `SYNTHESIS.md` when one exists), the owner picks the
next direction, and a new era opens with new gates.

That is the whole design:

```
   era opens ──▶ convergent iterations ──▶ done.sh says CONVERGED
        ▲                                          │
        │                                          ▼
   owner picks ◀── SYNTHESIS: what is this game now, and what should it become?
```

Drift is what happens when a compass rotates because the loop is bored. This is different: new
work is opened **deliberately**, at a moment of reflection, by a human choice. Infinite
development, finite iterations.

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

## Adversarial era review — what replaces the owner's signature

Before a transition executes, spawn **3 independent critics** on the chosen candidate, each
briefed to attack it and to **default to rejecting**:

1. *Does this era make success easier to achieve than the last one?* (the drift lens)
2. *Does it abandon or route around a `CHARTER.md` constraint?* (the thesis lens)
3. *Is this ambition, or is it lateral motion dressed as ambition — would a stranger see the game
   get better, or just different?* (the substance lens)

**Majority reject → the transition does not execute.** Record why in `SYNTHESIS.md`, pick the
runner-up or re-synthesize, and try again next tick. A candidate that cannot survive three
critics was never worth an era.

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
- [ ] `CHARTER.md` — **never touched.** Verify the lock still passes before committing.

Then re-run `./done.sh`; the new era should return Gear 1 with real work.

## Candidate directions parked for future synthesis

Ideas that arrive mid-era with no gate to close land here instead of in the game. They are not
promises — they are raw material for the next synthesis.

- Đông Hồ art pass proper — woodblock outlines, điệp-shell ground, đỏ son/vàng nghệ pushed further
- More authored arcs — a second special pair, per-character bloom vignettes
- The law lock as a live beat — "hỏi thăm trên xã" reveals next season's sky
- Endings pass — authored diptychs per outcome-shape, a "fates seen" replay hook
- Audio pass beyond the current pentatonic motif; haptics
