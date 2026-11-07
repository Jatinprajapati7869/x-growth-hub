# Multi-account setup (Hermes)

## Mapping

| Field | Location |
|-------|----------|
| `id` | Logical account name |
| `hermes_profile` | Same id → `~/.hermes/profiles/<id>/` |
| Chrome data | `%USERPROFILE%\.x-growth-hub\chrome-profiles\<id>\` |
| Emergency cookies | `%USERPROFILE%\.x-growth-hub\secrets\<id>\cookies.json` |

Template: [accounts/example.account.yaml](../accounts/example.account.yaml).

## Create profile

```powershell
.\scripts\sync-hermes-profiles.ps1 -ProfileId niche_ai_1
```

Copy account yaml to `%USERPROFILE%\.x-growth-hub\accounts\niche_ai_1.yaml`.

## Login (once per account)

See [HERMES_X.md](HERMES_X.md): `browser.headed: true` → human logs in → `headed: false`.

Hermes persists session via `browser.user_data_dir` — **not** via X API.

## Emergency cookies (xsh only)

If you need break-glass CLI:

1. Export cookies after logged-in Chrome session.
2. Save to `secrets\<id>\cookies.json`.
3. `xsh auth import ... --account <id>` — never use with Hermes write in same cron tick.

## Second account

```powershell
.\scripts\sync-hermes-profiles.ps1 -ProfileId niche_ai_2
```

Separate `user_data_dir` — never share Chromium profile between accounts.

## Verify

```powershell
.\scripts\hermes-doctor.ps1
.\scripts\verify-hermes-stack.ps1
```
