---
name: x-post
description: Delegate X growth to Hermes browser_exec. Use when user asks to post on X or run the growth workflow.
---

# x-post (Cursor hub)

Hub repo does **not** post via Cursor MCP by default.

## Do

1. Read [AGENTS.md](../../AGENTS.md) and [docs/HERMES_X.md](../../docs/HERMES_X.md).
2. Map account → `hermes_profile` in local account yaml.
3. Propose or run: `hermes -p <profile> -q "..."` with skill `x-post`.
4. Edit [hermes/skills/x-post/SKILL.md](../../hermes/skills/x-post/SKILL.md) when selectors change.

## Do not

- Enable hub x-use/tweetly/XActions write MCP in same workflow as Hermes post.
- Add X API keys or Developer Portal steps.
- Type the user's X password in browser automation.

## New account

```powershell
.\scripts\sync-hermes-profiles.ps1 -ProfileId <id>
```
