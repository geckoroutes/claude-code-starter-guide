# Tools & Plugins

## MCP Tools Available

- **chrome-devtools**: AI-driven debugging — network, console, performance traces (fresh browser, no auth state)
- **browsermcp**: AI-driven browsing on your real Chrome — preserves logins, cookies, extensions (accessibility snapshots)
- **context7**: Up-to-date library docs (Next.js, React, Tailwind, etc.)
- **github**: PR management, issues, code review via GitHub MCP

## Browser Automation Tools

| Tool | Installed | Purpose |
|------|-----------|---------|
| **Chrome DevTools MCP** | `~/.claude/.mcp.json` | AI-driven debugging: network, console, performance traces. Launches fresh browser (no auth state) |
| **BrowserMCP** | `@playwright/mcp` | AI-driven browsing on your real Chrome: preserves logins, cookies, extensions. Accessibility snapshots (token-efficient) |

**MCP tool priority (during conversation):**
1. **BrowserMCP first** — for anything that needs your real browser: checking authenticated pages, verifying UI on sites you're logged into, quick spot-checks. Uses your actual Chrome with all your sessions intact.
2. **Chrome DevTools MCP second** — when you need debugging power: inspecting network requests, reading console errors, running performance traces, or testing in a clean browser state. Launches a fresh isolated instance.