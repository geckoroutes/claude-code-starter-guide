---
name: deploy
description: Cross-project deployment workflow — version bumps, GitHub releases, server deploys
user-invokable: true
---

# Deploy

Unified release and deployment skill. Trigger words: **ship**, **deploy**, **publish**, **release**, **bump**, **push to live**, **push to server**, **push live**, **go live**.

Example: "ship my-app", "push my-api live", "release my-plugin v2.0", "deploy backend".

## Workflow

1. **Identify** — Match the project below (fuzzy matching — abbreviations and nicknames work)
2. **Pre-flight** — Clean git tree? Correct branch? Version bump needed?
3. **Release** — Bump version in listed files → commit `Release vX.Y.Z` → tag → **[ASK]** push → `gh release create --draft`
4. **Deploy** — **[ASK]** then SSH to server → run the deploy command
5. **Verify** — Check service status via SSH (pm2/docker/systemctl)
6. **Log** — Save to `[YOUR_WORKSPACE]/_temp/deploy-logs/{project}-{YYYY-MM-DD}.md`
7. **Learn** — Append new gotchas to this file under the project or Learnings

Skip steps that don't apply (no version file → skip bump, no server → skip deploy/verify).

## Rules

- Never force-push
- Default to draft releases — user publishes manually
- Stop on any failure, report what broke
- **[ASK]** before push and before restarting services
- Never store credentials in logs
- New project? Ask user for details, then add a section below

---

## [Your Project Name]

- **Repo:** [github-org]/[repo-name] | **Branch:** main
- **Local:** [YOUR_WORKSPACE]/[project-folder]
- **Domain:** [yourdomain.com]
- **Server:** [IP] ([server-name]) | **User:** [username] | **Path:** /home/[username]/[project-folder]
- **Service:** [pm2/systemd/docker] → [service-name] | **Port:** [port]
- **Version:** `package.json` (or "none")
- **Deploy:**
  ```bash
  cd /home/[username]/[project-folder] && git stash && git pull origin main && npm install && npm run build && pm2 restart [service-name]
  ```
- **Env vars:** `.env` — [LIST_YOUR_ENV_VARS]
- **Gotchas:**
  1. [Any quirks specific to this project]

---

## Learnings

<!-- Claude appends cross-project deployment learnings here -->

1. git stash before pull on servers — package-lock.json diverges (different OS/Node version)
2. Build is mandatory for framework projects — serves from build output (`.next/`, `dist/`)
3. Browser cache survives deploys — use `?v=N` query params on static asset URLs
4. Check disk space with `df -h` before pulling large repos
5. Deploy keys are per-repo — only one repo per key, delete from old before adding to new
