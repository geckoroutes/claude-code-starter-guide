# Claude Code Starter Guide

Turn VS Code into a ChatGPT-like experience that actually writes, runs, and deploys your code.

**What you get:**
- An AI assistant inside VS Code that you just chat with
- It can control your browser, look up documentation, and manage your GitHub
- It learns your preferences and remembers mistakes so it gets better over time
- One-word deploys: just say "ship my-app" and it handles everything

---

## How to use

**Just chat.** Type in plain English like you're talking to a coworker. No special commands needed.

> "Help me build a landing page"
> "Fix the login bug"
> "Open my browser and check if the site looks right"
> "Ship my-app"
> "Review my code for security issues"

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

### Adding a new project

1. Create a folder in your workspace: `Projects/my-new-app/`
2. Tell Claude: "Help me set up a new project here"
3. Claude will create the `CLAUDE.md` and any boilerplate for you

Or create the `CLAUDE.md` yourself using the template in [templates/project-claude.md](templates/project-claude.md).

---

## Installation

### Step 1: Install the basics

Download and install these three things. Just click the link, download, and run the installer with default settings:

| What | Download link | Why you need it |
|------|--------------|----------------|
| **VS Code** | [Download VS Code](https://code.visualstudio.com/download) | This is where you'll chat with Claude |
| **Node.js** | [Download Node.js](https://nodejs.org/) (click the **LTS** button) | Needed to run some of Claude's tools |
| **Git** | [Download Git](https://git-scm.com/downloads) | Tracks your code changes |

### Step 2: Get a GitHub account

GitHub is where your code lives online. If you already have one, skip this.

1. Go to **[github.com/signup](https://github.com/signup)**
2. Create an account with your email
3. Verify your email

### Step 3: Get Claude

1. Go to **[claude.ai](https://claude.ai/)** and create an account
2. Go to **[claude.ai/upgrade](https://claude.ai/upgrade)** and pick a plan:
   - **Pro** ($20/month) — good to start
   - **Max** ($100/month) — for heavy daily use
3. Install the Claude Code extension in VS Code: **[Click here to install](https://marketplace.visualstudio.com/items?itemName=anthropics.claude-code)**
4. In VS Code, click the **Claude icon** in the left sidebar and sign in

### Step 4: Run the setup script

This script automatically sets up everything else — your workspace, tools, plugins, and skills. It walks you through each step.

**Windows:**
1. [Download this repo](https://github.com/geckoroutes/claude-code-starter-guide/archive/refs/heads/master.zip) and unzip it
2. Right-click `setup-windows.ps1` → **"Run with PowerShell"**
3. Follow the prompts

**Mac / Linux:**
1. Open Terminal (search "Terminal" in Spotlight or your app menu)
2. Run these two lines:
   ```
   git clone https://github.com/geckoroutes/claude-code-starter-guide.git
   bash claude-code-starter-guide/setup-mac.sh
   ```
3. Follow the prompts

<details>
<summary>What does the script do?</summary>

- Checks that VS Code, Node.js, and Git are installed
- Creates your workspace folder (default: `~/Projects`)
- Creates a `CLAUDE.md` file — Claude reads this every session to know your preferences
- Asks for your GitHub token and saves it securely
- Sets up 3 MCP servers (browser control, live docs, GitHub integration)
- Installs 5 skills (deploy workflow, design principles, marketing copy, psychology, security)
- Installs 3 plugins (TypeScript intelligence, code review, UI design)
- Enables bypass mode (Claude works without asking permission)

Nothing is sent anywhere. Everything stays on your machine.

</details>

### Step 5: Start chatting

1. Open VS Code
2. **File → Open Folder** → pick your workspace folder (the script told you where it is)
3. Click the **Claude icon** in the left sidebar
4. Type something like:

> "Help me create a new website with Next.js"

That's it. You're set up.

---

## What the setup script installed

### MCP Servers (Claude's superpowers)

These let Claude interact with the outside world during your conversation:

- **browsermcp** — Claude can control your Chrome browser — click buttons, fill forms, take screenshots, navigate pages
- **context7** — Claude gets up-to-date documentation for popular libraries (React, Next.js, Tailwind, etc.) instead of relying on training data
- **github** — Claude can create pull requests, manage issues, and review code on GitHub

### Plugins (Claude's tools)

- **typescript-lsp** — gives Claude IDE-like intelligence — go-to-definition, find references, real error diagnostics
- **code-review** — automated code review that checks security, performance, and readability
- **frontend-design** — helps Claude generate better UI with design system awareness

### Skills (Claude's knowledge)

Skills are like cheat sheets that Claude reads automatically when relevant:

- **deploy** — when you say "ship my-app" or "push to live" — handles the full deployment workflow
- **design-principles** — when building any UI — applies typography, color, spacing, and accessibility rules
- **marketing-copy** — when writing landing pages or CTAs — uses proven copywriting frameworks
- **behavioral-psychology** — when designing features — applies habit formation and persuasion principles
- **soc2-compliance** — when handling user data — applies security patterns and audit logging

### Permission modes

The setup script enables bypass mode by default (Claude just works). If you ever want to change this:

- **Bypass (default)** — Claude does everything without asking. The closest to a ChatGPT experience.
- **Normal** — Claude asks permission before each action. Good if you want to review everything.
- **Accept Edits** — Claude auto-edits files but still asks before running commands. Press **Shift+Tab** to activate.
- **Plan Mode** — Read-only. Claude can look at your code but won't change anything. Type `/plan` to activate.

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| "Claude doesn't see my MCP servers" | Restart Claude Code (close and reopen the sidebar panel) |
| "Plugin install failed" | Run the install command again in the Claude chat, not the terminal |
| "Claude doesn't know my preferences" | Make sure your `CLAUDE.md` is in the workspace root folder that you opened in VS Code |
| "The setup script won't run" (Windows) | Right-click the script → Properties → check "Unblock" → OK, then try again |
| "Permission denied" (Mac/Linux) | Run: `chmod +x setup-mac.sh` then try again |

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
│   ├── .env.example                       ← Secrets file format
│   └── deploy-skill.md                    ← Deploy skill template
└── skills/
    ├── design-principles/SKILL.md
    ├── behavioral-psychology/SKILL.md
    ├── marketing-copy/SKILL.md
    └── soc2-compliance/SKILL.md
```

---

## License

MIT — use this however you want.
