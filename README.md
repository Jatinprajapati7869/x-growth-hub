# x-growth-hub

Multi-account **X growth** with **[Hermes Agent](https://hermes-agent.nousresearch.com/)** + **local Chromium** — **no X API**. Cursor **Composer 2.5** powers Hermes via **cursor-acp**. Vendored submodules are **emergency fallback** only.

## Warning

- Browser automation may violate **X Terms of Service**; suspension is possible.
- **Never commit** cookies, tokens, or real account yaml. Use `%USERPROFILE%\.x-growth-hub\secrets\`.

## Quick start

```powershell
git clone --recurse-submodules https://github.com/Jatinprajapati7869/x-growth-hub.git
cd x-growth-hub
npx hermes-cursor-acp
agent login
.\scripts\sync-hermes-profiles.ps1 -ProfileId my-x-account
.\scripts\hermes-doctor.ps1
```

1. Read [docs/HERMES_X.md](docs/HERMES_X.md) — login once with `browser.headed: true`.
2. `hermes -p my-x-account` — research, draft, post via `browser_exec`.
3. [docs/SCHEDULING.md](docs/SCHEDULING.md) for cron queue.

## Grok Bot vs this stack

| | Grok Bot | This stack |
|---|----------|------------|
| Browser | xAI cloud VM | Hermes **local Chromium** |
| LLM | Grok | **Composer via cursor-acp** |
| X API | For private data | **Not used** |
| Multi-account | Shared cloud | **Hermes profile + user_data_dir** |
| Learn | Vault | **Hermes skills** + `hermes/skills/x-post` |

## Layout

| Path | Purpose |
|------|---------|
| `hermes/skills/` | Skills synced into `~/.hermes/profiles/*/skills/` |
| `hermes/profile-templates/` | New profile scaffolding |
| `docs/HERMES_X.md` | Primary runbook |
| `upstream/` | Vendored tools (break-glass / reference) |

## Scripts

| Script | Role |
|--------|------|
| `scripts/sync-hermes-profiles.ps1` | Create Hermes profile + Chrome data dir |
| `scripts/hermes-doctor.ps1` | Stack + forbidden env check |
| `scripts/verify-hermes-stack.ps1` | Repo acceptance checklist |
| `scripts/doctor.ps1` | Submodule / legacy layout |
| `scripts/bootstrap.ps1` | Dirs + optional npm in XActions |

## Default stack

- **Post / research:** Hermes `browser_exec` + skill `x-post`
- **Schedule:** Hermes `cronjob_manage`
- **Emergency:** `xsh` with exported cookies — see [docs/TOOL_MATRIX.md](docs/TOOL_MATRIX.md)
