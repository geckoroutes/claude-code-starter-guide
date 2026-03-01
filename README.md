# Claude Code Starter Guide

Turn VS Code into a ChatGPT-like experience that actually writes, runs, and deploys your code.

**What you get:**
- An AI assistant inside VS Code that you just chat with
- It can control your browser, look up documentation, and manage your GitHub
- It learns your preferences and remembers mistakes so it gets better over time
- One-word deploys: just say "ship my-app" and it handles everything

---

## How it works

```
You type in Claude chat
        ↓
Claude reads your CLAUDE.md files (your preferences + project info)
        ↓
Claude uses MCP servers if needed (browser, docs, GitHub)
        ↓
Claude applies skills automatically (design, marketing, security)
        ↓
Claude writes/edits your code, runs commands, and shows results
        ↓
You just chat back and forth until it's done
```

---

## Project structure

Every project gets its own folder inside your workspace. Claude reads a `CLAUDE.md` file at each level to understand your preferences and the project.

```
Your workspace (e.g., ~/Projects/)
│
├── CLAUDE.md                ← Your global preferences (Claude reads this every session)
├── _temp/                   ← Scratch space (screenshots, logs)
│
├── my-first-app/            ← A project
│   ├── CLAUDE.md            ← This project's stack, commands, and learnings
│   └── (your code)
│
└── my-second-app/           ← Another project
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
2. Right-click `setup-windows.ps1` → **"Run with PowerShell"**
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
- Installs fresh session workflow hook (auto-launches new sessions after plans)

Nothing is sent anywhere. Everything stays on your machine.

</details>

### Step 3: Start chatting

1. Open VS Code
2. **File → Open Folder** → pick your workspace folder (the script told you where it is)
3. Open a file, then click the **Claude icon** in the top right of the editor
4. Sign in with your Claude account

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
- **browsermcp** — Claude can browse your real Chrome — preserves your logins, cookies, and extensions. Uses accessibility snapshots (token-efficient, no screenshots needed).
- **context7** — Claude gets up-to-date documentation for popular libraries (React, Next.js, Tailwind, etc.) instead of relying on training data
- **github** — Claude can create pull requests, manage issues, and review code on GitHub

**MCP priority:** BrowserMCP first (real browser, your sessions). Chrome DevTools second (debugging power, clean state).

### Plugins (Claude's tools)

- **typescript-lsp** — gives Claude IDE-like intelligence — go-to-definition, find references, real error diagnostics
- **code-review** — automated code review that checks security, performance, and readability
- **frontend-design** — helps Claude generate better UI with design system awareness
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

### Fresh session workflow (auto-pilot for plans)

When Claude does heavy research or creates a plan, your context window fills up — leaving less room for quality execution. The setup script installs a **Stop hook** that solves this automatically:

1. **You approve a plan** → Claude writes a trigger file (`execute-plan.bat` on Windows, `.sh` on Mac/Linux)
2. **Claude finishes its turn** → the Stop hook detects the trigger file
3. **A new terminal opens** → fresh `claude` CLI session with full context, reads the plan, and starts executing

**Three triggers:**
- **Plan mode** — after you approve a plan, auto-launches execution in a fresh session
- **/switch** — when context is heavy, saves progress to a handoff file and launches continuation
- **Mid-session plan** — if Claude creates a big todo list after deep exploration, it auto-detects the context load and offers to switch

The handoff files at `~/.claude/handoffs/` contain **complete verbatim context** — every file path, line number, code snippet, and finding. The new session picks up exactly where you left off, with zero information loss.

### Permission modes

The setup script enables bypass mode by default (Claude just works). If you ever want to change this:

- **Bypass (default)** — Claude does everything without asking. The closest to a ChatGPT experience.
- **Normal** — Claude asks permission before each action. Good if you want to review everything.
- **Accept Edits** — Claude auto-edits files but still asks before running commands. Press **Shift+Tab** to activate.
- **Plan Mode** — Read-only. Claude can look at your code but won't change anything. Type `/plan` to activate.

---

## Example workflows

### Build an app from an idea

1. Create a new folder in your workspace, e.g. `Projects/meal-planner/`
2. Switch to **Plan Mode** (press **Shift+Tab** twice) — this lets Claude research and think without changing any files
3. Send something like:

> I have an idea for a meal planning app that generates grocery lists based on your dietary restrictions. Do extended market research. Check if people experience this problem, if there are already apps solving this, what users complain about, market size, etc. Then come up with a business plan.

4. Claude will research, analyze competitors, and draft a plan. Chat back and forth — ask it to go deeper on certain aspects, propose changes, refine the plan.
5. Once you're happy with the plan, approve it. **A new terminal will open automatically** with a fresh Claude session that reads the plan and starts building — with full context available for quality execution.

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
| "Plugin install failed" | Run the install command again in the Claude chat, not the terminal |
| "Claude doesn't know my preferences" | Make sure your `CLAUDE.md` is in the workspace root folder that you opened in VS Code |
| "The setup script won't run" (Windows) | Right-click the script → Properties → check "Unblock" → OK, then try again |
| "Permission denied" (Mac/Linux) | Run: `chmod +x setup-mac.sh` then try again |

</details>

---

## What's inside this repo

```
claude-code-starter-guide/
├── README.md                              ← You're reading this
├── setup-windows.ps1                      ← Windows setup script
├── setup-mac.sh                           ← Mac/Linux setup script
├── templates/
│   ├── CLAUDE.md                          ← Global workspace template
│   ├── project-claude.md                  ← Per-project template
│   ├── .mcp.json                          ← MCP server config
│   ├── .env                               ← Secrets file (with placeholders)
│   ├── deploy-skill.md                    ← Deploy skill template
│   └── hooks/
│       └── auto-execute-plan.sh           ← Fresh session auto-launch hook
└── skills/
    ├── design-principles/SKILL.md
    ├── behavioral-psychology/SKILL.md
    ├── marketing-copy/SKILL.md
    └── soc2-compliance/SKILL.md
```

---

## License

MIT — use this however you want.
