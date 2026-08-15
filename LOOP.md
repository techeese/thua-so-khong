# LOOP.md — the improve-and-ship loop's constitution (v3)

> Rewritten 2026-08-14 after an audit: the loop had been dead 43 days, two versions were pushed but
> never deployed, and an iteration was stranded uncommitted. v3 makes the loop **convergent within
> an era and infinite across eras**, and moves its continuity onto disk.
> Playbook: `.claude/skills/improve-thua-so-khong/SKILL.md`. Scope: this repo ONLY.

## The shape

```
   era opens ──▶ convergent iterations ──▶ done.sh: CONVERGED
        ▲                                        │
        │                                        ▼
   owner picks ◀────── SYNTHESIS.md ◀──── the era closes
```

Each era has a **closed** definition of done (`done.sh` + `OWNER-GATE.md`). New work is opened by a
**synthesis** and an owner's choice, never by a compass rotating because the loop had nothing to do.
Eras are recorded in `MILESTONES.md`. Current era: **1 — "The fable is playable"**.

## The loop runs forever — in one of three gears

Owner's standing rule: **the improvement loop never stops.** But always-running is not
always-shipping. `done.sh` picks the gear:

| verdict | gear | the work | touches `index.html`? |
|---|---|---|---|
| exit 0 | **1 · CONVERGE** | grind the red gates green, ship, fast cadence | **yes** |
| exit 20, no `SYNTHESIS.md` | **2 · SYNTHESIZE** | propose 3–4 candidate next eras | no |
| exit 10 or 20 | **3 · VIGIL** | watchdog + `lab/` prototypes, slow cadence | **never** |

Gear 3 is how the loop runs forever without drifting. The **watchdog** re-runs the gates and
re-checks the live URL every tick — rot is real, and any red gate immediately re-opens Gear 1
(this is what would have caught the six-week outage). The **lab** does unbounded evidence-gathering
and prototyping in `lab/`, which is gitignored and **never ships** — it is raw material for the
owner's next pick. A quiet vigil tick that finds nothing is a **successful** tick.

A lab prototype that looks worth shipping still does not get shipped. It becomes a candidate and
waits. That boundary is the whole difference between infinite development and drift.

## Invariants (never ship without)
1. `./gate.sh` green — band · syntax · fresh run · poisoned save · 16-season VI+EN.
   Band = **diagnosis > spreading > idling**.
2. `check.js` mirrors any `index.html` math change, same numbers.
3. Bilingual VI/EN for every player-facing string.
4. Thesis-safe: no great-man affordance · no lecturing (one line per beat) · the multiplication
   stays the core · ambient life is silent and numberless.
5. Version bump + CHANGELOG + push + **live-URL verified**. A push is not a ship.
   One commit per iteration = one revert unit.

## The ship budget — every item must close something
An item may enter a round only if it (a) turns a red `done.sh` gate green, (b) answers a quoted
owner directive or `OWNER-GATE.md` note, (c) fixes a real defect with evidence, or (d) is named in
`Next` below as convergent work for this era.

**"It's ART's turn on the compass" is not sufficient cause** — that clause is what turned cycles
9–15 into lateral drift. Unjustified ideas go to `MILESTONES.md` → *Candidate directions*, as raw
material for the next synthesis.

**Subtraction is a first-class item.** Every standing owner directive here is reductive — *less
narration · simple opening · ambient = silent + numberless*. v0.17 was a de-lecture pass and it was
one of the best rounds shipped.

**A round may ship nothing.** Review is unbounded; changing is not. Two dry rounds with all machine
gates green means converged — run `done.sh` and halt properly.

## The gradient
Owner words > red machine gates > reviewed defects > named era work. Everything else waits for a
synthesis.

## Autonomy
Ship-then-veto for everything except the narrow halts below. The loop never blocks on the owner
for permission to build.

## Halt-and-ask
- gates fail twice on the same change
- identity-level changes: camera, thesis, cast removal, the language pair
- anything outward-facing beyond this repo and its Pages site
- `done.sh` exits 10 (CONVERGED) or 20 (ERA COMPLETE)
- **choosing the next era** — never ship-then-veto, always the owner's call

## Next (one paragraph — REPLACE it each round, never append)
Era 1 machine gates are green as of v0.27; what remains is the owner's felt gate in
`OWNER-GATE.md` (three playtest questions + real-device PWA/share/390px checks), so the loop is in
Gear 3 vigil and does not ship. Two vigil ticks have banked evidence in `lab/NOTES.md`: 390px tap
reachability (eclipse 0, but place-taps stolen ~21% of the time at the market), and the attachment
curve — personal voice per present villager falls 1.16 → 0.49 → 0.04 across seasons 2 / 8 / 14,
because `chatter()` is unreachable (`nextSeason` rolls it at +1100ms inside the banner's own
2200ms beat), leaving 22 authored bilingual strings dead. **The chatter defect is the one thing
awaiting an owner verdict** — it qualifies under ship-budget (c) but Gear 3 may not fix it.
Standing owner directives if any round does open: less narration · simple opening · buildings mean
something · ambient = silent and numberless.
