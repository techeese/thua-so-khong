# LOOP.md — the improve-and-ship loop's constitution (v2)

> Owner-upgraded 2026-07-02: **review-driven, BIG iterations** — each cycle runs reviews, then makes SIGNIFICANT
> changes (multiple things at once) to converge faster to the amazing game. Ship-then-veto stands.
> Scope: this repo (`thua-so-khong`) ONLY. Runs until the owner says stop.

## Invariants (never ship without) — unchanged
1. `./gate.sh` green (band · syntax · fresh run · poisoned save) — band = **diagnosis > spreading > idling**.
2. `check.js` mirrors any `index.html` math change, same numbers.
3. Bilingual VI/EN for every player-facing string.
4. Thesis-safe: no great-man affordance, no lecturing (one line per beat), the multiplication stays the core.
5. Version bump + CHANGELOG + push + **live-URL verified**. One commit per iteration = one revert unit.

## Per-iteration protocol (v2 — the big cycle)
1. **Orient**: LOOP.md → CHANGELOG top → ROADMAP → owner feedback (ALWAYS preempts everything).
2. **REVIEW**: spawn 2–3 parallel fresh-eyes reviewer agents on the current build (rotating lenses: first-session
   fun/onboarding · game-design depth/pacing/payoff · code robustness/mobile). Each returns ranked, concrete,
   implementable findings. Triage honestly — drop taste-noise and anything thesis-unsafe.
3. **BATCH**: plan a SIGNIFICANT multi-change batch — top review findings + compass direction + (when it earns its
   place) one bold element. Multiple changes at once is the norm now; the batch must still land in one iteration.
4. **BUILD** the batch; **VERIFY** each piece: gate.sh + check.js sync + headless probes + screenshot self-review.
5. **SHIP**: one version, CHANGELOG entry per piece, commit with session trailers, push, poll live.
6. **LOG**: ROADMAP/memory/compass; note review findings deferred to the next batch.
7. **Re-arm** ScheduleWakeup (~25–30 min) — at the END of EVERY turn, including notification turns.

## The gradient
- Owner feedback > review findings > compass (ART · STORY · FEEL · DEPTH · ENDINGS · MOBILE · CONTENT).
- The loop still cannot judge FUN — ≤1 question left for the owner per shipped version, never blocking.

## Autonomy (owner directive 2026-07-02)
- **The loop never waits on the owner.** Reviews are agent-run; triage decisions are the loop's own; every judgment
  call defaults to **ship-then-veto**, not ask-first. Questions to the owner are optional flavor, never gates.
- Halt-and-ask applies ONLY to the narrow guardrails below — everything else: decide, build, ship.

## Halt-and-ask instead of inventing when
- gates fail twice on the same change · identity-level changes (camera, thesis, cast removal, language)
- anything outward-facing beyond this repo/Pages site.

## Compass pointer
- next cycle: **NEW review round** (rotate lenses: replayability/variety · bilingual copy quality · fresh first-session) → triage → batch. *(v0.10 hardening · v0.11 late-game & payoff done)*
