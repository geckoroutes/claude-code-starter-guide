# Claude Code Starter Guide

Turn VS Code and your terminal into an AI-powered development environment that writes, runs, and deploys your code.

**What you get:**
- An AI assistant (Claude) you just chat with — in VS Code or on the command line
- It can control your browser, look up documentation, and manage your GitHub
- It learns your preferences and remembers mistakes so it gets better over time
- One-word deploys: just say "ship my-app" and it handles everything

---

## How it works

```
You type in Claude chat (VS Code sidebar or CLI)
        |
Claude reads your CLAUDE.md files (your preferences + project info)
        |
Claude uses MCP servers if needed (browser, docs, GitHub)
        |
Claude applies skills automatically (design, marketing, security)
        |
Claude writes/edits your code, runs commands, and shows results
        |
You just chat back and forth until it's done
```

---

## Models

Claude Code is powered by Anthropic's Claude models. You can switch between them depending on your needs:

| Model | Best for | How to select |
|-------|----------|---------------|
| **Claude Opus 4.6** | Complex tasks, architecture, deep reasoning | `/model` -> opus |
| **Claude Sonnet 4.6** | Daily coding, fast and capable (default) | `/model` -> sonnet |
| **Claude Haiku 4.5** | Quick questions, simple edits, low cost | `/model` -> haiku |

You can switch models mid-conversation with `/model` or use the model picker in VS Code.

---

## Project structure

Every project gets its own folder inside your workspace. Claude reads a `CLAUDE.md` file at each level to understand your preferences and the project.

```
Your workspace (e.g., ~/Projects/)
|
├── CLAUDE.md                <- Your global preferences (Claude reads this every session)
├── _temp/                   <- Scratch space (screenshots, logs)
|
├── my-first-app/            <- A project
|   ├── CLAUDE.md            <- This project's stack, commands, and learnings
|   └── (your code)
|
└── my-second-app/           <- Another project
    ├── CLAUDE.md
    └── (your code)
```

**The global `CLAUDE.md`** tells Claude how you like to work, what projects you have, and where your servers are. The setup script creates this for you.

**Each project's `CLAUDE.md`** tells Claude the tech stack, key commands, and any gotchas specific to that project.

---

## Installation

### Step 1: Create your accounts

**GitHub** — where your code lives online. Skip if you already have one.
1. Go to **[github.com/signup](https://github.com/signup)**
2. Create an account and verify your email

**Claude** — the AI that powers everything.
1. Go to **[claude.ai](https://claude.ai/)** and create an account
2. Go to **[claude.ai/upgrade](https://claude.ai/upgrade)** and pick a plan:
   - **Pro** ($20/month) — good to start
   - **Max** ($100/month) — for heavy daily use

### Step 2: Run the setup script

This script installs everything automatically — VS Code, Node.js, Git, the Claude Code extension, your workspace, tools, plugins, and skills. It walks you through each step.

**Windows:**
1. [Download this repo](https://github.com/geckoroutes/claude-code-starter-guide/archive/refs/heads/master.zip) and unzip it
2. Right-click `setup-windows.ps1` -> **"Run with PowerShell"**
3. Follow the prompts

**Mac / Linux:**
1. Open Terminal (search "Terminal" in Spotlight or your app menu)
2. Run these two lines:
   ```
   curl -fsSL https://raw.githubusercontent.com/geckoroutes/claude-code-starter-guide/master/setup-mac.sh -o setup-mac.sh && bash setup-mac.sh
   ```
3. Follow the prompts

<details>
<summary>What does the script do?</summary>

- Installs VS Code, Node.js, and Git (if not already installed)
- Installs the Claude Code extension
- Creates your workspace folder (default: `~/Projects`)
- Creates a `CLAUDE.md` file — Claude reads this every session to know your preferences
- Connects your GitHub account (walks you through creating a token so Claude can manage your repos)
- Sets up 4 MCP servers (browser control, browser debugging, live docs, GitHub integration)
- Installs 5 skills (deploy workflow, design principles, marketing copy, psychology, security)
- Installs 4 plugins (TypeScript intelligence, code review, UI design, superpowers workflows)
- Enables bypass mode (Claude works without asking permission)
- Installs task completion notification (toast/banner when Claude finishes)

Nothing is sent anywhere. Everything stays on your machine.

</details>

### Step 3: Start chatting

**In VS Code:**
1. Open VS Code
2. **File -> Open Folder** -> pick your workspace folder (the script told you where it is)
3. Open a file, then click the **Claude icon** in the top right of the editor
4. Sign in with your Claude account

**From the terminal (CLI):**
```bash
claude                          # start an interactive session
claude "create a landing page"  # one-shot command
claude --model opus "review this code"  # specify a model
```

The CLI works anywhere — no VS Code required. Install it with `npm install -g @anthropic-ai/claude-code`.

**Just chat.** Type in plain English like you're talking to a coworker. No special commands needed.

> "Create a new Next.js project called my-app"
> "Help me build a landing page"
> "Fix the login bug"
> "Open my browser and check if the site looks right"
> "Ship my-app"

**Already have a project?** Copy the folder into your workspace, then tell Claude: "Set up this project". It will read your code and figure everything out.

That's it. You're set up.

---

## What the setup script installed

### MCP Servers (Claude's superpowers)

These let Claude interact with the outside world during your conversation:

- **chrome-devtools** — Claude can debug Chrome — inspect network requests, read console logs, run performance traces, take screenshots. Launches a fresh browser (no auth state).
- **browsermcp** — Claude can browse your real Chrome — preserves your logins, cookies, and extensions. Uses accessibility snapshots (token-efficient, no screenshots needed). Note: if you're using the VS Code extension, BrowserMCP may already be available without the `.mcp.json` entry.
- **context7** — Claude gets up-to-date documentation for popular libraries (React, Next.js, Tailwind, etc.) instead of relying on training data
- **github** — Claude can create pull requests, manage issues, and review code on GitHub

**MCP priority:** BrowserMCP first (real browser, your sessions). Chrome DevTools second (debugging power, clean state).

### Built-in tools

Claude Code also has powerful built-in tools that work out of the box (no setup needed):

- **WebSearch** — searches the web for current information, documentation, real-time data
- **WebFetch** — fetches and reads any URL (web pages, API docs, articles)
- **Glob / Grep** — fast file and content search across your codebase
- **Read / Edit / Write** — file operations with line-level precision
- **Bash** — runs shell commands directly
- **TodoWrite** — structured task tracking within a session

### Plugins (Claude's tools)

- **typescript-lsp** — gives Claude IDE-like intelligence — go-to-definition, find references, real error diagnostics
- **code-review** — automated code review that checks security, performance, and readability
- **frontend-design** — helps Claude generate better UI with design system awareness (note: this plugin may come from the `claude-code-plugins` marketplace — if install fails, try `claude plugin marketplace add claude-code-plugins`)
- **superpowers** — structured workflows including:
  - brainstorming — use before any creative/feature work
  - test-driven-development — write tests before implementation
  - systematic-debugging — scientific method for bugs
  - subagent-driven-development — parallel independent tasks
  - writing-plans / executing-plans — design and execute implementation plans
  - verification-before-completion — evidence before success claims
  - code-review workflows — requesting and receiving reviews
  - dispatching-parallel-agents — 2+ independent tasks in parallel

### Skills (Claude's knowledge)

Skills are like cheat sheets that Claude reads automatically when relevant:

- **deploy** — when you say "ship my-app" or "push to live" — handles the full deployment workflow
- **design-principles** — when building any UI — applies typography, color, spacing, and accessibility rules
- **marketing-copy** — when writing landing pages or CTAs — uses proven copywriting frameworks
- **behavioral-psychology** — when designing features — applies habit formation and persuasion principles
- **soc2-compliance** — when handling user data — applies security patterns and audit logging

### Task completion notifications

The setup script installs a **Stop hook** that shows a non-blocking notification (toast on Windows, system notification on Mac/Linux) whenever Claude finishes a response. This way you can tab away and get pinged when it's done.

### Session handoffs (/switch)

When context gets heavy from deep exploration or debugging, Claude can save everything to a handoff file and give you a continuation prompt to paste into a fresh chat:

- **Handoff files** at `~/.claude/handoffs/` contain **complete verbatim context** — every file path, line number, code snippet, and finding
- **The continuation prompt** gets copied to your clipboard — just paste it into a new chat
- The new session picks up exactly where you left off, with zero information loss

### Permission modes

The setup script enables bypass mode by default (Claude just works). There are two ways to control permissions:

**VS Code bypass mode (simple):**
- **Bypass (default)** — Claude does everything without asking. The closest to a ChatGPT experience.
- **Normal** — Claude asks permission before each action. Good if you want to review everything.
- **Accept Edits** — Claude auto-edits files but still asks before running commands. Press **Shift+Tab** to activate.
- **Plan Mode** — Read-only. Claude can look at your code but won't change anything. Type `/plan` to activate.

**Granular permissions via settings.json (advanced):**

For more control, edit `~/.claude/settings.json`:
```json
{
  "permissions": {
    "allow": [
      "Bash(where:*)",
      "Read(path:*)",
      "Edit(path:*)"
    ]
  }
}
```
This lets you allow specific tools while still being prompted for others. Works in both VS Code and CLI.

### Memory system

Claude Code automatically saves things it learns across conversations in memory files at `~/.claude/projects/*/memory/`. This includes:

- Project patterns and conventions it discovers
- Solutions to bugs it encounters
- Your workflow preferences
- Architecture decisions

Memory persists across sessions. You can read and edit these files to correct or add information.

---

## Power-user add-ons

### GSD (Get Shit Done) workflow

An optional project management system for Claude Code. Install it with:

```bash
npm install -g get-shit-done-cc
```

This adds structured slash commands for managing projects:

- `/gsd:new-project` — Initialize project with deep context gathering
- `/gsd:plan-phase` — Create detailed phase plan with verification
- `/gsd:execute-phase` — Execute plans with wave-based parallelization
- `/gsd:progress` — Check project progress and route to next action
- `/gsd:pause-work` / `/gsd:resume-work` — Context handoff between sessions
- `/gsd:debug` — Systematic debugging with persistent state
- `/gsd:help` — Show all GSD commands

### Agent SDK

Claude Code is built on the [Claude Agent SDK](https://docs.anthropic.com/en/docs/claude-code/sdk), which means you can also use it programmatically — in CI/CD pipelines, automation scripts, or custom agents. The `claude` CLI binary is the same tool under the hood.

---

## Example workflows

### Build an app from an idea

1. Create a new folder in your workspace, e.g. `Projects/meal-planner/`
2. Switch to **Plan Mode** (press **Shift+Tab** twice) — this lets Claude research and think without changing any files
3. Send something like:

> I have an idea for a meal planning app that generates grocery lists based on your dietary restrictions. Do extended market research. Check if people experience this problem, if there are already apps solving this, what users complain about, market size, etc. Then come up with a business plan.

4. Claude will research, analyze competitors, and draft a plan. Chat back and forth — ask it to go deeper on certain aspects, propose changes, refine the plan.
5. Once you're happy with the plan, approve it and Claude starts building.

### Fix a bug in an existing project

1. Copy your project folder into your workspace
2. Tell Claude:

> There's a bug where users can't log in after resetting their password. Find the issue and fix it.

Claude will read your code, trace the bug, and fix it.

### Improve an existing website

1. Copy your site folder into your workspace (WordPress, HTML, React — anything)
2. Tell Claude:

> Review this website. Check the design, performance, SEO, and accessibility. Then fix everything you find.

Claude will open your site in the browser, audit it, and make the changes.

### Analyze your business

1. Tell Claude:

> Go to www.mybusiness.com. Analyze the entire site — the product, positioning, copy, design, and customer experience. Then tell me: if you were running this business, what would be your top 5 priority actions?

Claude will browse your site, analyze everything, and come back with actionable priorities.

### Organize your life with Notion

1. Tell Claude:

> Open my Notion workspace at notion.so. Go through my pages, tasks, and notes. Analyze how I organize things, then give me specific tips on how to improve my productivity system — what to consolidate, what to automate, and what I'm overcomplicating.

Claude will browse through your Notion, understand your setup, and suggest improvements.

### Automate tasks in ClickUp

1. Tell Claude:

> Open my ClickUp workspace. Scan through my projects and tasks. Identify repetitive work, bottlenecks, and things that could be automated. Then create a plan to streamline my workflow.

Claude will analyze your project management setup and find automation opportunities.

---

<details>
<summary><strong>Troubleshooting</strong></summary>

| Problem | Fix |
|---------|-----|
| "Claude doesn't see my MCP servers" | Restart Claude Code (close and reopen the sidebar panel) |
| "Plugin install failed" | Run the install command again in the Claude chat, not the terminal. If `frontend-design` fails, try: `claude plugin marketplace add claude-code-plugins` first |
| "Claude doesn't know my preferences" | Make sure your `CLAUDE.md` is in the workspace root folder that you opened in VS Code |
| "The setup script won't run" (Windows) | Right-click the script -> Properties -> check "Unblock" -> OK, then try again |
| "Permission denied" (Mac/Linux) | Run: `chmod +x setup-mac.sh` then try again |

</details>

---

## What's inside this repo

```
claude-code-starter-guide/
├── README.md                              <- You're reading this
├── setup-windows.ps1                      <- Windows setup script
├── setup-mac.sh                           <- Mac/Linux setup script
├── templates/
|   ├── CLAUDE.md                          <- Global workspace template
|   ├── project-claude.md                  <- Per-project template
|   ├── .mcp.json                          <- MCP server config
|   ├── .env                               <- Secrets file (with placeholders)
|   ├── deploy-skill.md                    <- Deploy skill template
|   └── rules/
|       ├── infrastructure.md              <- Server/SSH/secrets template
|       └── tools.md                       <- MCP tools and browser automation
├── hooks/
|   └── pre-commit                         <- Secret scanner (blocks keys, IPs, passwords)
├── skills/
|   ├── design-principles/SKILL.md
|   ├── behavioral-psychology/SKILL.md
|   ├── marketing-copy/SKILL.md
|   └── soc2-compliance/SKILL.md
└── website/                               <- Companion website (Next.js, deployed to Vercel)
    └── src/
```

---

## License

MIT — use this however you want.
