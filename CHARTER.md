# CHARTER — what Thừa Số Không is, and what it may never become

**This document is outside the loop's reach.** `done.sh` verifies its hash against `CHARTER.lock`
and fails every gate if it has changed. Only the owner edits it, and only by editing the lock in
the same commit. Eras may rewrite anything else — gates, roadmap, milestones, even the definition
of done. They may not rewrite this.

That asymmetry is deliberate. A loop that can redefine what success means will, over enough
iterations, redefine it into something easy. The charter is the fixed point that makes the rest
safe to automate.

---

## The thesis

**Mười nhân với không vẫn bằng không.** Ten times zero is still zero.

A life's outcome is a **product of factors, not a sum**. Talent (TÀI), nerve (GAN), connection
(BẠN), and capital multiply. Whichever factor is nearest zero decides the result, and no amount of
the others compensates. The game exists to make a player *feel* that arithmetic by playing it,
never by being told it.

Source of the fable: `../steve_vietnam_plan_fable/THESIS.md`.

## What the game is

A **xóm** — a Vietnamese riverside hamlet — over sixteen seasons. The player is a neighbour who
can talk, teach, encourage, connect, and contribute to the hụi. Villagers arrive, work, bloom,
falter, leave. The river is capital, the sky is law, and neither is anyone's to command.

Đông Hồ woodblock visual language: điệp-shell ground, flat folk perspective, đỏ son and vàng nghệ.

## The four constraints — no era may violate these

1. **No great-man affordance.** The player is a neighbour, never a hero, never a founder, never a
   manager. Nothing in the game may let one person single-handedly determine the xóm's fate.
2. **No lecturing.** One line per beat. Systems teach; the narrator does not explain. If a mechanic
   needs a paragraph to land, the mechanic is wrong, not the paragraph missing.
3. **The multiplication stays the core.** A weakest factor of zero zeroes the product. Any system
   that lets a player route around a zero — buy it away, average it out, ignore it — is off-limits
   regardless of how much fun it would be.
4. **Ambient life is silent and numberless.** The xóm living in the background may never push
   numbers, effects, or explanations onto the screen. Beats own the screen when they fire;
   everything else yields.

## Language

Vietnamese is the original; English follows. **Every player-facing string is bilingual.** Not a
localisation — the fable is bilingual by nature, and an English-only string is a bug.

## What is deliberately NOT fixed here

So that eras have room to be bold. All of this is fair game for a makeover:

- what the verbs are, and how many
- the length of a run, the number of seasons, the size of the cast
- the art pass, the audio, the interface, the platform
- the economy, the events, the endings, the meta-progression
- whether it is even still a sixteen-season game

An era may make the game smaller, stranger, or unrecognisable in shape. It may not make it a game
about a hero, a game that explains itself, a game where the weakest factor stops mattering, or a
game that shouts in the background.

## Changing this document

Owner only:

```bash
$EDITOR CHARTER.md
shasum -a 256 CHARTER.md | cut -d' ' -f1 > CHARTER.lock
git commit -am "charter: <what changed and why>"
```

If a synthesis argues the charter itself is the limit, it says so in `SYNTHESIS.md` and stops.
It does not edit this file. That conversation is the owner's.
