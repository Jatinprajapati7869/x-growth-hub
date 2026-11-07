# Hermes cron (posting half)

Models: **Grok / xAI** in Hermes. Browser: **real Chrome profile** per account (see profile `config.yaml`).

## One-time: two profiles

```powershell
cd x-growth-hub
.\scripts\sync-hermes-profiles.ps1 -ProfileId x-ai-dev -AccountType ai-developer -RealProfilePin "Default"
.\scripts\sync-hermes-profiles.ps1 -ProfileId x-affiliate -AccountType affiliate -RealProfilePin "Profile 2"
.\scripts\sync-skills-inbox.ps1
```

Adjust `RealProfilePin` to your Chrome profile folder names (chrome://version → Profile Path).

## Daily processor (inside Hermes)

```text
cronjob_manage create — attach skills: x-post
Prompt:
Every 60 minutes between 8:00 and 22:00 local, run one pass:
load x-post, read workspace/queue.json and post_log.json,
post next due pending item if under 10 posts today and 60m since last,
generate image via image_generate from image_prompt,
upload via browser_exec compose,
enforce affiliate max 1 monetized post per day on this profile,
skip if not logged in, never type passwords.
```

## Affiliate rule

Before posting `monetized: true`, count monetized posts in `post_log.json` for today — if ≥1, skip and set queue item `skipped`.

## Cursor automation

Research + queue suggestions only: [CURSOR_AUTOMATION_PROMPT.md](CURSOR_AUTOMATION_PROMPT.md)
