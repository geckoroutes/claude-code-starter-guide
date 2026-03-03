# Infrastructure

## Servers

- **[server-name]**: [IP] — [what it hosts], user [username]

## SSH Keys

- **Local machine** `~/.ssh/id_ed25519` → Servers
- **Local machine** `~/.ssh/id_ed25519_github` → GitHub (via `~/.ssh/config`)
- All repos use SSH remotes (`git@github.com:[org]/...`)

## Secrets & Tokens

- **Claude Code secrets** (GitHub PAT, MCP tokens) → `~/.claude/.env` with env var references
- **Server secrets** → each project's `.env` on the server, loaded via systemd `EnvironmentFile`
- **Local dev secrets** → each project's `.env.local`, git-ignored
- Never paste tokens in chat — use `.env` files, then reference via `${VAR_NAME}`
- Never commit `.env` files — all are in `.gitignore`