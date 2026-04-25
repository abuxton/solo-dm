# solo-dm

> An AI-orchestrated tabletop RPG table — a live human Dungeon Master with virtual AI players powered by OpenAI and GitHub Copilot agents.

## Overview

**solo-dm** enables a tabletop role-playing game (TTRPG) experience where a single human acts as the Dungeon Master (DM) while all player characters are facilitated by orchestrated AI agents. The project leverages OpenAI GPT models and GitHub Copilot agent skills to simulate a full player party, each with distinct personalities, decision-making styles, and in-character voices.

This repository contains:

- **Agent skills** — reusable Copilot/OpenAI skill definitions for player characters and game mechanics
- **System instructions** — prompt engineering and instruction files for each AI actor
- **Session prompts** — ready-made prompt templates for common game scenarios
- **Makefile** — automation targets for setting up and running game sessions
- **Workflows** — CI/CD to validate all markdown content

## Architecture

```text
┌─────────────────────────────────────────────────────┐
│                   Game Session                       │
│                                                      │
│   Human DM ──► Orchestrator Agent                   │
│                      │                              │
│          ┌───────────┼───────────┐                  │
│          ▼           ▼           ▼                  │
│     Player A     Player B     Player C              │
│   (AI Agent)   (AI Agent)   (AI Agent)              │
│                                                      │
│   Rules Engine (System Reference Document)          │
└─────────────────────────────────────────────────────┘
```

The **Orchestrator Agent** receives narrative input from the DM, routes turns to each Player Agent, collects responses, and returns a unified game-state update. Each **Player Agent** is given a character sheet, personality profile, and skill set, and responds in-character to DM prompts.

## Getting Started

### Prerequisites

- [GNU Make](https://www.gnu.org/software/make/) ≥ 4.0
- [Node.js](https://nodejs.org/) ≥ 18 (for `markdownlint-cli`)
- An OpenAI API key (`OPENAI_API_KEY` environment variable)
- GitHub Copilot access (for Copilot agent skill invocation)

### Installation

```bash
git clone https://github.com/abuxton/solo-dm.git
cd solo-dm
make install
```

### Running a Session

```bash
# Start a new campaign session
make session

# Validate all markdown documents
make lint
```

## Repository Structure

```text
solo-dm/
├── .github/
│   ├── copilot-instructions.md   # Copilot agent global instructions
│   └── workflows/
│       └── markdown-lint.yml     # Markdown validation CI workflow
├── docs/
│   ├── skills/                   # Agent skill definitions
│   │   ├── player-agent-skill.md
│   │   └── dm-assistant-skill.md
│   ├── instructions/             # System & character instructions
│   │   ├── system-instructions.md
│   │   └── player-instructions.md
│   ├── prompts/                  # Reusable prompt templates
│   │   ├── session-start.md
│   │   └── combat.md
│   └── related-projects.md      # Curated list of related GitHub projects
├── Makefile                      # Game session automation
├── .markdownlint.yml             # Markdownlint rule configuration
├── LICENSE
└── README.md
```

## Game System

This project is designed to be system-agnostic but ships with examples built around the [Systems Reference Document (SRD) 5.1](https://dnd.wizards.com/resources/systems-reference-document) for D&D 5e under the Creative Commons license. The `docs/instructions/` files can be adapted for any TTRPG system.

## Related Projects

See [`docs/related-projects.md`](docs/related-projects.md) for a curated list of relevant GitHub projects, tools, and SRD resources.

## Contributing

Contributions are welcome. Please open an issue first to discuss proposed changes.

## License

This project is released into the public domain. See [LICENSE](LICENSE) for details.
