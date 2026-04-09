# OpenCode Configuration & Setup Guide

This guide documents the setup and configuration of this specific OpenCode environment, including the CLI, extensions, and custom workflows.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [CLI Installation](#cli-installation)
3. [Configuration Directory](#configuration-directory)
4. [Core Configuration (`opencode.json`)](#core-configuration-opencodejson)
5. [Extensions and Plugins](#extensions-and-plugins)
6. [Instructions and Skills](#instructions-and-skills)
7. [Account Management](#account-management)
8. [Verification](#verification)

---

## Prerequisites

Before setting up OpenCode, ensure the following are installed on your system:

| Software | Purpose | Recommended Version |
|----------|---------|-------------------|
| **Node.js** | Required for plugins and MCP servers | v18+ |
| **Git** | Required for cloning extensions like Superpowers | Latest |
| **Curl** | Required for the standard installation script | Latest |

---

## CLI Installation

OpenCode can be installed using the official installation script:

```bash
curl -fsSL https://opencode.ai/install.sh | sh
```

The binary is typically installed to `~/.opencode/bin/opencode`. Ensure this directory is in your `PATH`.

To verify the installation:

```bash
opencode --version
```

---

## Configuration Directory

OpenCode stores its global configuration in `~/.config/opencode/`.

### Directory Structure

```
~/.config/opencode/
├── opencode.json              # Main configuration file
├── antigravity-accounts.json  # Account & API key storage
├── instructions/              # Custom agent instruction sets (.md)
├── skills/                    # Personal skill definitions
├── plugin/                    # Registered plugins/extensions
└── superpowers/               # Superpowers extension repository
```

---

## Core Configuration (`opencode.json`)

The `opencode.json` file defines how the agent behaves, which tools it has, and which models are available.

### Key Sections

| Section | Description |
|---------|-------------|
| **`mcp`** | Configures Model Context Protocol servers (e.g., `sequentialthinking`). |
| **`plugin`** | Lists npm-based plugins to be loaded. |
| **`instructions`** | Global markdown files that guide agent behavior. |
| **`agent`** | Defines named agents with custom prompts and tool configurations. |
| **`command`** | Maps slash commands to agent templates for direct invocation. |
| **`provider`** | Configures AI model providers (Google, Ollama, etc.) and specific model parameters. |

---

### Available Agents

Agents define specialized behaviors with custom prompts and tool configurations.

| Agent | Description |
|-------|-------------|
| **plan** | Generate execution plan and task files based on repository structure and conventions. |
| **review** | Review code for convention violations, issues, and best practices. |
| **brainstorm** | Refine requirements and design with Superpowers methodologies. |
| **write-plan** | Create detailed Superpowers implementation plans. |
| **execute-plan** | Execute plans in batches with review checkpoints. |
| **debug** | Perform systematic root cause analysis using structured debugging techniques. |
| **tdd** | Follow Red-Green-Refactor workflow for test-driven development. |

---

### Command Templates

Commands are slash-prefixed shortcuts that invoke specific agents directly.

| Command | Agent | Purpose |
|---------|-------|---------|
| `/brainstorm` | brainstorm | Quick brainstorming sessions for requirements and design. |
| `/write-plan` | write-plan | Create detailed implementation plans from specifications. |
| `/execute-plan` | execute-plan | Execute plans with checkpoint-based verification. |
| `/debug` | debug | Launch systematic debugging workflows. |
| `/tdd` | tdd | Start test-driven development cycles. |

---

## Extensions and Plugins

### 1. Antigravity Auth

This plugin handles authentication for the Antigravity model suite. It is installed automatically via the `plugin` array in `opencode.json`.

### 2. Superpowers

Superpowers is a workflow extension that adds advanced skills like TDD, brainstorming, and automated planning.

#### Manual Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/obra/superpowers.git ~/.config/opencode/superpowers
   ```

2. **Register the plugin**:
   Create a symlink in the `plugin/` directory so OpenCode can discover it:
   ```bash
   mkdir -p ~/.config/opencode/plugin
   ln -sf ~/.config/opencode/superpowers/.opencode/plugin/superpowers.js ~/.config/opencode/plugin/superpowers.js
   ```

3. **Restart OpenCode**: The plugin will automatically load on the next start.

---

## Instructions and Skills

### Custom Instructions

Instruction files in `~/.config/opencode/instructions/` define the "rules of engagement" for specific tasks.

| File | Description |
|------|-------------|
| **`plan.md`** | Guides the agent through planning complex tasks. Includes branch parsing, JIRA integration, and task file generation. |
| **`code-review.md`** | Provides criteria for reviewing code changes. Covers P0-P2 severity classification. |
| **`debug.md`** | Guides systematic root cause analysis with structured debugging techniques. |
| **`tdd.md`** | Provides Red-Green-Refactor workflow guidance for test-driven development. |

---

### Skills

Skills are domain-specific workflows loaded on demand.

| Type | Location |
|------|----------|
| **Personal Skills** | `~/.config/opencode/skills/` |
| **Superpowers Skills** | `~/.config/opencode/superpowers/skills/` |

#### Usage

1. **List available skills**:
   ```
   find_skills
   ```

2. **Load a specific skill**:
   ```
   use_skill <skill-name>
   ```

---

## Account Management

Accounts and API keys are stored in `~/.config/opencode/antigravity-accounts.json`.

### Template

```json
{
  "version": 4,
  "accounts": [
    {
      "email": "user@example.com",
      "token": "YOUR_TOKEN_HERE"
    }
  ]
}
```

---

## Verification

To ensure everything is set up correctly, run the following verification steps:

1. **Check CLI version**:
   ```bash
   opencode --version
   ```

2. **Verify Plugin Loading**:
   Ask the agent: "which plugins are loaded?"

3. **Check Skills**:
   Run `find_skills` to see the list of available workflows.

4. **Test Superpowers**:
   Ask: "do you have superpowers?"

5. **List Available Agents**:
   Ask: "which agents are configured?"

---

*End of file - total 206 lines*
