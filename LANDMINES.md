# LANDMINES — traps that already blew up once

Append-only. The loop writes here the moment something surprises it, and reads the whole file at
Step 0 of every tick. This is the only document that makes a future tick *faster* rather than just
better informed, and the only one that cannot be reconstructed if lost.

Rules: never delete an entry · never soften one · say what it cost, not just what it was · a trap
that is now impossible because a gate catches it stays here, with the gate named.

---

## Loop machinery

- **The session must start in `Desktop/coding`, never in `thua-so-khong/`.** Skills and settings
  are discovered from the session's project root. Starting inside the game repo gives
  "Unknown skill: improve-thua-so-khong" — and silently loads no Stop hook, so the loop runs one
  tick and dies without saying so. The visible half of that failure is the harmless half.
- **`claude -p` prints nothing until the very end.** A tick that runs `gate.sh` (~20s) and reads
  files shows a stone-silent terminal the whole time — indistinguishable from a hang. 2026-08-15:
  the owner killed a healthy first run (68 transcript entries, mid-`gate.sh`) believing it was
  stuck. The runner goes interactive when stdout is a TTY and only uses
  `-p --output-format stream-json --verbose` when launchd runs it headless.
- **A blocking Stop hook means the process never exits.** Correct for Gear 1 (fast back-to-back
  iterations), wrong for Gear 3, where it would spin vigil ticks with no pause. The hook reads
  `.claude/tsk-gear` and declines to block on gear 3, so the session ends and launchd's
  `ThrottleInterval` becomes the vigil cadence. Keep that file current (Step 0).
- **launchd hands jobs a minimal PATH** that excludes `~/.local/bin`, so a bare `claude` exits 127
  "not found" even though it works in a terminal. The runner resolves the binary absolutely.
- **`~/Desktop` is TCC-protected.** A launchd agent is denied access (exit 126,
  "Operation not permitted") until Full Disk Access is granted to the executing program. A terminal
  inherits its own grant, which is why running the script by hand worked the whole time.
- **The loop's continuity must live on disk.** v1 re-armed itself with `ScheduleWakeup`, which is
  session-scoped — when the session ended on 2026-07-02 the loop ended permanently and left no
  trace saying so. The `.improve-tsk-on` marker + Stop hook is what survives a session death.
- **An agent grading its own work always says it mattered.** Era exhaustion is measured from the
  `**Verdict:**` line on each lab entry, and the first three verdicts — written by the same session
  that ran the investigations — were all `new-argument`. A self-graded loop never exhausts an era,
  never synthesizes, and never transforms the game: the failure is silent, and looks like a busy,
  healthy loop. The verdict is now written by an independent grader (separate process, different
  model, no view of the investigator's reasoning, instructed to default to `confirms-known`).
  Generalises: **never let the component that did the work score the work.**
- **Never edit a script a live process is executing — stage and rename.** Bash reads a script
  *incrementally* as it runs, so rewriting the same inode makes the running shell resume from a
  shifted byte offset and execute garbage. Write the new version to a temp file and `mv` it over:
  the rename gives new content a fresh inode while the live process finishes safely on the old one.
  Nearly corrupted a running tick this way on 2026-08-15.
- **Restart the loop immediately after any config change — do not wait for the running tick.**
  Owner's standing practice (2026-08-15). Waiting buys nothing: the `tree-clean` gate makes an
  interrupted tick recoverable by design (the next tick's Gear 1 job is to finish the stranded
  work), while waiting guarantees a full cycle runs on stale config. Kill order matters —
  `rm` the flag FIRST so launchd stops relaunching, then stop the job.
- **A vigil tick that obeys the grader rule ends with `done.sh` RED — and that is correct; do not
  "fix" it.** `loop-selfcheck.sh` #5 requires every lab entry to carry a verdict, while `389db48`
  forbids the tick from writing or summoning one — so between the tick's commit and the runner's
  grader, `done.sh` reports "loop structure broken … missing a Verdict" and prints GEAR 1. First
  seen 2026-08-15 (`decide.js` tick); the two earlier vigil ticks never showed it because they
  graded themselves in-tick. The design self-heals: leave the gear file at **3** so the session
  ends and the runner grades; the grader appends but does not commit, so the *next* tick opens on a
  dirty tree in Gear 1 whose whole job is to commit the grader's two lines and re-run `done.sh`.
  Traps: writing `1` to the gear file here blocks the Stop hook, the session never exits, and the
  grader never runs — a deadlock. If the next tick finds the tree clean and the entry still
  ungraded, the grader failed: halt and report, do not grade it yourself. Cost so far: one
  investigation of the runner mid-tick. Owner's call, in a meta-session, whether the runner's
  grader should commit, or `loop-selfcheck` #5 should tolerate exactly one ungraded newest entry.
- **`lab/NOTES.md` is NEWEST-FIRST, so the newest N verdicts are `v[:N]`, not `v[-N:]`.** The
  exhaustion check read `v[-3:]` — the three OLDEST entries, frozen at `new-argument` forever — so
  `EXHAUSTED` could never become 1 and the synthesis/transition chain could never fire. The loop
  would have ticked, measured, committed and graded indefinitely while looking perfectly healthy.
  Generalises: **when a file has a prepend convention, every window over it is a slice off the
  front**; and a termination condition that has never actually fired is untested, not working.
- **A loop that can only fix is maintaining, not improving; a loop that can add freely is drifting.**
  The difference is not the size of the change but whether it survived criticism. Defects are
  self-evident, so the grader alone licenses them. Additions are judgment calls, so they face the
  same adversarial review an era does, at tick scale — including the lens *would removing something
  serve this better than adding?*, because every standing directive on this project is reductive.
- **An owner directive must be machine-detectable or it will be silently ignored.** `done.sh`
  originally had no way to see a note in `OWNER-GATE.md`; the loop would read the directive, find
  every gate green, return CONVERGED and go back to vigil without doing the work. Open directives
  now force Gear 1.

## Ship and deploy

- **A push is not a ship.** GitHub's Pages backend stalled on 2026-07-02 (`deployment_queued` →
  `Timeout reached, aborting!`). v0.25 and v0.26 were pushed, green, and invisible to players for
  six weeks because nothing verified the live URL. Always curl the live version string.
  Re-dispatching the same workflow six weeks later succeeded in 18s — a stalled Pages deploy is
  usually a GitHub incident, not a bug in `pages.yml`; retry before rewriting the workflow.
- **A stranded working tree is how this loop died the first time.** Uncommitted work from an
  interrupted tick IS the next tick's work. Never stack new work on top of it.

## Probes, gates and shell

- **`grep -o 'en:'` also matches `green:`, `when:`, `hen:`.** A bilingual-parity check must anchor
  on a delimiter (`[{, ]en:`) or it reports a phantom 10-string gap.
- **A bare word in a grep alternation matches inside longer words.** `thesis` matches inside
  `synthesis`; `en:` matches inside `green:`. The loop-structure check reported the engine
  "contaminated" by its own vocabulary until it used `-w`. Any keyword scan over prose needs word
  boundaries or a delimiter anchor — this class of bug has now cost time twice.
- **`grep -c` prints `0` and exits 1** when nothing matches — a `|| echo 0` fallback double-prints
  and breaks arithmetic downstream.
- **Headless Chrome enforces a ~500px minimum window width**; `--window-size=390,x` silently lays
  out at 500. Inject `body{width:390px;margin:0 auto}` into a probe copy for a true 390 check.
- **`gate.sh` Gate 5's finale assertion waits 9s of virtual time** for the lantern beats and
  `endGame()` timers — any new end-sequence timing must fit inside that window or the gate goes
  red for a reason that isn't a bug.
- **Absence of a JS error is not a pass.** Every shipped item needs a probe asserting a
  NON-DEFAULT outcome — a value that could only be true if the item works.
- **The `gate.sh` full-run driver advances all 16 seasons synchronously**, so it cannot observe
  anything that depends on real dwell time (ambient life, errand walks, chatter). Timing-dependent
  behaviour needs a paced probe with real seconds per season.
- **A villager can bloom TWICE in one run** — a crush clears `started`, and the same person blooms
  again later. Any per-run rate computed by counting bloom *events* over run count over-counts:
  `lab/zerohunt.js` first reported Anh Vũ blooming in **103.8% of runs**. The >100% is the lucky
  case; the same bug silently inflates every rate below 100%. Count distinct runs (a `first` flag on
  the event), not events.
- **`check.js`'s sim has no apprenticeship, so it over-decays Chú Ba.** `index.html:1384` stops the
  elder's clock when pair 0-1 exists; the sim's clock (`check.js:101`) runs unconditionally, with a
  comment saying so. Any lab measurement of his TÀI — decay, zeros, late blooms — reads high for
  pair-forming strategies unless the probe re-adds the stop. Cost: a second full sweep on
  2026-08-15 (`lab/zerowitness.js` now runs both variants; the difference is 1.7 → 0.3 elder-zeros
  per 1000 linker runs). Generalises: **the sim mirrors the season math, not the story systems** —
  check the mirror before attributing a number to a person.
- **A sim strategy that "raises" a factor already at 10 silently wastes the act; the game's button
  is disabled, so a player can't.** `lab/zerohunt.js`'s `avoider` (4.75/6.13) and `maxer`
  (4.93/7.14) raise `maxKey` with no cap check, and once that factor is 10 every later act on that
  person is a no-op — the "anti-diagnosis costs 60% of tiers" row was measuring wasted acts.
  Cap-faithful they score 6.93/14.53 and 6.60/15.67 (~8% cost). Worse, `check.js`'s **own spreader**
  aims 45% of its acts at already-bloomed people (the sim discards them) and 5.5% at capped factors,
  so the band's `hunter.ts > spreader.ts + 3` margin is 93% waste and 7% diagnosis
  (`lab/decide.js`, 2026-08-15). Cost: one banked table row overstated by ~7×, and a gate margin
  that reads as a thesis claim. Generalises: **when a sim strategy loses, check whether it lost the
  decision or lost the interface** — give every strategy the game's own guardrails before comparing.
- **`check.js`'s band gate proves diagnosis WINS, not that the weakest factor DECIDES.** They are
  different claims and only the first is gated. Measured 2026-08-15: `idle` — a player who never
  acts — still blooms 3.44 of 7 workshops, and a strategy the gate does not test (`schoolfirst`)
  scores inside the gate's own margins. Do not cite a green `band` gate as evidence about the
  thesis; cite it as evidence about strategy ordering.
- **In `check.js`'s frame, anything that makes a bloom fire SOONER reads as a tier LOSS.** The sim has
  no post-bloom tending, so a bloom freezes that person's product for the rest of the run; a fuller
  river (`lab/fourth.js`, 2026-08-15) fires the hunter's blooms a season earlier at product 438
  instead of 478 and *lowers* tiers 16.13 → 15.55 while blooms stay at 6.99. In the game the
  teach/nerve buttons stay live after a bloom, so the loss is recoverable there. Any lab measurement of
  "does X help?" on tier depth — capital, school reach, momentum, inspiration — must be read on the
  bloom channel or with post-bloom tending added to the mirror; the tier sign can invert. Cost: none
  this tick (caught by attribution), but the raw table read "the river hurts the diagnosing player."

## Game internals

- **NaN serializes to JSON `null` and bare `isFinite(null)` is `true`.** Sanitize saves with
  `typeof x === 'number' && isFinite(x)`. Every new state field needs a default AND a sanitize
  entry.
- **`chatter()` was unreachable for the entire life of the game.** `nextSeason()` rolled it at
  +1100ms while `banner()` held its beat for 2200ms, so all 15 calls per run were preempted and 22
  authored bilingual strings had never been seen by any player. Fixed v0.28 (waits on `beatUntil`);
  Gate 6 holds it. The general lesson: **a guard that never opens looks identical to content that
  was never written** — when a layer seems thin, instrument the call site before authoring more.
- **`_chaser` was assigned before `visit()`**, which cleared it — the chase animation dropped
  whenever a story visit landed in the same frame. Order matters around `visit()`.
- **A sanitize clamp with a hard-coded max silently undoes a rule that varies by year card.**
  `cl(s.hui,0,3,0)` (`index.html:473`) clamps the hụi counter to 3, but `huiMax()` is 4 in a flood
  year — after four contributions a reload re-enables the button for a fifth (+1 river, one more act).
  Found by reading, not by a gate (`lab/fourth.js`, 2026-08-15); not shipped, per Gear 3. Generalises
  the NaN entry above: a sanitize bound must reference the rule's function, not a literal copy of it.
