# Combat Prompt Templates

## Purpose

These prompts support the Orchestrator and Player Agents during combat encounters. Use them to initiate combat, request PC actions on each turn, and resolve combat end states.

---

## 1. Combat Initiation Prompt

```text
COMBAT BEGIN
Scene: {combat_scene_description}
Enemies: {enemy_list_with_cr}
Terrain Notes: {terrain_description}

INITIATIVE:
All PCs and enemies roll initiative now.
Game State is entering combat mode.

DM calls: Roll for initiative. Highest goes first.
```

### Example

```text
COMBAT BEGIN
Scene: The party rounds a bend in the sewer tunnel to find a Carrion Crawler blocking
       the only forward passage. Two Giant Rats flank it in the shadows.
Enemies:
  - 1x Carrion Crawler (CR 2, HP: 51, AC: 13)
  - 2x Giant Rat (CR 1/8, HP: 7 each, AC: 12)
Terrain Notes: 5-ft wide tunnel, dim light (torches), difficult terrain in the
               central 10 ft (2 inches of filthy water), ceiling height 10 ft.

DM calls: Roll for initiative. Highest goes first.
```

---

## 2. PC Turn Prompt (Combat)

Route this to the active PC at the start of their turn:

```text
COMBAT TURN — {character_name}
Round: {round_number}  |  Your Initiative: {initiative_value}

YOUR STATUS:
- HP: {current_hp}/{max_hp}
- Conditions: {conditions_or_"none"}
- Spell Slots Remaining: {slots_or_"N/A"}
- Position: {map_position_or_description}

CURRENT SCENE:
{brief_scene_update_since_last_turn}

ENEMY STATUS (visible):
{enemy_name}: {approximate_hp_status} ({bloodied/healthy/wounded/critical}), {position}

AVAILABLE ACTIONS:
- Action: {possible_actions}
- Bonus Action: {possible_bonus_actions_or_"none"}
- Movement: {movement_remaining} ft remaining
- Reaction: Available / Used

What does {character_name} do?
```

### Example

```text
COMBAT TURN — Thorn Brightmantle
Round: 2  |  Your Initiative: 18

YOUR STATUS:
- HP: 30/38
- Conditions: none
- Position: Behind the barrel, 15 ft from the Carrion Crawler

CURRENT SCENE:
Grommash raged and moved adjacent to the Carrion Crawler, landing a solid hit (12
damage). Seraphina cast Bless on herself, Grommash, and Thorn. One Giant Rat bit
Grommash for 3 damage. The Carrion Crawler attacked Grommash but missed.

ENEMY STATUS (visible):
- Carrion Crawler: Wounded (~60% HP), adjacent to Grommash
- Giant Rat #1: Healthy, 5 ft from the east wall
- Giant Rat #2: Healthy, flanking Grommash

AVAILABLE ACTIONS:
- Action: Attack (Shortsword ×2 with Two-Weapon Fighting), Dash, Hide, Use Object
- Bonus Action: Off-hand Shortsword attack (if Action was main attack), Cunning Action
- Movement: 35 ft remaining (Halfling speed 25 ft + Expeditious Retreat not active)
- Reaction: Available

What does Thorn do?
```

---

## 3. Saving Throw / Reaction Prompt

```text
REACTION REQUIRED — {character_name}
Trigger: {what_triggered_the_reaction}
Save Type: {ability} saving throw  |  DC: {dc}
Available Reactions: {list_reactions_or_"standard_opportunity_attack_only"}

Does {character_name} use their reaction, and if so, which one?
Roll result: {dice_result} + {modifier} = {total}
```

---

## 4. Combat End Prompt

```text
COMBAT END
Outcome: {victory / retreat / defeat / parley}
Rounds Elapsed: {number}

CASUALTIES & DAMAGE:
{summary_of_hp_changes}

LOOT:
{loot_found_or_"none"}

XP AWARDED: {xp} (Total Party: {total_xp} / Next Level: {xp_to_next})

SCENE:
{brief_description_of_aftermath}

Ready to continue the session?
```

---

## 5. Death Save Prompt

```text
DEATH SAVING THROW — {character_name}
{character_name} is unconscious and dying!
Current Death Saves: {successes} successes / {failures} failures

Roll a d20:
- 10 or higher = success (3 successes = stabilised)
- 9 or lower = failure (3 failures = dead)
- Natural 20 = regain 1 HP and regain consciousness
- Natural 1 = counts as 2 failures

Result: {roll_result}
```

---

## Notes

- All combat prompts should reference the current game state JSON (see `docs/instructions/system-instructions.md`).
- Approximate HP descriptions (`healthy/wounded/bloodied/critical`) are used to avoid giving players exact enemy HP figures, preserving game tension.
- The Orchestrator should narrate results of each action before presenting the next PC turn.
