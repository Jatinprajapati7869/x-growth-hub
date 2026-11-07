# x-growth-hub — agent instructions

Single source of truth for Cursor (and other agents) working in this repo.

## Purpose

Grow **multiple X accounts** with **no X API**. Primary runtime: **[Hermes Agent](https://hermes-agent.nousresearch.com/)** `browser_exec` + local Chromium per profile. Model: **Cursor Composer** via **cursor-acp** in Hermes—not a separate Claude/Codex API.

## Hard rules

1. **Never** commit cookies, tokens, or real `accounts/*.yaml`.
2. **Hermes is the default writer** — one profile per X account, one `browser.user_data_dir`.
3. **Hub MCP writers** (x-use, tweetly, XActions write) are **emergency break-glass only** — not with Hermes in the same task.
4. **No API path** — no Developer Portal, no `x-agent`, no bearer keys in `~/.hermes`.
5. **Human logs into X once** — agent must not submit passwords.
6. Rate limits in `SOUL.md` / account yaml: `posts_per_day`, `min_minutes_between_posts`.
7. **No bulk engagement** unless user explicitly enables in SOUL/limits.

## Which tool when

| Task | Tool |
|------|------|
| Research, draft, post | `hermes -p <profile>` + skill `x-post` + `browser_exec` |
| Schedule | Hermes `cronjob_manage` + profile `workspace/queue.json` |
| Learn workflows | `skill_manage` / edit `hermes/skills/x-post/SKILL.md` |
| Edit hub docs/skills | Cursor in this repo |
| DOM post failed twice | One-shot `xsh` from exported cookies ([docs/HERMES_X.md](docs/HERMES_X.md)) |
| Reference only | `upstream/` submodules |

See [docs/TOOL_MATRIX.md](docs/TOOL_MATRIX.md).

## Multi-account

1. `account id` ↔ `hermes_profile` in [accounts/example.account.yaml](accounts/example.account.yaml).
2. `.\scripts\sync-hermes-profiles.ps1 -ProfileId <id>`.
3. Chromium data: `%USERPROFILE%\.x-growth-hub\chrome-profiles\<id>\`.

## Cursor workflow

- **Do not** enable hub write MCPs by default in [config/mcp.recommended.json](config/mcp.recommended.json).
- Delegate: `hermes -p x-niche-ai -q "..."` instead of driving X from Cursor browser MCP.
- Optional: Hermes `mcp-serve` for messaging bridge only.

## Workflow

1. **Research** — `browser_exec` read-only.
2. **Draft** — profile workspace or repo `hermes/workspace` examples.
3. **Confirm** — user says post (unless cron queue).
4. **Publish** — `browser_exec` only.

## Docs

- [docs/HERMES_X.md](docs/HERMES_X.md) — install, cursor-acp, profiles
- [docs/SCHEDULING.md](docs/SCHEDULING.md) — cron + queue
- [docs/ACCOUNTS.md](docs/ACCOUNTS.md) — yaml + secrets (emergency cookies)

## Skills

- Hermes: [hermes/skills/x-post/SKILL.md](hermes/skills/x-post/SKILL.md)
- Cursor (editing hub): [.cursor/skills/x-post/SKILL.md](.cursor/skills/x-post/SKILL.md)

## Submodules

`upstream/` is vendored reference and emergency CLI source. Update: `scripts/submodule-update.ps1`.
