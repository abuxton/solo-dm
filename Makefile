# Makefile — solo-dm
#
# Targets for setting up, validating, and running solo-dm game sessions.
# Prerequisites: Node.js >=18, npm, OPENAI_API_KEY environment variable

.PHONY: all install lint clean help session check-env

# Default target
all: lint

##@ Setup

install: ## Install project dependencies (markdownlint-cli)
	@echo "Installing markdownlint-cli..."
	npm install -g markdownlint-cli
	@echo "Done. Run 'make lint' to validate all Markdown files."

##@ Validation

lint: ## Validate all Markdown files with markdownlint
	@echo "Running markdownlint..."
	markdownlint "**/*.md" --ignore node_modules --config .markdownlint.yml
	@echo "All Markdown files passed linting."

##@ Session Management

check-env: ## Check required environment variables are set
	@echo "Checking environment..."
	@test -n "$(OPENAI_API_KEY)" || \
		{ echo "ERROR: OPENAI_API_KEY is not set. Export it before running a session."; exit 1; }
	@echo "Environment OK."

session: check-env ## Start an interactive DM session (requires OPENAI_API_KEY)
	@echo "Starting solo-dm session..."
	@echo "Load your campaign state from docs/prompts/session-start.md"
	@echo "and paste it into your preferred OpenAI/Copilot interface."
	@echo ""
	@echo "Session template:"
	@cat docs/prompts/session-start.md

combat: ## Display the combat prompt templates
	@cat docs/prompts/combat.md

skills: ## List available agent skill definitions
	@echo "Available skills:"
	@ls -1 docs/skills/

instructions: ## List available instruction files
	@echo "Available instructions:"
	@ls -1 docs/instructions/

##@ Housekeeping

clean: ## Remove generated files and caches
	@echo "Cleaning up..."
	@find . -name "*.log" -not -path "./.git/*" -delete
	@echo "Done."

##@ Help

help: ## Display this help message
	@echo ""
	@echo "solo-dm — AI-orchestrated tabletop RPG table"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n"} \
		/^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } \
		/^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) }' $(MAKEFILE_LIST)
	@echo ""
