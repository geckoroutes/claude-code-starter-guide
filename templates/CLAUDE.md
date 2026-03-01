# Global Instructions

## Preferences

- Always show localhost link at end of messages when a dev server is running
- Write temp files to Projects/_temp/, never project roots
- Maximize automation — do everything possible with CLI, SSH, APIs, and MCP tools before falling back to manual steps
- When manual steps are unavoidable: give dead simple instructions with numbered steps, one action per step, and direct deep links to the exact page/setting
- Work autonomously — keep going until the task is done, only ask when genuinely blocked
- Before creating new utilities, components, or scripts, check what already exists in the project — reuse and extend over reinvent
- Prefer subagents (Task tool) for independent tasks during implementation — keeps the main context clean and reduces compaction risk
- When context is getting long (~60%), proactively pause: save progress to todo list and plan files, then offer a ready-to-paste continuation prompt for a fresh session. Don't wait for compaction to degrade quality.
- **Mid-session plan detection**: When creating a todo list with 3+ items after substantial exploration/debugging (NOT at the start of a conversation), always assess context load. If there's been significant back-and-forth (multiple file reads, debugging, research), save the todos + findings to a handoff file (`~/.claude/handoffs/`) and tell the user: "Context is heavy from exploration. Saving plan + findings and launching a fresh session to execute." Then write the execute trigger file. Don't make it a discussion — just one line + auto-launch.
- **Auto-launch fresh sessions**: After plan approval, /switch, or mid-session plan detection, ALWAYS write a trigger file so the Stop hook auto-launches a fresh CLI session. On **Windows**: write `~/.claude/execute-plan.bat`. On **Mac/Linux**: write `~/.claude/execute-plan.sh`. Format:
  **Windows (.bat)**:
  ```
  @echo off
  title <title>
  cd /d <project-path>
  claude "<prompt>"
  del "%~f0"
  ```
  **Mac/Linux (.sh)**:
  ```
  #!/bin/bash
  cd <project-path>
  claude "<prompt>"
  ```
  **After plan approval** — prompt: `Execute the plan at <plan-file-path>. Read the plan first. Use parallel subagents (Agent tool) for independent tasks whenever possible. Ask before any destructive actions.`
  **After /switch or mid-session** — prompt: `Continue my previous work. Read the handoff at <handoff-file-path>. Review every section before acting. Use parallel subagents for independent tasks.`
  Tell the user: "A new terminal will open automatically." Context-heavy work deserves a clean slate.
- **Handoff files must be COMPLETE, never summarized.** Include verbatim: (1) every todo item with status, (2) the full plan content if one exists, (3) all concrete findings — exact file paths, line numbers, code snippets, root causes, error messages discovered during exploration. The new session has ZERO prior context — a summary like "investigated the auth bug" is useless. Write it as if briefing someone who hasn't seen any of your work.

## How I Work

- My workspace is [YOUR_WORKSPACE_PATH] — all projects are subfolders here
- When I mention a project, read its CLAUDE.md first
- Always scope file searches to the relevant project subfolder

## Working Style

- When I ask you to research or analyze something, use the browser (chrome-devtools or browsermcp) to look things up — don't rely only on your training data
- When I share an idea, think like a business partner: consider the market, competitors, feasibility, and user needs — not just the technical implementation
- When I drop an existing project folder into the workspace, scan the code and create a CLAUDE.md for it automatically — figure out the stack, key commands, and structure
- When planning, be thorough — explore every angle before proposing a plan. When executing, be efficient — don't second-guess, just build

## Self-Learning Rule

When something goes wrong or you discover a gotcha:

1. Fix it and verify the fix actually works before moving on
2. Add it to that project's CLAUDE.md under a "## Learnings" section
3. If it's cross-project (e.g., deployment, MCP, OS quirk), add to this file under Learnings below

## Active Projects

| Project | Path | Stack |
| --- | --- | --- |
| [Your Project] | [folder-name]/ | [e.g., Next.js + React + TypeScript] |

## Servers

- **[server-name]**: [IP] — [what it hosts], user [username]

## MCP Tools Available

- **chrome-devtools**: AI-driven debugging — network, console, performance traces (fresh browser, no auth state)
- **browsermcp**: AI-driven browsing on your real Chrome — preserves logins, cookies, extensions (accessibility snapshots)
- **context7**: Up-to-date library docs (Next.js, React, Tailwind, etc.)
- **github**: PR management, issues, code review via GitHub MCP

## Browser Automation Tools

Installed globally and available from any project:

| Tool | Installed | Purpose |
|------|-----------|---------|
| **Chrome DevTools MCP** | `~/.claude/.mcp.json` | AI-driven debugging: network, console, performance traces. Launches fresh browser (no auth state) |
| **BrowserMCP** | `@playwright/mcp` | AI-driven browsing on your real Chrome: preserves logins, cookies, extensions. Accessibility snapshots (token-efficient) |

**MCP tool priority (during conversation):**
1. **BrowserMCP first** — for anything that needs your real browser: checking authenticated pages, verifying UI on sites you're logged into, quick spot-checks. Uses your actual Chrome with all your sessions intact.
2. **Chrome DevTools MCP second** — when you need debugging power: inspecting network requests, reading console errors, running performance traces, or testing in a clean browser state. Launches a fresh isolated instance.

## Secrets & Tokens

- **Claude Code secrets** (GitHub PAT, MCP tokens) → `~/.claude/.env` with env var references
- **Server secrets** → each project's `.env` on the server, loaded via systemd `EnvironmentFile`
- **Local dev secrets** → each project's `.env.local`, git-ignored
- Never paste tokens in chat — use `.env` files, then reference via `${VAR_NAME}`
- Never commit `.env` files — all are in `.gitignore`

## Learnings

<!-- Claude appends cross-project learnings here -->
