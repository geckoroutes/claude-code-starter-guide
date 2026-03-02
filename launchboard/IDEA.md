# Launchboard (working name)

A self-serve ecosystem that guides non-technical entrepreneurs from "I have a business idea" to a running business with a live product, marketing engine, and analytics dashboard — all powered by Claude Code.

## The Vision

Combine three existing projects into one guided journey:

- **claude-code-starter-guide** (setup scripts + website) — gets people started with Claude Code
- **showcases** (bespoke website generation) — builds professional sites from a plain-English description
- **dashboard** (founder cockpit) — tracks business health with goals, tasks, and metrics

## How It Works

### User Journey

```
Website (learn) -> Setup (install Claude Code) -> Phase 1: Build -> Phase 2: Market -> Phase 3: Track
```

### Phase 1 — Build
User describes their business idea in plain English. Claude researches the market, generates an instant preview (index.html), iterates on design, adds pages, and deploys to Vercel. Reuses the showcases workflow.

### Phase 2 — Market
Claude generates a marketing plan, writes blog posts, drafts social media content. User reviews and approves everything before publishing. Claude drafts, human decides.

### Phase 3 — Track
Claude sets up a personal dashboard customized for the business (name, metrics, colors, departments). Deploys to user's own Vercel account. User checks business health anytime.

## Architecture (Approach C: Guide Website + Template Ecosystem)

| Piece | What it is |
|-------|-----------|
| Guide Website | Expanded starter guide website showing all 3 phases |
| Launch Skill | Claude Code skill (`/launch`) that guides users through phases |
| Dashboard Template | Generic, config-driven version of the dashboard project |
| Setup Scripts | Existing scripts + launch skill installation |

- No platform, no auth, no backend complexity on the website
- Each user's dashboard is private (their own Vercel deploy)
- State tracked locally in `~/Projects/launchboard.json`
- Free to start, monetization boundary between Phase 1 and Phase 2/3

## Key Decisions

- **Audience**: Self-serve, anyone can use it (not just personal network)
- **Dashboard**: Private per user, deployed to their own Vercel (free tier)
- **Automation level**: Claude generates, user approves (not fully automated)
- **Output type**: Whatever the user describes (website, app, tool — open-ended)
- **Database**: Dashboard needs Turso (@libsql/client) instead of SQLite for Vercel serverless

## MVP Scope

1. Create `/launch` skill with Phase 1 workflow (build + deploy a website)
2. Update setup scripts to install the launch skill
3. Expand the guide website to show all 3 phases
4. Deploy updated website

## Post-MVP

- Dashboard template (Phase 3)
- Marketing workflow (Phase 2)
- Multi-venture tracking

## Full Plan

See the detailed implementation plan for file lists, architecture details, and verification steps.
