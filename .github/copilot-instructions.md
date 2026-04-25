# GitHub Copilot Agent Instructions — solo-dm

## Project Purpose

This repository orchestrates tabletop RPG (TTRPG) game sessions where a single human Dungeon Master (DM) runs a table populated by AI player agents. Copilot agents are used to simulate individual player characters, each with unique personalities, backstories, and decision-making styles.

## Repository Layout

- `docs/skills/` — Agent skill definitions (actions an agent can invoke)
- `docs/instructions/` — System and character-level instructions
- `docs/prompts/` — Reusable prompt templates
- `Makefile` — Automation for sessions and tooling

## Coding Standards

- All documentation and content files **must** be in Markdown (`.md`)
- Makefile targets must follow the conventions in the existing `Makefile`
- No secrets or API keys should ever be committed; reference them as environment variables only
- New agent skills must include a brief description, expected inputs, and expected outputs

## Agent Roles

| Role | Responsibility |
|------|----------------|
| **Orchestrator** | Routes DM input to all player agents, aggregates responses |
| **Player Agent** | Responds in-character based on assigned character sheet |
| **Rules Agent** | Arbitrates rules questions using the SRD reference |
| **DM Assistant** | Suggests narrative hooks, NPC dialogue, encounter details |

## Prompt Engineering Guidelines

1. Always include the character sheet summary in the system message for a Player Agent.
2. Keep the in-character voice consistent with the personality profile defined in `docs/instructions/player-instructions.md`.
3. Use structured JSON output for combat actions to allow programmatic parsing.
4. Separate in-character speech (`"..."`) from out-of-character actions (`*...*`).

## Workflow

- CI validates all Markdown via `markdownlint`; ensure no linting errors before committing
- Run `make lint` locally before pushing changes
