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
| `LADDER.md` | the four layers, escalation conditions, criticism scaling | loop (state line) |
| `CHARTER-LINEAGE.md` | every thesis ever held | **loop, append-only, L4 only** |
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
`OWNER-GATE.md` directive, (c) fixes a **grader-classified defect** from `lab/NOTES.md`, (d) is
named era work in `MILESTONES.md`, or (e) is a grader-raised proposal that survived review.

Clause (e) — a **grader-raised proposal that has survived adversarial review** — lets the loop
*add*, not just fix. The grader may mark `**Proposal:** yes — …` on a finding; that is an option,
not an obligation. The next vigil tick spends itself reviewing it: three critics briefed to reject,
plus the lens that matters most here — *would removing something serve this goal better than
adding?* Majority pass → `> APPROVED` under the entry, which trips the licence gate and makes it
Gear 1 work; ship it and close with `> SHIPPED v0.N`. Majority reject → `> REJECTED <why>` and it
becomes a candidate for the next synthesis instead.

That review is the whole safeguard. Additions with no gate are exactly how cycles 9–15 padded a
fable about restraint, and the addition-specific lens exists because every standing directive on
this project is reductive.

Clause (c) is the loop's own licence to ship. A lab entry carries a `**Defect:** yes — …` line only
if the *grader* put it there; that trips the `no-open-defects` gate, which forces Gear 1 and makes
the fix obligatory. Close it with `> FIXED v0.N` under the entry once shipped and live-verified.
Without this the loop could prove something was broken and still not be allowed to touch it — which
is exactly what happened with `chatter()`: found in the lab, fixable only after the owner
intervened.

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

1. **Change `CHARTER.md` below L4.** Hash-locked at L1–L3. A synthesis concluding the charter is
   the limit does not stop — it escalates to L4 (`LADDER.md`), where the thesis may be rewritten,
   but only by appending to `CHARTER-LINEAGE.md` first and surviving seven critics.
2. **Remove or weaken a gate.** `GATES-LEDGER.md` is append-only and verified every tick.
3. **Open an era that survived no criticism.** Adversarial review must pass first
   (`MILESTONES.md` → transition manifest).

Everything else is ship-then-veto. Owner directives, whenever they appear, outrank all of it.

## The gradient

Owner words > red machine gates > reviewed defects > named era work > synthesis candidates.

## Next (one paragraph — REPLACE it each round, never append)

**v0.38: the weakest factor sets the ceiling — 2 → 4 %/season · 3 → 8 % · 4 → 15 % · 5 → 25 %
(Gate 16; Gate 0 gains capping clauses and a *maxer* strategy: hunter unchanged 6.97/16.1, spreader
5.34, idle 2.47, maxer 3.40/5.0). This is the critics' §9.1 pass condition, shipped under owner
authority; the engine's synthesis 2 should read it as done and price its era against it. ⚠ v0.37 sped
walk cadence 6–12 s → 4.5–9 s; the critics hold cadence frozen unless the owner says so — OWNER may
veto. v0.37: the road precedes the label — strangers walk their factor before you have spoken to them,
cadence 4.5–9 s (Gate 15); the engine rejected Era A 3/3 and is reviewing B "watching is reading"
re-scoped, so mechanic ticks now serve B's channel without deciding B's identity (labels stay until
the transition says otherwise). v0.36: the TÀI zero walks — errand 11 LEARN sends a low-TÀI neighbour to watch the most skilled
hands (Gate 14); all three zeros now have a walk, and the fates measure as reachable and fair
(Ngân leaves 0 % hunter · 5 % spreader · 100 % idle). The engine's `SYNTHESIS.md` has closed Era 1
and provisionally picked Era A (one zero, one word — reductive); mechanic ticks now choose work
that A's manifest does not touch and B would need. v0.35: every zero has a face — Bé Ngân leaves for medical school at season 11 if NERVE stays under
3 (Gate 13), the ending shows every row, and `check.js` bands the misreader (6.97/15.9: the hidden
row costs a fair player one hand per misread). v0.34: a hand in the wrong place is answered in the person's own voice, once, no number (Gate 12);
Anh Vũ's opening line now carries his BẠN clue. v0.33 hides every factor until a hand touches it (Gate 11) — diagnosis is now a guess from the
quote, priced by the hand; measured first: even at 2 hands the perfect-info hunter blooms 6.94/7,
and hụi/pot as strategies are not spam channels (6.98/15.1 · 6.76/13.9 vs 6.98/16.1). Before it:
v0.30 literal zero (Gate 7) · v0.31 river as fourth factor (Gate 8) · v0.32 shipped two rounds in
one commit — the print fits a phone (Gate 9: header wraps, bubbles never overlap and yield rather
than wall, banner scales with `LKF`, a carved far bank replaces the sky/ground seam) and hốt hụi,
the pot pays out (Gate 10); "price for being wrong" re-measured and found paid by the zero (inverted
3.99/5.0 vs hunter 6.98/16.1).** The owner runs TWO interactive sessions in this tree — `/loop 5m`,
now a **graphics** loop (*"review it and make some upgrade/change/adjustment in the graphic,
regardless how large or how small"*), and `/loop 3m` "mechanic/gameplay upgrades" — and has said
**all loops keep running**; each commit brackets `gate.sh` with a hash check and names what it
carried from the other. Label de-overlap shipped in v0.34 (Gate 13); the roster's
scroll cue shipped in v0.36 (Gate 16). Next for the graphics loop, in order: **the crowding item is
parked, not done** — 61% of ordinary frames draw two villagers on top of each other and only ~4.2 of
~6.1 get named, but a target-rejection fix moved nothing (110 → 113 overlap frames) and, decisively,
three runs of near-identical code gave avgNamed 4.15 / 4.58 / 3.77, so **any crowding work must first
get a seeded or multi-run harness** (copy `check.js`'s method) or its numbers are meaningless; the far
bank fading to nothing under a heavy sky is **decided, not pending** — a closed sky is meant to close
the far shore; then the intro screen, which this loop has never reviewed. Remaining mechanic bank: the ending card calling a ≤3-factor person
"bloomed" beside its own `×` arithmetic; `schoolfirst` and a fair `spreaderU`; the misreader is banded (done); and whether the *first*
talk should reveal one factor for free on run 1 (the book remembers on run 2+) if real players stall.
Era-1 exhaustion count stands at 2 of 3 `confirms-known` verdicts; the autonomous engine loop
keeps vigil concurrently and must never commit or revert either owner session's uncommitted edits.
Standing owner directives: less narration · simple opening · buildings mean something · ambient =
silent and numberless.
