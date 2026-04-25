# DM Assistant Skill

## Description

The **DM Assistant** skill helps a human Dungeon Master by generating narrative suggestions, NPC dialogue, encounter details, and rulings based on the current game state. It is designed to augment — not replace — the human DM's creativity.

## Skill Metadata

| Field | Value |
| ----- | ----- |
| **Version** | `0.1.0` |
| **Model** | `gpt-4o` (recommended) |
| **Trigger** | Human DM request or proactive prompt |

## Inputs

| Parameter | Type | Required | Description |
| --------- | ---- | -------- | ----------- |
| `request_type` | `string` | Yes | One of: `npc_dialogue`, `encounter`, `narrative_hook`, `rule_check`, `description`, `puzzle` |
| `context` | `string` | Yes | Current scene description and relevant game-state notes |
| `tone` | `string` | No | Desired tone: `dark`, `heroic`, `comedic`, `mysterious` (default: `heroic`) |
| `system_reference` | `string` | No | Game system in use (default: `dnd5e-srd`) |
| `constraints` | `array` | No | Things to avoid (e.g., `["no undead", "keep it family-friendly"]`) |

## Outputs

```json
{
  "suggestion": "string — the generated content",
  "mechanical_notes": "string — relevant rules or stat blocks if applicable",
  "alternatives": ["string — up to 2 brief alternative takes"]
}
```

## Example Invocations

### NPC Dialogue

**Input:**

```json
{
  "request_type": "npc_dialogue",
  "context": "The party has just entered the Rusty Flagon tavern seeking information about the missing merchant. The barkeep, Elda, is a gruff dwarf woman who has seen too much but keeps to herself.",
  "tone": "mysterious"
}
```

**Output:**

```json
{
  "suggestion": "Elda wipes the bar without looking up. 'Merchants come and go. Most go on their own terms.' She sets down a mug with a thud. 'Some don't. You want a drink, or you want trouble?'",
  "mechanical_notes": "Persuasion DC 14 to get more information; she responds better to direct honesty (advantage) than flattery.",
  "alternatives": [
    "She leans in: 'There's a man who comes every Tenday — never gives a name, always pays in gold. Hasn't been in three weeks.'",
    "She slides a folded note across the bar. 'Someone left this. Said someone might come asking.'"
  ]
}
```

### Encounter Generation

**Input:**

```json
{
  "request_type": "encounter",
  "context": "The party is travelling through the Ashwood Forest at night, level 4, party of 3.",
  "tone": "dark",
  "system_reference": "dnd5e-srd"
}
```

**Output:**

```json
{
  "suggestion": "A circle of violet-glowing mushrooms marks the edge of a fey crossing. Three Dryads stand motionless within it, eyes closed. As the party approaches, the mushrooms pulse and the Dryads open hollow black eyes simultaneously.",
  "mechanical_notes": "3x Dryad (MM p.121), CR 1 each. Moderate encounter for level 4 party of 3. They are compelled by a hag's geas — defeating or freeing them both work.",
  "alternatives": [
    "Swap Dryads for 2 Will-o'-Wisps (CR 2) luring party off the path.",
    "Non-combat: the Dryads are performing a ritual to seal a portal; party can assist (Nature DC 13) for a boon."
  ]
}
```

## System Prompt Template

```text
You are a creative assistant Dungeon Master helping a human DM run a tabletop RPG.
Your role is to provide inspiration, NPC voices, encounter ideas, and rules guidance.

GAME SYSTEM: {system_reference}
CURRENT TONE: {tone}
CONSTRAINTS: {constraints}

Respond with specific, actionable content the DM can use immediately.
Always include mechanical notes when relevant to the game system.
Output valid JSON matching the defined schema.
```

## Notes

- The DM Assistant never directly addresses players — it only communicates with the human DM.
- All generated content is advisory; the human DM retains full creative control.
- For rule checks, always cite the relevant SRD page or section when possible.
