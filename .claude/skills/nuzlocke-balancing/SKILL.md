---
name: nuzlocke-balancing
description: Design principles for a fair hard-mode in the Renegade-style Platinum hack — telegraphed boss fights, no unfair RNG fakeouts, sensible level curves and movesets. Use when deciding trainer teams, levels, movesets, AI, or species balance so difficulty stays hard-but-fair and Nuzlocke-viable.
---

# Nuzlocke balancing — hard but fair

The goal is Renegade-Platinum-style difficulty that is **genuinely hard yet fair to a Nuzlocke
player** (one death = permanent loss). Difficulty should come from smart design, not from cheap shots.

## Core principles

1. **Telegraph bosses.** A gym leader / rival / Elite Four fight should be a wall the player can
   scout and prepare for. Give bosses coherent, themed teams with real movesets and items so a
   prepared player wins and an unprepared one loses — predictably, not randomly.

2. **No unfair RNG fakeouts.** Avoid difficulty that hinges on the player losing a coin-flip:
   - No surprise OHKO moves (Fissure/Horn Drill) on bosses.
   - Be deliberate with flinch-spam (e.g. paired Fake Out / repeated flinch), evasion stacking
     (Double Team), and one-shot crit reliance. These create deaths the player couldn't have
     prevented — the opposite of Nuzlocke-fair.
   - Status (paralysis/sleep) is fine as pressure, but don't stack it into a guaranteed loss.

3. **Sensible level curve.** Levels should rise smoothly with the badge/route progression. Bosses
   can sit a few levels above the surrounding trainers, but a sudden 8-level spike with no grinding
   spot between is unfair. Keep the curve learnable.

4. **Movesets over raw stats.** A boss with a real 4-move set (STAB + coverage + setup/utility) is
   harder *and* fairer than one with inflated stats and bad moves. Favor full movesets, type
   coverage, and a held item (Sitrus/Lum/Leftovers) that rewards reading the fight.

5. **AI that uses its tools.** Give bosses `AI_FLAG_EXPERT` (and a high `iv_scale`) so they actually
   pilot their team — predictable competence is the fair kind of hard.

6. **Buffs with intent (species-balancer).** When buffing weak lines for the harder mode, make them
   viable, not broken. The point is to widen the player's fair options, not to trivialize fights.

## Quick checklist before shipping a boss team

- [ ] Full, themed 4-move sets with coverage — not auto-filled weak moves.
- [ ] Level fits the curve (a few above local trainers, not a cliff).
- [ ] No OHKO moves; flinch/evasion/status not stacked into an unavoidable loss.
- [ ] `AI_FLAG_EXPERT` + high `iv_scale` so the AI plays the team well.
- [ ] A held item that rewards the player for reading the fight.
- [ ] Beatable by a prepared, attentive player without relying on luck.
