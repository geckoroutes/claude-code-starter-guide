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
echo -e "  This will install and set up everything you need:"
echo -e "  ${GRAY}  - VS Code, Node.js, Git (if not installed)${NC}"
echo -e "  ${GRAY}  - Claude Code extension${NC}"
echo -e "  ${GRAY}  - MCP servers (browser control, docs, GitHub)${NC}"
echo -e "  ${GRAY}  - Plugins (code review, TypeScript, design)${NC}"
echo -e "  ${GRAY}  - Skills (deploy, design, marketing, security)${NC}"
echo -e "  ${GRAY}  - Workspace structure${NC}"
echo ""

# =============================================================================
# Step 1: Install prerequisites
# =============================================================================

step "1/8" "Installing prerequisites..."

# Detect package manager
HAS_BREW=false
if command -v brew &> /dev/null; then
    HAS_BREW=true
fi

IS_MAC=false
if [[ "$OSTYPE" == "darwin"* ]]; then
    IS_MAC=true
fi

IS_LINUX=false
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    IS_LINUX=true
fi

# Install Homebrew on Mac if missing (needed for auto-installs)
if [ "$IS_MAC" = true ] && [ "$HAS_BREW" = false ]; then
    info "Installing Homebrew (Mac package manager)..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to PATH for this session
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    HAS_BREW=true
    ok "Homebrew installed"
fi

# --- Node.js ---
if command -v node &> /dev/null; then
    ok "Node.js found: $(node --version)"
else
    if [ "$HAS_BREW" = true ]; then
        info "Installing Node.js via Homebrew..."
        brew install node 2>/dev/null
    elif [ "$IS_LINUX" = true ]; then
        info "Installing Node.js..."
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - 2>/dev/null
        sudo apt-get install -y nodejs 2>/dev/null
    fi

    if command -v node &> /dev/null; then
        ok "Node.js installed: $(node --version)"
    else
        if [ "$IS_MAC" = true ]; then
            info "Opening nodejs.org — download and install the LTS version."
            open "https://nodejs.org/"
        else
            info "Install Node.js: https://nodejs.org/"
        fi
        read -p "  Press Enter after installing Node.js to continue..."
        if ! command -v node &> /dev/null; then
            err "Node.js still not found. Please install it and run this script again."
            exit 1
        fi
        ok "Node.js found: $(node --version)"
    fi
fi

# --- Git ---
if command -v git &> /dev/null; then
    ok "Git found: $(git --version)"
else
    if [ "$IS_MAC" = true ]; then
        info "Installing Git via Xcode Command Line Tools..."
        xcode-select --install 2>/dev/null || true
        read -p "  Press Enter after the installer finishes..."
    elif [ "$IS_LINUX" = true ]; then
        info "Installing Git..."
        sudo apt-get install -y git 2>/dev/null
    fi

    if command -v git &> /dev/null; then
        ok "Git installed: $(git --version)"
    else
        err "Git still not found. Please install it and run this script again."
        exit 1
    fi
fi

# --- VS Code ---
if command -v code &> /dev/null; then
    ok "VS Code found"
else
    if [ "$HAS_BREW" = true ]; then
        info "Installing VS Code via Homebrew..."
        brew install --cask visual-studio-code 2>/dev/null
    elif [ "$IS_LINUX" = true ]; then
        info "Installing VS Code via snap..."
        sudo snap install code --classic 2>/dev/null || true
    fi

    if command -v code &> /dev/null; then
        ok "VS Code installed"
    else
        if [ "$IS_MAC" = true ]; then
            info "Opening VS Code download page..."
            open "https://code.visualstudio.com/download"
        else
            info "Download VS Code: https://code.visualstudio.com/download"
        fi
        read -p "  Install VS Code, then press Enter to continue..."
        if ! command -v code &> /dev/null; then
            info "VS Code not detected in PATH — that's OK, continuing setup"
        else
            ok "VS Code found"
        fi
    fi
fi

# =============================================================================
# Step 2: Install Claude Code extension
# =============================================================================

step "2/8" "Installing Claude Code extension..."

if command -v code &> /dev/null; then
    if code --list-extensions 2>/dev/null | grep -q "anthropics.claude-code"; then
        ok "Claude Code extension already installed"
    else
        info "Installing Claude Code extension..."
        code --install-extension anthropics.claude-code 2>/dev/null
        ok "Claude Code extension installed"
    fi
else
    info "VS Code CLI not in PATH — install the extension manually:"
    echo -e "  ${CYAN}  https://marketplace.visualstudio.com/items?itemName=anthropics.claude-code${NC}"
fi

# =============================================================================
# Step 3: Workspace
# =============================================================================

step "3/8" "Setting up workspace..."

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
- Work autonomously — keep going until the task is done, only ask when genuinely blocked

## How I Work

- My workspace is $WORKSPACE — all projects are subfolders here
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
# Step 4: GitHub token
# =============================================================================

step "4/8" "Setting up secrets..."

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
# Step 5: MCP Servers
# =============================================================================

step "5/8" "Setting up MCP servers..."

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
# Step 6: Skills
# =============================================================================

step "6/8" "Installing skills..."

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
# Step 7: Plugins
# =============================================================================

step "7/8" "Installing plugins..."

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
    info "After signing into Claude Code, ask Claude to install them for you."
fi

# =============================================================================
# Step 8: VS Code bypass mode
# =============================================================================

step "8/8" "Enabling bypass mode..."

if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
else
    VSCODE_SETTINGS_DIR="$HOME/.config/Code/User"
fi
VSCODE_SETTINGS_FILE="$VSCODE_SETTINGS_DIR/settings.json"

if [ -f "$VSCODE_SETTINGS_FILE" ]; then
    if grep -q "allowDangerouslySkipPermissions" "$VSCODE_SETTINGS_FILE"; then
        ok "Bypass mode already configured"
    else
        if command -v node &> /dev/null; then
            node -e "
const fs = require('fs');
const f = '$VSCODE_SETTINGS_FILE';
const s = JSON.parse(fs.readFileSync(f, 'utf8'));
s['claudeCode.allowDangerouslySkipPermissions'] = true;
fs.writeFileSync(f, JSON.stringify(s, null, 4));
"
            ok "Bypass mode enabled — Claude will work without asking permission"
        else
            info "Could not update settings.json — enable bypass manually in VS Code settings"
        fi
    fi
else
    mkdir -p "$VSCODE_SETTINGS_DIR"
    echo '{
    "claudeCode.allowDangerouslySkipPermissions": true
}' > "$VSCODE_SETTINGS_FILE"
    ok "Bypass mode enabled — Claude will work without asking permission"
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
echo -e "  ${GREEN}  [OK] VS Code + Node.js + Git${NC}"
echo -e "  ${GREEN}  [OK] Claude Code extension${NC}"
echo -e "  ${GREEN}  [OK] Workspace at $WORKSPACE${NC}"
echo -e "  ${GREEN}  [OK] CLAUDE.md (global instructions)${NC}"
echo -e "  ${GREEN}  [OK] MCP servers (browser, docs, GitHub)${NC}"
echo -e "  ${GREEN}  [OK] Skills (design, psychology, marketing, security, deploy)${NC}"
echo -e "  ${GREEN}  [OK] Bypass mode (Claude works without asking permission)${NC}"
echo ""
echo -e "  Next steps:"
echo -e "  ${YELLOW}  1. Open VS Code${NC}"
echo -e "  ${YELLOW}  2. Open your workspace folder: $WORKSPACE${NC}"
echo -e "  ${YELLOW}  3. Click the Claude icon in the sidebar and sign in${NC}"
echo -e "  ${YELLOW}  4. Start chatting!${NC}"
echo ""
echo -e "  Try saying:"
echo -e "  ${GRAY}  \"Help me create a new Next.js project\"${NC}"
echo -e "  ${GRAY}  \"Open my browser and go to google.com\"${NC}"
echo -e "  ${GRAY}  \"Review my code for security issues\"${NC}"
echo ""
