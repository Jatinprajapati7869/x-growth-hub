# Scheduling (Hermes-first)

| Job type | Engine |
|----------|--------|
| Interactive research + post | `hermes -p <profile>` + cursor-acp |
| Fire post at fixed time | `cronjob_manage` + skill `x-post` + `browser_exec` |
| Improve compose flow | `skill_manage` on `x-post` |
| DOM broke overnight | One-shot `xsh` with exported cookies |

## Queue file

Per profile (not in git):

`%USERPROFILE%\.hermes\profiles\<profile_id>\workspace\queue.json`

Copy from [hermes/workspace/queue.example.json](../hermes/workspace/queue.example.json).

## Create a cron job (inside Hermes)

1. `hermes -p x-niche-ai`
2. Ask agent to use `cronjob_manage` with `action=create`, attach skill `x-post`.
3. Prompt example: "Every day at 09:00 local, load queue.json, post due items if logged into X, else report."

Cron sessions have **no chat context** — queue and SOUL must be self-contained.

## Logged-out behavior

Job must:

1. Open `https://x.com/home`
2. Detect login wall via `page_info` / URL
3. Set queue item to `skipped` with reason `not_logged_in`
4. **Never** attempt password entry

## Cursor Automations (optional)

Use only for notifications ("queue empty", "post failed"), not as primary poster. Primary remains Hermes `cronjob_manage`.

See also [CRON_EXAMPLES.md](CRON_EXAMPLES.md).

## Dry run

```powershell
hermes -p x-niche-ai -q "Skill x-post: list queue; if any due, validate login only and report — do not post"
```
