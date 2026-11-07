# x-growth-hub

Monorepo for **multi-account X (Twitter) growth** with **Cursor** and MCP. Vendors open-source automation tools as **git submodules** (browser-first, optional free-tier API per account).

## Warning

- Browser and cookie-based automation may **violate X Terms of Service**. Account suspension is possible.
- This repo is **glue + docs only**. Upstream tools have their own licenses and risks.
- **Never commit** cookies, bearer tokens, or `accounts/<id>.yaml` with secrets. Use `~/.x-growth-hub/secrets/`.

## Quick start

```powershell
git clone --recurse-submodules https://github.com/Jatinprajapati7869/x-growth-hub.git
cd x-growth-hub
.\scripts\bootstrap.ps1
.\scripts\doctor.ps1
```

1. Copy `accounts/example.account.yaml` to a **local** path outside git (see [docs/ACCOUNTS.md](docs/ACCOUNTS.md)).
2. Import X session cookies into `~/.x-growth-hub/secrets/<account_id>/`.
3. Merge [config/mcp.recommended.json](config/mcp.recommended.json) into your Cursor MCP settings ([docs/MCP_CURSOR.md](docs/MCP_CURSOR.md)).
4. Open this folder in Cursor; follow [AGENTS.md](AGENTS.md).

## Layout

| Path | Purpose |
|------|---------|
| `upstream/browser/` | No official API — session/cookie automation |
| `upstream/optional-api/` | Free Developer Portal OAuth when you have keys |
| `upstream/reference/` | Small reference patterns |
| `accounts/` | Committed template only |
| `docs/` | Accounts, MCP, upstream pins, tool matrix |

## Upstream attribution

See [docs/UPSTREAM.md](docs/UPSTREAM.md) for pinned commits and links. Respect each project's `LICENSE`.

## Default stack (recommended)

- **Research / scrape:** [XActions](https://github.com/nirholas/XActions), [xsh](https://github.com/benoitpetit/xsh)
- **Reviewed publish (one primary):** [x-use](https://github.com/ihuzaifashoukat/x-use) *or* [tweetly](https://github.com/beydemirfurkan/tweetly) — do not run both as primary writers for the same account
- **Optional API analytics/draft:** [@talocode/x-agent](https://github.com/talocode/x-agent)

## Scripts

- `scripts/bootstrap.ps1` — dependency checks and optional installs
- `scripts/submodule-update.ps1` — update all submodules
- `scripts/doctor.ps1` — verify tools and repo layout
