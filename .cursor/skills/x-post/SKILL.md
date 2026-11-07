---
name: x-post
description: Research, draft, and publish X posts for a configured account via x-growth-hub MCP/CLI. Use when the user asks to post on X, grow an account, or run the growth workflow.
---

# x-post skill

## Before acting

1. Read [AGENTS.md](../../AGENTS.md) and the user's account id.
2. Load local account yaml (gitignored) and secrets under `%USERPROFILE%\.x-growth-hub\secrets\<id>\`.
3. Pick **read** tools first; **write** only after user approval unless they said "auto-post".

## Research

- Trends/search: `xsh` or XActions MCP read tools or x-use profile/search.
- Save notes to `drafts/<account_id>/YYYY-MM-DD-topic.md` in the repo (gitignored drafts folder is ok locally).

## Draft

- Match `persona` from account yaml.
- Check character limit; thread if needed via xsh `compose_thread` or tweetly `post_thread`.

## Publish

- Use **only** `browser.tool_preference` for that account.
- Enforce `limits.posts_per_day` and `min_minutes_between_posts`.
- If `transport: api`, use x-agent with `X_AGENT_ALLOW_WRITE=true` after user confirms.

## After post

- Note timestamp in draft file footer for rate-limit tracking.
