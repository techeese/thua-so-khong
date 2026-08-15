# LOOP.md — the binding contract

The engine (`.claude/skills/improve-thua-so-khong`) knows only mechanism. **This file tells it what
this project's mechanism operates on.** Read it first, every tick.

> v4 · 2026-08-15 — owner set the loop to **fully autonomous, end to end**: it closes eras, picks
> the next one, and executes transitions without waiting for a human. The safeguards that replace
> the owner's signature are the charter lock, the gates ratchet, and adversarial era review.
> Owner's words: *"it will produce a game you didn't choose ⇒ it is ok. I want to see after so
> many iteration, what the game transforms into."*

## Documents — read in this order

| file | what it is | who may write it |
|---|---|---|
| `CHARTER.md` | what the game is for; the four constraints | **owner only** (hash-locked) |
| `OWNER-GATE.md` | owner directives + the felt gate | owner writes; loop may only add `> RESOLVED` |
| `LOOP.md` | this contract | owner (and deliberate meta-sessions) |
| `LANDMINES.md` | traps that already blew up once | **loop, append-only** |
| `GATES-LEDGER.md` | the ratchet — gates may be added, never removed | **loop, append-only** |
| `MILESTONES.md` | eras, synthesis protocol, transition manifest | loop |
| `HISTORY.md` | one entry per era — the observation deck | loop, at transitions only |
| `CHANGELOG.md` · `ROADMAP.md` · `lab/NOTES.md` | the running record | loop |

## Commands — the interface the engine calls

| command | contract |
|---|---|
| `./done.sh` | exit **0** = Gear 1 CONVERGE · **10** = Gear 3 VIGIL · **20** = Gear 2 SYNTHESIZE |
| `./gate.sh` | exit 0 = safe to ship (~20s) |
| gear file | write `1`/`2`/`3` to `/Users/Admin/Desktop/coding/.claude/tsk-gear` each tick |
| ship | bump footer version in `index.html` · CHANGELOG · one commit · push · **curl the live URL** |
| deploy check | `gh run list --workflow=pages.yml --limit 1`, then verify the live version string |
| tick model | `claude-fable-5` at `--effort xhigh`, `--fallback-model claude-opus-5` |
| grader model | `claude-fable-5` at `--effort low` — independent, never sees the investigator's context |

Session runs in `/Users/Admin/Desktop/coding`; all game commands run in `thua-so-khong/`.

## The ship budget — every item must close something

An item may enter a round only if it (a) turns a red `done.sh` gate green, (b) answers an open
`OWNER-GATE.md` directive, (c) fixes a real defect with evidence, or (d) is named era work in
`MILESTONES.md`.

**"It's ART's turn on the compass" is not sufficient cause** — that clause is what turned cycles
9–15 into lateral drift. Unjustified ideas go to `MILESTONES.md` → *Candidate directions*, as raw
material for the next synthesis.

**Subtraction is a first-class item.** Every standing owner directive here is reductive — *less
narration · simple opening · ambient = silent and numberless*. v0.17 was a de-lecture pass and one
of the best rounds shipped.

**A round may ship nothing.** Review is unbounded; changing is not.

## Autonomy — full, with three hard limits

The loop closes eras, picks the next, and executes transitions on its own. It never waits.
It cannot:

1. **Change `CHARTER.md`.** Hash-locked. If a synthesis concludes the charter is the limit, it says
   so in `SYNTHESIS.md` and stops — that conversation is the owner's.
2. **Remove or weaken a gate.** `GATES-LEDGER.md` is append-only and verified every tick.
3. **Open an era that survived no criticism.** Adversarial review must pass first
   (`MILESTONES.md` → transition manifest).

Everything else is ship-then-veto. Owner directives, whenever they appear, outrank all of it.

## The gradient

Owner words > red machine gates > reviewed defects > named era work > synthesis candidates.

## Next (one paragraph — REPLACE it each round, never append)

Era 1's machine gates are green as of v0.28 and nothing is legitimate to ship; the felt gate is
unanswered and, under full autonomy, **non-blocking** — so era 1 ends by *exhaustion*: keep vigil,
bank lab evidence, and when three consecutive ticks produce no `new-argument` verdict, run the
synthesis and execute the transition without waiting — verdicts written by the **independent
grader**, never by the tick that ran the investigation. **Six findings banked; the fifth graded
`confirms-known` (1 of 3 consecutive) and the sixth awaits the grader.** The bank: the ambient layer
reads sparse and shares a 2-slot queue with numeric stat floats; place-taps are stolen ~21% at the
market; the attachment curve runs 1.16 → 0.49 → 0.04 at seasons 2/8/14, arguing against any era
premised on writing more dialogue; the zero is **soft** (`idle` blooms 3.44 of 7; the band is blind
to `schoolfirst`); the zero is **unwitnessed** (0.0% of hunter runs meet a literal 0, the elder's
clock is invisible to every "someone fell" system, and "số không" is printed for any factor ≤3); and
now the zero is **priceless in the wrong sense** — under the game's own arithmetic a wrong factor
costs ~8% of tiers and ~1% of blooms, a wrong person costs nothing or pays (+1.24 tiers for "finish
whoever is nearest"), a player who inverts the thesis on both axes keeps 98% of the outcome, and the
band gate's 4.65-tier "diagnosis beats spreading" margin is 93% the spreader wasting acts on bloomed
people and capped factors (a fair spreader sits at −0.33). The next synthesis should weigh a
**reductive** era on the zero — floors that bite, a surface that distinguishes 0 from 3 as it
happens, and a **price for being wrong** — against the voice, place-legibility and attachment
candidates; note that both `schoolfirst` and a fair `spreaderU` turn the band gate red on the first
commit and carry a balance decision with them. Standing owner directives: less narration · simple
opening · buildings mean something · ambient = silent and numberless.
