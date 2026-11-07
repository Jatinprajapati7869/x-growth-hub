# Tool matrix

## Tier 0 — Default (Hermes, no API)

| Tool | Best for | Notes |
|------|----------|-------|
| **Hermes `browser_exec`** | Research, compose, post on x.com | One profile + `user_data_dir` per account |
| **Hermes `cronjob_manage`** | Scheduled queue posts | Skill `x-post` |
| **Hermes `skill_manage`** | Learn selector fixes | Updates `x-post` |
| **cursor-acp** | Composer 2.5 in Hermes | No separate LLM API bill |

## Tier C — Break glass (hub vendored)

Use **only** when `browser_exec` fails twice; **never** same task as Hermes write.

| Tool | Best for |
|------|----------|
| **xsh** | Cookie CLI post from exported profile cookies |
| **x-use** / **tweetly** | Legacy MCP (do not enable in Cursor by default) |
| **XActions** | Scrape/public HTTP without login |

## Tier R — Reference (do not use for default posting)

| Path | Purpose |
|------|---------|
| `upstream/optional-api/*` | API bots — out of scope |
| `upstream/reference/twitter-setup` | Playwright cookie patterns |

## Research vs write

- **Read:** `browser_exec` on search/explore while logged in.
- **Write:** Hermes only; emergency → single `xsh` command.
