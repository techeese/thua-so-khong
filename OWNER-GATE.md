# Owner gates — the only boxes the loop may not tick

The loop can build, test, and ship on its own. It **cannot** judge whether the game is good.
These boxes are yours. `done.sh` reads them; the loop halts when these are all that's left.

Tick a box by changing `[ ]` to `[x]`. Untick one any time — that re-opens work and the loop
resumes on its next run.

## The felt gate — a 5-minute playtest of the live build

- [ ] **Diagnosis feels like play.** Finding which factor is zero is the fun part, not homework.
- [ ] **You care about someone by season 8.** A name, a face, a fate you'd be sorry to lose.
- [ ] **The thesis lands from play alone.** "Mười nhân với không vẫn bằng không" arrives without
      the game ever telling you — you felt it in the arithmetic of a life.

## Device reality

- [ ] **Installed-PWA check on a real phone** — home-screen icon renders, splash is right,
      offline launch works.
- [ ] **Share-preview check** — paste the URL into a chat app and the og card looks correct.
- [ ] **390px hands** — a real small phone, real thumbs, canvas tap targets all reachable.

## Notes back to the loop

Anything you write under here is read at Step 0 of every iteration and outranks everything else.

<!-- OWNER NOTES BELOW -->

## 2026-08-15 — fix `chatter()`, then stop

> RESOLVED v0.28 — the roll now waits on `beatUntil` instead of a fixed +1100ms; same probe, same
> harness, 8 paced runs each side: 120/120 calls preempted and 0 bubbles before, 0/120 preempted
> and 36 bubbles (4.5 per run) after, with all four seasonal lines and three storm voices heard.
> Timing only — no line written or retuned. `gate.sh` Gate 6 now holds it. Rate note in the tick
> report: the layer reads sparse, not chatty.

The vigil found that `nextSeason()` rolls ambient chatter at +1100ms while `banner()` holds its
beat for 2200ms, so the roll is always preempted — 15 of 15 calls, 0 bubbles ever produced. 22
authored bilingual strings (every villager's `chatS` storm voice, all four `CHAT_SEASONAL` lines)
have never been seen by any player. Evidence: `lab/NOTES.md`, 2026-08-15.

**Authorized: fix the timing so the ambient layer actually plays, and ship it.** This is the only
shipping work opened by this note — do the fix, verify it, ship one version, and return to vigil.

Constraints, because this layer has never run and I have not seen it:
- Fix the **timing**, not the content. Do not write new lines. Two thirds of what is authored has
  never played; I want to see what already exists before anyone adds to it.
- Ambient stays **silent and numberless** — no effects, no numbers, yields to beats.
- Prove it with a probe that counts bubbles actually produced per run, not absence of errors,
  and put that count in the CHANGELOG.
- If the fix makes the xóm feel chatty rather than alive, say so in the tick report and propose
  a rate, don't quietly tune it to taste.

After this ships, the felt gate below is mine to answer on the new build.
