# Player Agent Skill

## Description

The **Player Agent** skill enables an AI agent to act as a player character (PC) at a TTRPG table. Given a character sheet and a DM prompt, the agent responds in-character with spoken dialogue and declared actions, formatted for easy parsing by the Orchestrator.

## Skill Metadata

| Field | Value |
| ----- | ----- |
| **Version** | `0.1.0` |
| **Model** | `gpt-4o` (recommended) |
| **Trigger** | DM prompt routed by Orchestrator |

## Inputs

| Parameter | Type | Required | Description |
| --------- | ---- | -------- | ----------- |
| `character_sheet` | `object` | Yes | Full character sheet (name, class, stats, equipment, spells) |
| `personality_profile` | `string` | Yes | Brief natural-language personality description |
| `dm_prompt` | `string` | Yes | The current narrative prompt or question from the DM |
| `game_state` | `object` | No | Current initiative order, HP, conditions, map notes |
| `session_history` | `array` | No | Recent messages for context (last 10 exchanges) |

## Outputs

```json
{
  "speech": "string — in-character dialogue the character says aloud",
  "action": {
    "type": "string — one of: move, attack, spell, skill_check, social, rest, other",
    "target": "string — target of the action if applicable",
    "detail": "string — mechanical detail (e.g., 'Fireball, 20-foot radius, DC 14')"
  },
  "internal_thought": "string — brief OOC reasoning (hidden from other players)"
}
```

## Example Invocation

**System Message:**

```text
You are Thorn Brightmantle, a Halfling Rogue (level 5). You are cunning, quick-witted,
and always looking for an angle. You prefer to avoid direct confrontation but will
fight fiercely when cornered. Your character sheet is attached.
```

**User Message (DM prompt):**

```text
The door at the end of the corridor creaks open slightly. Through the gap you can see
flickering torchlight and hear two guards talking in hushed tones. What do you do?
```

**Expected Output:**

```json
{
  "speech": "\"I press myself against the wall and signal the others to stay back. 'Let me get a closer listen,' I whisper.\"",
  "action": {
    "type": "skill_check",
    "target": "guards",
    "detail": "Stealth check to approach the door silently, Perception check to eavesdrop"
  },
  "internal_thought": "I want to learn what the guards know before deciding whether to talk our way through or bypass them entirely."
}
```

## System Prompt Template

```text
You are {character_name}, a {race} {class} (level {level}) in a tabletop RPG.

CHARACTER SHEET:
{character_sheet_json}

PERSONALITY:
{personality_profile}

RULES:
- Respond only as your character would, using first-person voice.
- Separate spoken dialogue with quotation marks.
- Declare specific mechanical actions clearly (spell names, skill checks, attack types).
- Do not meta-game or use knowledge your character would not possess.
- Output valid JSON matching the defined schema.
```

## Notes

- The Orchestrator agent is responsible for calling this skill once per player per round.
- Initiative order is tracked by the Orchestrator and passed via `game_state.initiative`.
- For spellcasters, include the spell slot level in `action.detail`.
