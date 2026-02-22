# =============================================================================
# Claude Code Setup Script (Windows)
# =============================================================================
# This script sets up your entire Claude Code environment automatically.
# Just run it and follow the prompts.
# =============================================================================

$ErrorActionPreference = "Stop"

function Write-Step($step, $text) {
    Write-Host ""
    Write-Host "  [$step] $text" -ForegroundColor Cyan
    Write-Host "  $('-' * 60)" -ForegroundColor DarkGray
}

function Write-Success($text) {
    Write-Host "  [OK] $text" -ForegroundColor Green
}

function Write-Info($text) {
    Write-Host "  $text" -ForegroundColor Yellow
}

function Write-Waiting($text) {
    Write-Host "  $text" -ForegroundColor Magenta
}

# Helper: refresh PATH so newly installed tools are found
function Refresh-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# =============================================================================
# Welcome
# =============================================================================

Clear-Host
Write-Host ""
Write-Host "  ============================================" -ForegroundColor Cyan
Write-Host "    Claude Code Setup" -ForegroundColor Cyan
Write-Host "  ============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  This will install and set up everything you need:" -ForegroundColor White
Write-Host "    - VS Code, Node.js, Git (if not installed)" -ForegroundColor Gray
Write-Host "    - Claude Code extension" -ForegroundColor Gray
Write-Host "    - MCP servers (browser control, docs, GitHub)" -ForegroundColor Gray
Write-Host "    - Plugins (code review, TypeScript, design)" -ForegroundColor Gray
Write-Host "    - Skills (deploy, design, marketing, security)" -ForegroundColor Gray
Write-Host "    - Workspace structure" -ForegroundColor Gray
Write-Host ""

# =============================================================================
# Step 1: Install prerequisites
# =============================================================================

Write-Step "1/8" "Installing prerequisites..."

# Check for winget
$hasWinget = $null -ne (Get-Command winget -ErrorAction SilentlyContinue)

# --- Node.js ---
$nodeVersion = $null
try { $nodeVersion = node --version 2>$null } catch {}
if ($nodeVersion) {
    Write-Success "Node.js found: $nodeVersion"
} else {
    if ($hasWinget) {
        Write-Info "Installing Node.js..."
        winget install OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements --silent 2>$null
        Refresh-Path
        try { $nodeVersion = node --version 2>$null } catch {}
    }
    if ($nodeVersion) {
        Write-Success "Node.js installed: $nodeVersion"
    } else {
        Write-Info "Node.js not found. Opening download page..."
        Start-Process "https://nodejs.org/"
        Write-Host ""
        Read-Host "  Download the LTS version, install it, then press Enter to continue"
        Refresh-Path
        try { $nodeVersion = node --version 2>$null } catch {}
        if (-not $nodeVersion) {
            Write-Host "  [ERROR] Node.js still not found. Please install it and run this script again." -ForegroundColor Red
            exit 1
        }
        Write-Success "Node.js found: $nodeVersion"
    }
}

# --- Git ---
$gitVersion = $null
try { $gitVersion = git --version 2>$null } catch {}
if ($gitVersion) {
    Write-Success "Git found: $gitVersion"
} else {
    if ($hasWinget) {
        Write-Info "Installing Git..."
        winget install Git.Git --accept-source-agreements --accept-package-agreements --silent 2>$null
        Refresh-Path
        try { $gitVersion = git --version 2>$null } catch {}
    }
    if ($gitVersion) {
        Write-Success "Git installed: $gitVersion"
    } else {
        Write-Info "Git not found. Opening download page..."
        Start-Process "https://git-scm.com/downloads"
        Write-Host ""
        Read-Host "  Install with default settings, then press Enter to continue"
        Refresh-Path
        try { $gitVersion = git --version 2>$null } catch {}
        if (-not $gitVersion) {
            Write-Host "  [ERROR] Git still not found. Please install it and run this script again." -ForegroundColor Red
            exit 1
        }
        Write-Success "Git found: $gitVersion"
    }
}

# --- VS Code ---
$codePath = Get-Command code -ErrorAction SilentlyContinue
if ($codePath) {
    Write-Success "VS Code found"
} else {
    if ($hasWinget) {
        Write-Info "Installing VS Code..."
        winget install Microsoft.VisualStudioCode --accept-source-agreements --accept-package-agreements --silent 2>$null
        Refresh-Path
        $codePath = Get-Command code -ErrorAction SilentlyContinue
    }
    if ($codePath) {
        Write-Success "VS Code installed"
    } else {
        Write-Info "VS Code not found. Opening download page..."
        Start-Process "https://code.visualstudio.com/download"
        Write-Host ""
        Read-Host "  Install VS Code, then press Enter to continue"
        Refresh-Path
        $codePath = Get-Command code -ErrorAction SilentlyContinue
        if (-not $codePath) {
            Write-Info "VS Code not detected in PATH — that's OK, continuing setup"
        } else {
            Write-Success "VS Code found"
        }
    }
}

# =============================================================================
# Step 2: Install Claude Code extension
# =============================================================================

Write-Step "2/8" "Installing Claude Code extension..."

$codePath = Get-Command code -ErrorAction SilentlyContinue
if ($codePath) {
    $extensions = code --list-extensions 2>$null
    if ($extensions -match "anthropics.claude-code") {
        Write-Success "Claude Code extension already installed"
    } else {
        Write-Info "Installing Claude Code extension..."
        code --install-extension anthropics.claude-code 2>$null
        Write-Success "Claude Code extension installed"
    }
} else {
    Write-Info "VS Code CLI not in PATH — install the extension manually:"
    Write-Host "    https://marketplace.visualstudio.com/items?itemName=anthropics.claude-code" -ForegroundColor Cyan
}

# =============================================================================
# Step 3: Workspace
# =============================================================================

Write-Step "3/8" "Setting up workspace..."

$defaultWorkspace = Join-Path $env:USERPROFILE "Projects"

Write-Host ""
Write-Info "Your workspace is one folder where ALL your projects live."
Write-Info "Default: $defaultWorkspace"
Write-Host ""
$workspace = Read-Host "  Press Enter to use default, or type a different path"
if ([string]::IsNullOrWhiteSpace($workspace)) {
    $workspace = $defaultWorkspace
}

if (-not (Test-Path $workspace)) {
    New-Item -ItemType Directory -Path $workspace -Force | Out-Null
    Write-Success "Created workspace: $workspace"
} else {
    Write-Success "Workspace exists: $workspace"
}

# Create _temp folder
$tempFolder = Join-Path $workspace "_temp"
if (-not (Test-Path $tempFolder)) {
    New-Item -ItemType Directory -Path $tempFolder -Force | Out-Null
}

# Create workspace CLAUDE.md if it doesn't exist
$claudeMd = Join-Path $workspace "CLAUDE.md"
if (-not (Test-Path $claudeMd)) {
    $template = @"
# Global Instructions

## Preferences

- Always show localhost link at end of messages when a dev server is running
- Write temp files to Projects/_temp/, never project roots
- Maximize automation — do everything possible with CLI, SSH, APIs, and MCP tools before falling back to manual steps
- When manual steps are unavoidable: give dead simple instructions with numbered steps, one action per step, and direct deep links

## How I Work

- My workspace is $workspace — all projects are subfolders here
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

- **Claude Code secrets** (GitHub PAT, MCP tokens) → ``~/.claude/.env`` with env var references
- **Local dev secrets** → each project's ``.env.local``, git-ignored
- Never paste tokens in chat — use ``.env`` files
- Never commit ``.env`` files — all are in ``.gitignore``

## Learnings

<!-- Claude appends cross-project learnings here -->
"@
    Set-Content -Path $claudeMd -Value $template -Encoding UTF8
    Write-Success "Created CLAUDE.md (your global instructions file)"
} else {
    Write-Success "CLAUDE.md already exists — skipping"
}

# =============================================================================
# Step 4: GitHub token
# =============================================================================

Write-Step "4/8" "Setting up secrets..."

$claudeDir = Join-Path $env:USERPROFILE ".claude"
if (-not (Test-Path $claudeDir)) {
    New-Item -ItemType Directory -Path $claudeDir -Force | Out-Null
}

$envFile = Join-Path $claudeDir ".env"
$hasToken = $false
if (Test-Path $envFile) {
    $content = Get-Content $envFile -Raw
    if ($content -match "GITHUB_PERSONAL_ACCESS_TOKEN=.+") {
        $hasToken = $true
        Write-Success "GitHub token already configured"
    }
}

if (-not $hasToken) {
    Write-Host ""
    Write-Info "Claude Code needs a GitHub token to manage your repos."
    Write-Info "Let's create one now."
    Write-Host ""
    Write-Waiting "Opening GitHub token creation page in your browser..."
    Start-Process "https://github.com/settings/tokens?type=beta"
    Write-Host ""
    Write-Host "  In the page that just opened:" -ForegroundColor White
    Write-Host '    1. Click "Generate new token"' -ForegroundColor Gray
    Write-Host '    2. Name it: Claude Code' -ForegroundColor Gray
    Write-Host '    3. Repository access: "All repositories"' -ForegroundColor Gray
    Write-Host '    4. Permissions > Repository permissions:' -ForegroundColor Gray
    Write-Host '       - Contents: Read and write' -ForegroundColor Gray
    Write-Host '       - Issues: Read and write' -ForegroundColor Gray
    Write-Host '       - Pull requests: Read and write' -ForegroundColor Gray
    Write-Host '    5. Click "Generate token"' -ForegroundColor Gray
    Write-Host '    6. Copy the token (starts with github_pat_...)' -ForegroundColor Gray
    Write-Host ""
    $token = Read-Host "  Paste your token here (it won't be shown)"

    if ([string]::IsNullOrWhiteSpace($token)) {
        Write-Info "No token entered — skipping. You can add it later to ~/.claude/.env"
    } else {
        if (Test-Path $envFile) {
            Add-Content -Path $envFile -Value "`nGITHUB_PERSONAL_ACCESS_TOKEN=$token"
        } else {
            Set-Content -Path $envFile -Value "GITHUB_PERSONAL_ACCESS_TOKEN=$token" -Encoding UTF8
        }
        Write-Success "Token saved to ~/.claude/.env"
    }
}

# =============================================================================
# Step 5: MCP Servers
# =============================================================================

Write-Step "5/8" "Setting up MCP servers..."

$mcpFile = Join-Path $claudeDir ".mcp.json"
$mcpConfig = @'
{
  "mcpServers": {
    "browsermcp": {
      "command": "cmd",
      "args": ["/c", "npx", "@browsermcp/mcp@latest"]
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
'@

if (-not (Test-Path $mcpFile)) {
    Set-Content -Path $mcpFile -Value $mcpConfig -Encoding UTF8
    Write-Success "MCP servers configured:"
    Write-Host "    - browsermcp (browser control)" -ForegroundColor Gray
    Write-Host "    - context7 (live docs)" -ForegroundColor Gray
    Write-Host "    - github (PR/issue management)" -ForegroundColor Gray
} else {
    Write-Info ".mcp.json already exists — skipping (delete it and re-run to reset)"
}

# =============================================================================
# Step 6: Skills
# =============================================================================

Write-Step "6/8" "Installing skills..."

$skillsDir = Join-Path $claudeDir "skills"

# Find the script's directory to locate skill files
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoSkillsDir = Join-Path $scriptDir "skills"

$skills = @(
    @{ Name = "design-principles"; Desc = "Visual design rules" },
    @{ Name = "behavioral-psychology"; Desc = "Product psychology" },
    @{ Name = "marketing-copy"; Desc = "Copywriting & SEO" },
    @{ Name = "soc2-compliance"; Desc = "Security patterns" }
)

foreach ($skill in $skills) {
    $destDir = Join-Path $skillsDir $skill.Name
    $destFile = Join-Path $destDir "SKILL.md"
    $sourceFile = Join-Path $repoSkillsDir $skill.Name "SKILL.md"

    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    if (Test-Path $sourceFile) {
        Copy-Item -Path $sourceFile -Destination $destFile -Force
        Write-Success "$($skill.Name) — $($skill.Desc)"
    } else {
        Write-Info "$($skill.Name) — source not found (run from repo folder)"
    }
}

# Deploy skill template
$deployDir = Join-Path $skillsDir "deploy"
$deployFile = Join-Path $deployDir "SKILL.md"
$deploySource = Join-Path $scriptDir "templates" "deploy-skill.md"
if (-not (Test-Path $deployDir)) {
    New-Item -ItemType Directory -Path $deployDir -Force | Out-Null
}
if (-not (Test-Path $deployFile)) {
    if (Test-Path $deploySource) {
        Copy-Item -Path $deploySource -Destination $deployFile -Force
        Write-Success "deploy — Deployment workflow (customize with your projects)"
    }
} else {
    Write-Info "deploy skill already exists — skipping"
}

# =============================================================================
# Step 7: Plugins
# =============================================================================

Write-Step "7/8" "Installing plugins..."

$claudeCmd = Get-Command claude -ErrorAction SilentlyContinue
if ($claudeCmd) {
    Write-Info "Installing plugin marketplace..."
    try {
        & claude plugin marketplace add anthropics/claude-plugins-official 2>$null
        Write-Success "Official marketplace added"
    } catch {
        Write-Info "Marketplace may already be added — continuing"
    }

    $plugins = @(
        @{ Name = "typescript-lsp"; Desc = "TypeScript/JS code intelligence" },
        @{ Name = "code-review"; Desc = "Automated code review" },
        @{ Name = "frontend-design"; Desc = "UI design assistance" }
    )

    foreach ($plugin in $plugins) {
        Write-Info "Installing $($plugin.Name)..."
        try {
            & claude plugin install $plugin.Name 2>$null
            Write-Success "$($plugin.Name) — $($plugin.Desc)"
        } catch {
            Write-Info "$($plugin.Name) — install failed (you can install manually later)"
        }
    }
} else {
    Write-Info "Claude CLI not found — skipping plugin install."
    Write-Info "After signing into Claude Code, ask Claude to install them for you."
}

# =============================================================================
# Step 8: VS Code bypass mode
# =============================================================================

Write-Step "8/8" "Enabling bypass mode..."

$vscodeSettingsDir = Join-Path $env:APPDATA "Code\User"
$vscodeSettingsFile = Join-Path $vscodeSettingsDir "settings.json"

if (Test-Path $vscodeSettingsFile) {
    $settings = Get-Content $vscodeSettingsFile -Raw
    if ($settings -match "allowDangerouslySkipPermissions") {
        Write-Success "Bypass mode already configured"
    } else {
        # Insert the setting before the last closing brace
        $settings = $settings.TrimEnd()
        if ($settings.EndsWith("}")) {
            $settings = $settings.Substring(0, $settings.Length - 1).TrimEnd()
            if ($settings.EndsWith(",")) {
                $settings = $settings + "`n    `"claudeCode.allowDangerouslySkipPermissions`": true`n}"
            } else {
                $settings = $settings + ",`n    `"claudeCode.allowDangerouslySkipPermissions`": true`n}"
            }
            Set-Content -Path $vscodeSettingsFile -Value $settings -Encoding UTF8
            Write-Success "Bypass mode enabled — Claude will work without asking permission"
        } else {
            Write-Info "Could not parse settings.json — enable bypass manually in VS Code settings"
        }
    }
} else {
    # Create settings file with just this setting
    if (-not (Test-Path $vscodeSettingsDir)) {
        New-Item -ItemType Directory -Path $vscodeSettingsDir -Force | Out-Null
    }
    Set-Content -Path $vscodeSettingsFile -Value "{`n    `"claudeCode.allowDangerouslySkipPermissions`": true`n}" -Encoding UTF8
    Write-Success "Bypass mode enabled — Claude will work without asking permission"
}

# =============================================================================
# Done!
# =============================================================================

Write-Host ""
Write-Host ""
Write-Host "  ============================================" -ForegroundColor Green
Write-Host "    Setup Complete!" -ForegroundColor Green
Write-Host "  ============================================" -ForegroundColor Green
Write-Host ""
Write-Host "  What was set up:" -ForegroundColor White
Write-Host "    [OK] VS Code + Node.js + Git" -ForegroundColor Green
Write-Host "    [OK] Claude Code extension" -ForegroundColor Green
Write-Host "    [OK] Workspace at $workspace" -ForegroundColor Green
Write-Host "    [OK] CLAUDE.md (global instructions)" -ForegroundColor Green
Write-Host "    [OK] MCP servers (browser, docs, GitHub)" -ForegroundColor Green
Write-Host "    [OK] Skills (design, psychology, marketing, security, deploy)" -ForegroundColor Green
Write-Host "    [OK] Bypass mode (Claude works without asking permission)" -ForegroundColor Green
Write-Host ""
Write-Host "  Next steps:" -ForegroundColor White
Write-Host "    1. Open VS Code" -ForegroundColor Yellow
Write-Host "    2. Open your workspace folder: $workspace" -ForegroundColor Yellow
Write-Host "    3. Click the Claude icon in the sidebar and sign in" -ForegroundColor Yellow
Write-Host "    4. Start chatting!" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Try saying:" -ForegroundColor White
Write-Host '    "Help me create a new Next.js project"' -ForegroundColor Gray
Write-Host '    "Open my browser and go to google.com"' -ForegroundColor Gray
Write-Host '    "Review my code for security issues"' -ForegroundColor Gray
Write-Host ""

Read-Host "  Press Enter to exit"
