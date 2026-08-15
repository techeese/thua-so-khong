<!-- STATE layer=2 failed_syntheses=1 -->
# THE LADDER — improvement never halts, it escalates

Owner's design (2026-08-15): *"it should not halt… the goal is improve forever. We can have
multiple layers of improvement — a smaller layer can be smaller improvements, a larger layer can
change gameplay, music; a higher level can change philosophy."*

Exhaustion at any layer does not stop the loop. **It hands the problem one layer up.**

```
L1  TICK     one fix, or one measurement                        hours
L2  ERA      a system, a pass, a direction                      weeks
      ↑ no candidate era survives review, twice
L3  FORM     what kind of game — genre, structure, medium       months
      ↑ no form change survives review, twice
L4  THESIS   what the artifact is about                         rare
      ↑ (never exhausts — a new thesis resets every layer below)
```

The old design halted when the charter became the binding constraint. That was a slower kind of
stopping. Now "the charter is the limit" is not a terminus but the **entry condition for L4**.

## What each layer may change

| Layer | May change | May not |
|---|---|---|
| **L1 · Tick** | one defect, one gate, one measurement | anything not in the ship budget |
| **L2 · Era** | systems, content, art, audio, economy, endings, UI | the form or the thesis |
| **L3 · Form** | genre, structure, run length, medium, platform, what "playing" means | the thesis |
| **L4 · Thesis** | the charter itself — what the artifact is *for* | the lineage record; the ratchet |

## Escalation is earned, never chosen

You may **never** escalate because a layer looks boring or slow. The condition is recorded failure:

- **L1 → L2** — three consecutive lab ticks with no `new-argument` verdict (era exhausted).
- **L2 → L3** — two consecutive syntheses in which **no candidate era survived** adversarial
  review. Rejections must be on the record in `SYNTHESIS.md`; a synthesis that simply wasn't
  attempted does not count.
- **L3 → L4** — two consecutive syntheses in which no *form* change survived, i.e. the game
  cannot be meaningfully re-shaped while still serving the current thesis. This is the state
  formerly reported as "the charter is the limit."

`failed_syntheses` in the state line at the top of this file is the counter. It increments when a
synthesis ends with no surviving candidate, and **resets to 0** the moment any transition executes.

## Criticism scales with altitude

The higher the layer, the more it must survive before it executes.

| Layer | Critics | Additional burden of proof |
|---|---|---|
| **L2 · Era** | 3 | evidence from `lab/NOTES.md` in the current era |
| **L3 · Form** | 5 | evidence spanning **≥2 completed eras** — one era's frustration is not a form problem |
| **L4 · Thesis** | 7 | evidence spanning **≥2 completed forms**, plus an explicit argument for *why the current thesis is exhausted* rather than merely hard |

All critics are briefed to attack and to default to rejecting. **Majority reject blocks.** The
drift lens — *does this make success easier?* — is mandatory at every layer and is the ratchet's
enforcement at L3 and L4, where no automated gate can judge the content of a new form or thesis.

## L4 executes without asking — but loudly

Owner's call: the loop does not need permission to change the thesis. It does need to make the
change impossible to miss.

An L4 transition must, in one commit tagged `thesis-N-opened`:
1. **Append** the new thesis to `CHARTER-LINEAGE.md` with its hash, its claim, its demands, and
   the argument that it is no easier than its predecessor. Never edit a prior entry.
2. Mark the previous entry `**Superseded by:** thesis N`.
3. Rewrite `CHARTER.md` and re-key `CHARTER.lock` to match.
4. Write a prominent `HISTORY.md` entry — this is the record the owner reads to find out.
5. Reset `failed_syntheses=0` and `layer=2` in the state line above: a new thesis reopens every
   layer beneath it, and the loop returns to ordinary era work under the new premise.

`done.sh` refuses to pass if the live charter hash is absent from the lineage — so the loop can
change what the game is for, but never quietly.
