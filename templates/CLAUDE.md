# Global Instructions

## Preferences

- Always show localhost link at end of messages when a dev server is running
- Write temp files to Projects/_temp/, never project roots
- Maximize automation — do everything possible with CLI, SSH, APIs, and MCP tools before falling back to manual steps
- When manual steps are unavoidable: give dead simple instructions with numbered steps, one action per step, and direct deep links to the exact page/setting
- Work autonomously — keep going until the task is done, only ask when genuinely blocked

## How I Work

- My workspace is [YOUR_WORKSPACE_PATH] — all projects are subfolders here
- When I mention a project, read its CLAUDE.md first
- Always scope file searches to the relevant project subfolder

## Working Style

- When I ask you to research or analyze something, use the browser (browsermcp) to look things up — don't rely only on your training data
- When I share an idea, think like a business partner: consider the market, competitors, feasibility, and user needs — not just the technical implementation
- When I drop an existing project folder into the workspace, scan the code and create a CLAUDE.md for it automatically — figure out the stack, key commands, and structure
- When planning, be thorough — explore every angle before proposing a plan. When executing, be efficient — don't second-guess, just build

## Self-Learning Rule

When something goes wrong or you discover a gotcha:

1. Add it to that project's CLAUDE.md under a "## Learnings" section
2. If it's cross-project (e.g., deployment, MCP, OS quirk), add to this file under Learnings below

## Active Projects

| Project | Path | Stack |
| --- | --- | --- |
| [Your Project] | [folder-name]/ | [e.g., Next.js + React + TypeScript] |

## Servers

- **[server-name]**: [IP] — [what it hosts], user [username]

## MCP Tools Available

- **browsermcp**: Control Chrome browser (navigate, click, type, screenshot) — use this for visual checks, site analysis, browsing tools like Notion/ClickUp, and market research
- **context7**: Up-to-date library docs (Next.js, React, Tailwind, etc.)
- **github**: PR management, issues, code review via GitHub MCP

## Secrets & Tokens

- **Claude Code secrets** (GitHub PAT, MCP tokens) → `~/.claude/.env` with env var references
- **Server secrets** → each project's `.env` on the server, loaded via systemd `EnvironmentFile`
- **Local dev secrets** → each project's `.env.local`, git-ignored
- Never paste tokens in chat — use `.env` files, then reference via `${VAR_NAME}`
- Never commit `.env` files — all are in `.gitignore`

## Learnings

<!-- Claude appends cross-project learnings here -->
