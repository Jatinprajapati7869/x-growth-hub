# Multi-account setup

## Directory layout (local only)

```
%USERPROFILE%\.x-growth-hub\
  accounts\
    niche_ai_1.yaml          # copy from repo example; not in git
  secrets\
    niche_ai_1\
      cookies.json           # Cookie Editor export or Playwright storage
      storageState.json      # optional Playwright format
    niche_ai_2\
      ...
  x-use-home\                # x-use data dir (set X_USE_HOME)
```

Repo template: [accounts/example.account.yaml](../accounts/example.account.yaml).

## Cookie export

1. Log into X in a normal browser (one account per profile).
2. Export cookies for `x.com` via Cookie Editor or DevTools (`auth_token`, `ct0`).
3. Save JSON under `secrets\<account_id>\cookies.json`.
4. **Never** commit this file.

### Playwright storage state (alternative)

```powershell
npx playwright codegen x.com --save-storage="$env:USERPROFILE\.x-growth-hub\secrets\<id>\storageState.json"
```

## Per-tool import

| Tool | Command / action |
|------|------------------|
| **xsh** | `xsh auth import secrets\<id>\cookies.json --account <id>` |
| **x-use** | Wizard or `add_account` MCP with cookie file path |
| **tweetly** | Follow submodule README `connect_x_account` flow |
| **XActions** | Puppeteer path needs logged-in browser; see XActions docs |
| **frigatebird** | `AUTH_TOKEN` + `CT0` env or cookie flags |

## Optional API account

Set `transport: api` and store keys in `secrets\<id>\.env` (gitignored):

```
X_BEARER_TOKEN=...
# or x-agent OAuth profile per x-agent docs
```

## Adding a second account

1. Duplicate yaml with new `id`.
2. New folder under `secrets\<new_id>\`.
3. Separate `X_USE_HOME` subfolder or tweetly account profile.
4. Run `.\scripts\doctor.ps1 -AccountId <new_id>`.
