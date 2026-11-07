---
name: x-post
description: Research, draft, queue, and publish X posts via Hermes browser_exec only. No X API. Use for x-growth-hub accounts.
---

# x-post (Hermes)

## Preconditions

- Hermes profile matches one X account (`hermes -p <profile>`).
- `browser.user_data_dir` is unique for this profile.
- Load limits from profile `SOUL.md`.

## Research (read-only)

Use `browser_exec` only. Do not click Post, Like, Follow, or Reply unless posting phase is active.

```python
new_tab("https://x.com/search?q=QUERY&src=typed_query&f=live")
wait_for_load()
print(page_info())
```

## Draft

Write text to `$BH_AGENT_WORKSPACE/drafts/YYYY-MM-DD-slug.md` with persona from SOUL.md.

## Queue (scheduled)

Read `workspace/queue.json` in the profile home:

```json
[
  {
    "id": "uuid",
    "text": "tweet body",
    "scheduled_at": "2026-03-07T09:00:00",
    "status": "pending"
  }
]
```

If `scheduled_at` <= now and status is `pending`, verify logged in on home before posting. On success set `status` to `posted` and `posted_at`.

## Publish (interactive)

Human must say "post now" or approve a draft unless `cronjob_manage` triggered you.

Compose flow (selectors may change — use `page_info`, accessibility, or `js`):

1. `new_tab("https://x.com/compose/post")` or open compose from home.
2. `wait_for_load()`
3. Fill compose area via `fill_input`, `js`, or `click_at_xy` as DOM requires.
4. Click Post; verify timeline or toast.
5. Log timestamp for rate limits.

## Learn

When a selector breaks and a human fixes it, use `skill_manage` to append a short "last known good steps" section to this skill.

## Emergency

If `browser_exec` cannot post after two retries, human may run `xsh post_tweet` with cookies exported from this profile's user_data_dir — never both paths in one task.
