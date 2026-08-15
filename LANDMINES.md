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
