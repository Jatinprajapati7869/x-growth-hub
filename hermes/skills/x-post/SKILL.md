---
name: x-post
description: Queue, Grok image, and publish X posts via browser_exec. Affiliate rules, rate limits, safety. No X API.
---

# x-post (Hermes)

## Load order

1. Profile `SOUL.md` limits
2. This skill
3. Optional `skills/inbox/*/SKILL.md` for hooks/copy (engagement only — no hate/harassment)

## Queue schema

`workspace/queue.json` items:

| Field | Required | Notes |
|-------|----------|-------|
| `text` | yes | Post body |
| `image_prompt` | yes when `require_image` | For Grok/xAI `image_generate` |
| `monetized` | no | Default false; affiliate profile max 1/day true |
| `scheduled_at` | yes | ISO local time |
| `status` | yes | pending / posted / skipped |

## Cron flow

1. Count posts today from `workspace/post_log.json` (create if missing).
2. Stop if at `posts_per_day_max`. Enforce `min_minutes_between_posts` since last post.
3. For affiliate profile: if `monetized` and already posted monetized today → skip.
4. Verify login: `new_tab("https://x.com/home")`, `page_info()` — not login wall.
5. **Image:** call Hermes `image_generate` with `image_prompt`; save path under workspace `media/`.
6. **Compose:** `browser_exec` open compose, attach image file, type `text`, post.
7. Append post_log; update queue item `status` and `posted_at`.

## Image policy

- Generate new images with Grok/xAI — do not download others' post media as reposts.
- `reference_note` is topic inspiration only.

## Engagement tone

Hooks and contrarian takes allowed. Block: hate, harassment, slurs, targeted abuse, false claims.

## Research (read-only)

```python
new_tab("https://x.com/search?q=QUERY&src=typed_query&f=live")
wait_for_load()
print(page_info())
```

## Emergency

After two compose failures, stop; do not spam retries. Optional `xsh` break-glass per AGENTS.md.
