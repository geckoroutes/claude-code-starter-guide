# Claude Code Starter Guide

Go from zero to a fully productive Claude Code setup. This guide walks you through installing everything, configuring your workspace, and setting up the tools that make Claude Code 10x more powerful.

**What you'll have by the end:**
- VS Code with Claude Code extension
- MCP servers that let Claude control your browser, read live docs, and manage GitHub
- Plugins for code intelligence, code review, and UI design
- Skills that teach Claude reusable workflows (deploy, test, design)
- A workspace structure where Claude remembers your preferences and learns from mistakes

---

## Table of Contents

1. [Prerequisites](#1-prerequisites)
2. [Install Claude Code](#2-install-claude-code)
3. [Set Up Your Workspace](#3-set-up-your-workspace)
4. [Secrets](#4-secrets)
5. [MCP Servers](#5-mcp-servers)
6. [Plugins](#6-plugins)
7. [Skills](#7-skills)
8. [Your First Project](#8-your-first-project)
9. [Tips & Best Practices](#9-tips--best-practices)

---

## 1. Prerequisites

Install these first. Each step takes 2-3 minutes.

### 1.1 Install VS Code

1. Go to **[code.visualstudio.com/download](https://code.visualstudio.com/download)**
2. Click the download button for your OS (Windows / Mac / Linux)
3. Run the installer with default settings

### 1.2 Install Node.js

Node.js is needed to run MCP servers and many development tools.

1. Go to **[nodejs.org](https://nodejs.org/)**
2. Click the **LTS** version (not "Current")
3. Run the installer with default settings
4. Verify it works — open a terminal and run:
   ```bash
   node --version
   ```
   You should see something like `v22.x.x`

### 1.3 Install Git

Git is version control — it tracks changes to your code and lets you push to GitHub.

1. Go to **[git-scm.com/downloads](https://git-scm.com/downloads)**
2. Download for your OS
3. Run the installer — **use all default settings** (just keep clicking Next)
4. Verify it works:
   ```bash
   git --version
   ```

### 1.4 Create a GitHub Account

GitHub is where your code lives online. Skip this if you already have an account.

1. Go to **[github.com/signup](https://github.com/signup)**
2. Enter your email, create a password, pick a username
3. Verify your email

### 1.5 Generate a GitHub Personal Access Token

Claude Code uses this token to interact with GitHub on your behalf (create PRs, manage issues, etc.).

1. Go to **[github.com/settings/tokens?type=beta](https://github.com/settings/tokens?type=beta)**
   - (If you're not logged in, log in first, then click the link again)
2. Click **"Generate new token"**
3. Give it a name like `Claude Code`
4. Under **Repository access**, select **"All repositories"**
5. Under **Permissions**, expand **"Repository permissions"** and enable:
   - **Contents**: Read and write
   - **Issues**: Read and write
   - **Pull requests**: Read and write
   - **Metadata**: Read-only (auto-selected)
6. Click **"Generate token"**
7. **Copy the token** — it starts with `github_pat_...`
8. Save it somewhere safe (you'll need it in Step 4)

> **Important:** You will only see this token once. If you lose it, you'll need to generate a new one.

---

## 2. Install Claude Code

### 2.1 Get a Claude Account

Claude Code requires a paid Anthropic account.

1. Go to **[claude.ai](https://claude.ai/)**
2. Sign up or log in
3. Go to **[claude.ai/upgrade](https://claude.ai/upgrade)** and choose a plan:
   - **Pro** ($20/month) — good for getting started
   - **Max** ($100/month) — more usage, best for heavy daily use

### 2.2 Install the Claude Code Extension

1. Open VS Code
2. Go to the **[Claude Code extension page](https://marketplace.visualstudio.com/items?itemName=anthropics.claude-code)**
3. Click **"Install"** — it will open VS Code and install automatically
4. After installation, you'll see a Claude icon in the VS Code sidebar
5. Click it and **sign in** with your Claude account

---

## 3. Set Up Your Workspace

A workspace is a single folder where ALL your projects live as subfolders. Claude Code reads a `CLAUDE.md` file at the workspace root to understand your preferences.

### 3.1 Create Your Workspace Folder

Create a folder on your drive. This is where everything goes.

- **Windows:** `C:\Users\YourName\Projects`
- **Mac/Linux:** `~/Projects`

### 3.2 Open It in VS Code

1. Open VS Code
2. **File → Open Folder** → select your workspace folder (e.g., `Projects`)
3. VS Code will now show this as your working directory

### 3.3 Create Your Global CLAUDE.md

This is the most important file in your setup. Claude reads it at the start of every conversation. It tells Claude who you are, what projects you have, and how you like to work.

1. In your workspace root, create a file called `CLAUDE.md`
2. Copy the template from **[templates/CLAUDE.md](templates/CLAUDE.md)** in this repo
3. Customize it:
   - Replace `[YOUR_WORKSPACE_PATH]` with your actual path
   - Add your projects to the Active Projects table as you create them
   - Add your servers (if any) to the Servers section

**Key sections explained:**

| Section | What it does |
|---------|-------------|
| **Preferences** | How you want Claude to behave (e.g., "always show localhost links") |
| **How I Work** | Tells Claude where your workspace is and to read project CLAUDE.md files |
| **Self-Learning Rule** | Claude will append gotchas and lessons learned here automatically |
| **Active Projects** | Quick reference table of all your projects |
| **Secrets & Tokens** | Rules for where secrets go (not the actual secrets!) |
| **Learnings** | Claude appends useful discoveries here over time |

---

## 4. Secrets

Secrets (API keys, tokens) are stored in a special file that Claude Code reads automatically. This file is never committed to git.

### 4.1 Create Your Secrets File

1. Find your Claude config folder:
   - **Windows:** `C:\Users\YourName\.claude\`
   - **Mac/Linux:** `~/.claude/`
2. Create a file called `.env` in that folder
3. Add your GitHub token from Step 1.5:

```env
GITHUB_PERSONAL_ACCESS_TOKEN=github_pat_your_token_here
```

> See **[templates/.env.example](templates/.env.example)** for the format.

**Rules:**
- Never paste tokens directly in Claude chat — always use `.env` files
- Never commit `.env` files to git
- Use `${VAR_NAME}` to reference secrets in config files (like `.mcp.json`)

---

## 5. MCP Servers

**What are MCP servers?** They give Claude superpowers beyond just reading and writing code. With MCP servers, Claude can control your browser, look up live documentation, and manage your GitHub repos — all during a conversation.

### 5.1 Set Up MCP Servers

1. Find your Claude config folder:
   - **Windows:** `C:\Users\YourName\.claude\`
   - **Mac/Linux:** `~/.claude/`
2. Create a file called `.mcp.json` in that folder
3. Copy the contents from **[templates/.mcp.json](templates/.mcp.json)**

This sets up 3 MCP servers:

| Server | What it does | Example use |
|--------|-------------|-------------|
| **browsermcp** | Claude controls your Chrome browser — clicks buttons, fills forms, takes screenshots | "Check if my website looks correct" |
| **context7** | Claude gets up-to-date docs for React, Next.js, Tailwind, etc. | "How do I use the new Next.js 16 cache API?" |
| **github** | Claude creates PRs, manages issues, reviews code | "Create a PR for these changes" |

### 5.2 Restart Claude Code

After creating `.mcp.json`, restart Claude Code for the servers to load:
- Close the Claude Code panel in VS Code
- Reopen it (click the Claude icon in the sidebar)

> **Note for Mac/Linux users:** In the `.mcp.json` template, change `"command": "cmd", "args": ["/c", "npx", ...]` to `"command": "npx", "args": [...]` for browsermcp. The `cmd /c` wrapper is Windows-only.

<details>
<summary><strong>Mac/Linux version of .mcp.json</strong></summary>

```json
{
  "mcpServers": {
    "browsermcp": {
      "command": "npx",
      "args": ["@browsermcp/mcp@latest"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer ${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```

</details>

---

## 6. Plugins

**What are plugins?** They extend Claude's capabilities with specialized tools. For example, a TypeScript plugin gives Claude go-to-definition, find-references, and real diagnostics — just like your IDE.

### 6.1 Install the Official Marketplace

Open a terminal in VS Code (`` Ctrl+` ``) and run:

```bash
claude plugin marketplace add anthropics/claude-plugins-official
```

This registers the official plugin directory so you can install plugins from it.

### 6.2 Install Recommended Plugins

Run these one at a time:

```bash
claude plugin install typescript-lsp
```
> **TypeScript/JavaScript intelligence** — go-to-definition, find references, diagnostics. Essential for any JS/TS project.

```bash
claude plugin install code-review
```
> **Automated code review** — checks your code for security issues, performance problems, and readability. Multi-angle analysis.

```bash
claude plugin install frontend-design
```
> **UI generation** — design system awareness, component generation. Great for frontend work.

**Optional** (only if you work with PHP/WordPress):
```bash
claude plugin install php-lsp
```

### 6.3 Restart Claude Code

Restart Claude Code for plugins to activate.

---

## 7. Skills

**What are skills?** Skills are reusable prompt templates that teach Claude specific workflows. There are two types:

| Type | How it works | Example |
|------|-------------|---------|
| **Invokable skills** | You trigger them with `/skill-name` or trigger words | `/deploy` or "ship my-app" |
| **Domain knowledge** | Auto-loaded context Claude uses when relevant | Design principles applied when building UI |

Skills live in `~/.claude/skills/[skill-name]/SKILL.md`.

### 7.1 Create a Deploy Skill

This skill teaches Claude how to deploy your projects. You trigger it by saying things like "ship my-app" or "push to live".

1. Create the folder: `~/.claude/skills/deploy/`
2. Create `SKILL.md` inside it
3. Copy the template from **[templates/deploy-skill.md](templates/deploy-skill.md)**
4. For each project you want to deploy, add a section with:
   - Git repo and branch
   - Server IP, username, and path
   - The exact deploy command (pull, build, restart)
   - Environment variables needed

### 7.2 Install Domain Knowledge Skills

These skills are auto-loaded — Claude uses them automatically when relevant. For example, when you ask Claude to build a landing page, it will apply the design principles and marketing copy frameworks.

Copy any of these to your `~/.claude/skills/` folder:

| Skill | What Claude learns | Copy from |
|-------|-------------------|-----------|
| **design-principles** | Typography, color, spacing, accessibility, animation | [skills/design-principles/](skills/design-principles/) |
| **behavioral-psychology** | Habit formation, persuasion, cognitive biases | [skills/behavioral-psychology/](skills/behavioral-psychology/) |
| **marketing-copy** | Copywriting frameworks, SEO, landing page structure | [skills/marketing-copy/](skills/marketing-copy/) |
| **soc2-compliance** | Security patterns, audit logging, access controls | [skills/soc2-compliance/](skills/soc2-compliance/) |

To install one:
```bash
# Example: install design-principles skill
mkdir -p ~/.claude/skills/design-principles
# Copy SKILL.md from this repo's skills/design-principles/ folder
```

Or clone this entire repo and copy the `skills/` folder:
```bash
git clone https://github.com/[YOUR_GITHUB_USERNAME]/claude-code-starter-guide.git
cp -r claude-code-starter-guide/skills/* ~/.claude/skills/
```

---

## 8. Your First Project

### 8.1 Create a Project Folder

Inside your workspace, create a new folder for your project:
```
Projects/
  my-app/        <-- your new project
  CLAUDE.md      <-- global instructions (already set up)
```

### 8.2 Create a Project CLAUDE.md

Every project gets its own `CLAUDE.md` with project-specific instructions. This tells Claude the tech stack, key commands, and architecture.

1. Create `Projects/my-app/CLAUDE.md`
2. Copy the template from **[templates/project-claude.md](templates/project-claude.md)**
3. Fill in:
   - Project name and description
   - Tech stack (e.g., Next.js + React + TypeScript)
   - Key commands (dev, build, test)
   - How the project is structured

### 8.3 Add to Global CLAUDE.md

Open your workspace `CLAUDE.md` and add your project to the Active Projects table:

```markdown
| my-app | my-app/ | Next.js + React + TypeScript |
```

### 8.4 Start Building

1. Open your project folder in VS Code
2. Open Claude Code (sidebar icon)
3. Start chatting: "Help me set up a Next.js app with TypeScript and Tailwind"

Claude will:
- Read your global `CLAUDE.md` to understand your preferences
- Read the project `CLAUDE.md` to understand the tech stack
- Use MCP servers if needed (docs via context7, browser via browsermcp)
- Apply domain knowledge skills when relevant (design, copy, security)

---

## 9. Tips & Best Practices

### Self-Learning

Tell Claude to learn from mistakes. Add this to your global `CLAUDE.md`:

```markdown
## Self-Learning Rule

When something goes wrong or you discover a gotcha:
1. Add it to that project's CLAUDE.md under a "## Learnings" section
2. If it's cross-project, add to this file under Learnings below
```

Over time, Claude builds up a knowledge base of what works and what doesn't in YOUR specific setup.

### One Project = One Folder = One CLAUDE.md

Keep things organized:
```
Projects/
  CLAUDE.md           <-- global preferences
  my-saas-app/
    CLAUDE.md          <-- this project's stack, commands, learnings
  my-api/
    CLAUDE.md          <-- this project's stack, commands, learnings
  my-blog/
    CLAUDE.md          <-- this project's stack, commands, learnings
```

### Secrets Management

| Type of secret | Where it goes |
|---------------|---------------|
| GitHub PAT, MCP tokens | `~/.claude/.env` |
| Server credentials | Each project's `.env` on the server |
| Local dev secrets (API keys, DB URLs) | Each project's `.env.local` (git-ignored) |

**Never:**
- Paste tokens in chat
- Commit `.env` files to git
- Hardcode secrets in source code

### Deploy Workflow

Once you've set up the deploy skill, shipping is one command:
- "ship my-app"
- "deploy backend"
- "push my-api to live"

Claude will: check git status → bump version → create release → SSH to server → deploy → verify.

### Browser MCP for Quick Checks

During development, ask Claude to visually verify your work:
- "Open localhost:3000 and check if the homepage looks right"
- "Click the signup button and see what happens"
- "Take a screenshot of the mobile view"

---

## File Structure Reference

After setup, your file structure looks like this:

```
~/.claude/
  .env                          # Your secrets (GitHub PAT, tokens)
  .mcp.json                     # MCP server configurations
  settings.json                 # Plugin settings (auto-managed)
  skills/
    deploy/SKILL.md             # Deploy workflow
    design-principles/SKILL.md  # Visual design knowledge
    marketing-copy/SKILL.md     # Copywriting frameworks
    behavioral-psychology/SKILL.md
    soc2-compliance/SKILL.md

~/Projects/                     # Your workspace
  CLAUDE.md                     # Global instructions
  _temp/                        # Scratch space for logs, screenshots
  my-app/
    CLAUDE.md                   # Project instructions
    ...                         # Your project code
```

---

## What's Next?

Once you're comfortable with the basics:

- **Add more MCP servers** — Supabase (database), Stripe (payments), Slack (notifications)
- **Create custom skills** — any repeatable workflow can be a skill
- **Set up hooks** — auto-run commands when Claude starts or finishes (e.g., notifications)
- **Use plugins** — explore the marketplace for more tools (`claude plugin marketplace list`)

---

## Contributing

Found a bug or want to improve the guide? Open an issue or PR!

## License

MIT
