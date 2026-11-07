# Hermes + X (no API)

Primary stack for **multi-account X growth**: [Hermes Agent](https://hermes-agent.nousresearch.com/) **`browser_exec`** on **local Chromium**, model via **cursor-acp** (Cursor Composer). No X Developer Portal, no bearer tokens, no hub MCP writers by default.

## Allowed tools

| Tool | Use |
|------|-----|
| `browser_exec` | Post, search (logged-in), scrape timelines via UI |
| `browser_vault` | 2FA / saved logins without secrets in chat |
| `cronjob_manage` | Scheduled queue processing |
| `skill_view` / `skill_manage` | Learn posting workflows (`x-post`) |
| `web_fetch` / `web_search` | Off-X research only |

## Forbidden (this project)

- `X_*` / `TWITTER_*` API keys in `~/.hermes` or profile `.env`
- `BROWSER_USE_API_KEY`, `BROWSERBASE_*`, Nous cloud browser as default
- Hermes `x_search` (needs xAI) — use browser on x.com instead
- Hub MCP write path (x-use + tweetly + XActions) alongside Hermes posts

## Install checklist

```powershell
hermes --version
hermes doctor
agent login
hermes plugins install cursor-acp
hermes plugins enable cursor-acp
```

If `npx hermes-cursor-acp` is blocked by Hermes security scan, install from the catalog entry above or approve via `hermes plugins install <url> --force` after reviewing the plugin source ([marketplace](https://hermes-agent.nousresearch.com/marketplace/cursor-acp)).

Base `~/.hermes/config.yaml` (before per-account profiles):

```yaml
browser:
  backend: ""
  headed: false
  user_data_dir: ""
  inactivity_timeout: 600

model:
  provider: cursor-acp
  default: composer-2.5
```

Verify model id inside Hermes: `/model` and pick the Composer entry from cursor-acp.

Enable toolsets: `hermes tools` → **terminal**, **browser**, **skills**, **cronjob**.

Disable cloud browser plugins (no API keys):

```powershell
.\scripts\disable-hermes-cloud-browsers.ps1
```

## One Hermes profile per X account

```powershell
.\scripts\sync-hermes-profiles.ps1 -ProfileId x-niche-ai
```

Creates:

- `%USERPROFILE%\.hermes\profiles\x-niche-ai\` — config, SOUL, skills symlink
- `%USERPROFILE%\.x-growth-hub\chrome-profiles\x-niche-ai\` — persistent Chromium data

### Human login (once)

1. Set `browser.headed: true` in that profile's `config.yaml`.
2. `hermes -p x-niche-ai`
3. You log into x.com (SSO/CAPTCHA). Agent must **not** type your password.
4. Confirm `https://x.com/home`.
5. Set `headed: false`.

Optional emergency cookies: `%USERPROFILE%\.x-growth-hub\secrets\<id>\cookies.json` for `xsh` only.

## Daily use

```powershell
hermes -p x-niche-ai
```

Ask: research trends → draft → wait for your "post now" → `browser_exec` compose.

Non-interactive:

```powershell
hermes -p x-niche-ai -q "Load skill x-post; check queue; if due item and logged in, post"
```

## cursor-acp

Hermes runs tools; **Composer 2.5** (Cursor subscription) reasons. No separate Claude/Codex API. See [cursor-acp marketplace](https://hermes-agent.nousresearch.com/marketplace/cursor-acp).

## Cursor IDE

- Edit skills in this repo under `hermes/skills/`.
- Run Hermes in terminal; avoid enabling three hub write MCPs in Cursor for the same account.
- Optional: `hermes plugins install mcp-serve` for messaging bridge only ([MCP docs](https://hermes-agent.nousresearch.com/docs/user-guide/features/mcp)).

## Verification

```powershell
.\scripts\hermes-doctor.ps1
.\scripts\verify-hermes-stack.ps1
```

## References

- [Browser automation](https://hermes-agent.nousresearch.com/docs/user-guide/features/browser)
- [Profiles](https://hermes-agent.nousresearch.com/docs/user-guide/profiles)
- [Tools reference](https://hermes-agent.nousresearch.com/docs/reference/tools-reference)
