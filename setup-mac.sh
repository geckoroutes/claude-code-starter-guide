#!/bin/bash
# =============================================================================
# Claude Code Setup Script (Mac / Linux)
# =============================================================================
# This script sets up your entire Claude Code environment automatically.
# Just run it and follow the prompts.
# =============================================================================

set -e

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
GRAY='\033[0;37m'
RED='\033[0;31m'
NC='\033[0m' # No Color

step() { echo -e "\n  ${CYAN}[$1] $2${NC}\n  $(printf '%.0s-' {1..60})" ; }
ok() { echo -e "  ${GREEN}[OK] $1${NC}" ; }
info() { echo -e "  ${YELLOW}$1${NC}" ; }
err() { echo -e "  ${RED}[ERROR] $1${NC}" ; }

# =============================================================================
# Welcome
# =============================================================================

clear
echo ""
echo -e "  ${CYAN}============================================${NC}"
echo -e "  ${CYAN}  Claude Code Setup${NC}"
echo -e "  ${CYAN}============================================${NC}"
echo ""
echo -e "  This will set up your Claude Code environment:"
echo -e "  ${GRAY}  - MCP servers (browser control, docs, GitHub)${NC}"
echo -e "  ${GRAY}  - Plugins (code review, TypeScript, design)${NC}"
echo -e "  ${GRAY}  - Skills (deploy, design, marketing, security)${NC}"
echo -e "  ${GRAY}  - Workspace structure${NC}"
echo ""

# =============================================================================
# Step 1: Check prerequisites
# =============================================================================

step "1/6" "Checking prerequisites..."

# Check Node.js
if command -v node &> /dev/null; then
    ok "Node.js found: $(node --version)"
else
    info "Node.js not found."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        info "Opening nodejs.org — download and install the LTS version."
        open "https://nodejs.org/"
    else
        info "Install Node.js: https://nodejs.org/"
        info "Or run: curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs"
    fi
    read -p "  Press Enter after installing Node.js to continue..."
    if ! command -v node &> /dev/null; then
        err "Node.js still not found. Please install it and run this script again."
        exit 1
    fi
    ok "Node.js found: $(node --version)"
fi

# Check Git
if command -v git &> /dev/null; then
    ok "Git found: $(git --version)"
else
    info "Git not found."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        info "Installing via Xcode Command Line Tools..."
        xcode-select --install 2>/dev/null || true
        read -p "  Press Enter after the installer finishes..."
    else
        info "Install Git: sudo apt-get install git"
    fi
    if ! command -v git &> /dev/null; then
        err "Git still not found. Please install it and run this script again."
        exit 1
    fi
    ok "Git found: $(git --version)"
fi

# =============================================================================
# Step 2: Workspace
# =============================================================================

step "2/6" "Setting up workspace..."

DEFAULT_WORKSPACE="$HOME/Projects"

echo ""
info "Your workspace is one folder where ALL your projects live."
info "Default: $DEFAULT_WORKSPACE"
echo ""
read -p "  Press Enter to use default, or type a different path: " WORKSPACE
WORKSPACE="${WORKSPACE:-$DEFAULT_WORKSPACE}"

mkdir -p "$WORKSPACE"
mkdir -p "$WORKSPACE/_temp"
ok "Workspace: $WORKSPACE"

# Create CLAUDE.md
CLAUDE_MD="$WORKSPACE/CLAUDE.md"
if [ ! -f "$CLAUDE_MD" ]; then
    cat > "$CLAUDE_MD" << HEREDOC
# Global Instructions

## Preferences

- Always show localhost link at end of messages when a dev server is running
- Write temp files to Projects/_temp/, never project roots
- Maximize automation — do everything possible with CLI, SSH, APIs, and MCP tools before falling back to manual steps
- When manual steps are unavoidable: give dead simple instructions with numbered steps, one action per step, and direct deep links

## How I Work

- My workspace is $WORKSPACE — all projects are subfolders here
- When I mention a project, read its CLAUDE.md first
- Always scope file searches to the relevant project subfolder

## Self-Learning Rule

When something goes wrong or you discover a gotcha:

1. Add it to that project's CLAUDE.md under a "## Learnings" section
2. If it's cross-project, add to this file under Learnings below

## Active Projects

| Project | Path | Stack |
| --- | --- | --- |

## Secrets & Tokens

- **Claude Code secrets** (GitHub PAT, MCP tokens) → \`~/.claude/.env\` with env var references
- **Local dev secrets** → each project's \`.env.local\`, git-ignored
- Never paste tokens in chat — use \`.env\` files
- Never commit \`.env\` files — all are in \`.gitignore\`

## Learnings

<!-- Claude appends cross-project learnings here -->
HEREDOC
    ok "Created CLAUDE.md (your global instructions file)"
else
    ok "CLAUDE.md already exists — skipping"
fi

# =============================================================================
# Step 3: GitHub token
# =============================================================================

step "3/6" "Setting up secrets..."

CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR"

ENV_FILE="$CLAUDE_DIR/.env"
HAS_TOKEN=false
if [ -f "$ENV_FILE" ] && grep -q "GITHUB_PERSONAL_ACCESS_TOKEN=." "$ENV_FILE" 2>/dev/null; then
    HAS_TOKEN=true
    ok "GitHub token already configured"
fi

if [ "$HAS_TOKEN" = false ]; then
    echo ""
    info "Claude Code needs a GitHub token to manage your repos."
    echo ""
    if [[ "$OSTYPE" == "darwin"* ]]; then
        open "https://github.com/settings/tokens?type=beta"
    else
        info "Open this URL: https://github.com/settings/tokens?type=beta"
    fi
    echo ""
    echo -e "  In the page that just opened:"
    echo -e "  ${GRAY}  1. Click \"Generate new token\"${NC}"
    echo -e "  ${GRAY}  2. Name it: Claude Code${NC}"
    echo -e "  ${GRAY}  3. Repository access: \"All repositories\"${NC}"
    echo -e "  ${GRAY}  4. Permissions > Repository permissions:${NC}"
    echo -e "  ${GRAY}     - Contents: Read and write${NC}"
    echo -e "  ${GRAY}     - Issues: Read and write${NC}"
    echo -e "  ${GRAY}     - Pull requests: Read and write${NC}"
    echo -e "  ${GRAY}  5. Click \"Generate token\"${NC}"
    echo -e "  ${GRAY}  6. Copy the token (starts with github_pat_...)${NC}"
    echo ""
    read -p "  Paste your token here: " TOKEN

    if [ -z "$TOKEN" ]; then
        info "No token entered — skipping. You can add it later to ~/.claude/.env"
    else
        echo "GITHUB_PERSONAL_ACCESS_TOKEN=$TOKEN" >> "$ENV_FILE"
        ok "Token saved to ~/.claude/.env"
    fi
fi

# =============================================================================
# Step 4: MCP Servers
# =============================================================================

step "4/6" "Setting up MCP servers..."

MCP_FILE="$CLAUDE_DIR/.mcp.json"
if [ ! -f "$MCP_FILE" ]; then
    cat > "$MCP_FILE" << 'HEREDOC'
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
HEREDOC
    ok "MCP servers configured:"
    echo -e "  ${GRAY}  - browsermcp (browser control)${NC}"
    echo -e "  ${GRAY}  - context7 (live docs)${NC}"
    echo -e "  ${GRAY}  - github (PR/issue management)${NC}"
else
    info ".mcp.json already exists — skipping"
fi

# =============================================================================
# Step 5: Skills
# =============================================================================

step "5/6" "Installing skills..."

SKILLS_DIR="$CLAUDE_DIR/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_SKILLS="$SCRIPT_DIR/skills"

for SKILL_NAME in design-principles behavioral-psychology marketing-copy soc2-compliance; do
    DEST="$SKILLS_DIR/$SKILL_NAME"
    mkdir -p "$DEST"
    if [ -f "$REPO_SKILLS/$SKILL_NAME/SKILL.md" ]; then
        cp "$REPO_SKILLS/$SKILL_NAME/SKILL.md" "$DEST/SKILL.md"
        ok "$SKILL_NAME"
    else
        info "$SKILL_NAME — source not found (run from repo folder)"
    fi
done

# Deploy skill
DEPLOY_DIR="$SKILLS_DIR/deploy"
mkdir -p "$DEPLOY_DIR"
if [ ! -f "$DEPLOY_DIR/SKILL.md" ]; then
    if [ -f "$SCRIPT_DIR/templates/deploy-skill.md" ]; then
        cp "$SCRIPT_DIR/templates/deploy-skill.md" "$DEPLOY_DIR/SKILL.md"
        ok "deploy — Deployment workflow"
    fi
else
    info "deploy skill already exists — skipping"
fi

# =============================================================================
# Step 6: Plugins
# =============================================================================

step "6/6" "Installing plugins..."

if command -v claude &> /dev/null; then
    info "Installing plugin marketplace..."
    claude plugin marketplace add anthropics/claude-plugins-official 2>/dev/null || true
    ok "Official marketplace added"

    for PLUGIN in typescript-lsp code-review frontend-design; do
        info "Installing $PLUGIN..."
        claude plugin install "$PLUGIN" 2>/dev/null && ok "$PLUGIN" || info "$PLUGIN — install failed (try manually later)"
    done
else
    info "Claude CLI not found — skipping plugin install."
    info "After installing Claude Code, paste these in the chat:"
    echo ""
    echo -e "  ${GRAY}  claude plugin marketplace add anthropics/claude-plugins-official${NC}"
    echo -e "  ${GRAY}  claude plugin install typescript-lsp${NC}"
    echo -e "  ${GRAY}  claude plugin install code-review${NC}"
    echo -e "  ${GRAY}  claude plugin install frontend-design${NC}"
fi

# =============================================================================
# Done!
# =============================================================================

echo ""
echo ""
echo -e "  ${GREEN}============================================${NC}"
echo -e "  ${GREEN}  Setup Complete!${NC}"
echo -e "  ${GREEN}============================================${NC}"
echo ""
echo -e "  What was set up:"
echo -e "  ${GREEN}  [OK] Workspace at $WORKSPACE${NC}"
echo -e "  ${GREEN}  [OK] CLAUDE.md (global instructions)${NC}"
echo -e "  ${GREEN}  [OK] MCP servers (browser, docs, GitHub)${NC}"
echo -e "  ${GREEN}  [OK] Skills (design, psychology, marketing, security, deploy)${NC}"
echo ""
echo -e "  Next steps:"
echo -e "  ${YELLOW}  1. Open VS Code${NC}"
echo -e "  ${YELLOW}  2. Install the Claude Code extension:${NC}"
echo -e "  ${CYAN}     https://marketplace.visualstudio.com/items?itemName=anthropics.claude-code${NC}"
echo -e "  ${YELLOW}  3. Open your workspace folder: $WORKSPACE${NC}"
echo -e "  ${YELLOW}  4. Click the Claude icon in the sidebar and sign in${NC}"
echo -e "  ${YELLOW}  5. Start chatting!${NC}"
echo ""
echo -e "  Try saying:"
echo -e "  ${GRAY}  \"Help me create a new Next.js project\"${NC}"
echo -e "  ${GRAY}  \"Open my browser and go to google.com\"${NC}"
echo -e "  ${GRAY}  \"Review my code for security issues\"${NC}"
echo ""
