# x-growth-hub — agent instructions

Single source of truth for Cursor (and other agents) working in this repo.

## Purpose

Research X trends and publish posts for **multiple accounts** without paid X API. Default: **browser session** (cookies). Optional: **free Developer Portal** per account (`transport: api`).

## Hard rules

1. **Never** commit cookies, tokens, bearer keys, or real `accounts/*.yaml` (only `example.account.yaml` is in git).
2. **One primary write MCP per account** — `x-use` OR `tweetly` OR `XActions` browser write OR `xsh`; never double-post via two writers.
3. **Rate limits** in account yaml: respect `posts_per_day` and `min_minutes_between_posts`.
4. **No bulk engagement by default** — `growth.allow_follow` and `growth.allow_like` false unless user explicitly enables.
5. **API path:** `x-agent` writes need `X_AGENT_ALLOW_WRITE=true` and user approval in chat.
6. **ToS:** remind user that automation can risk suspension; keep volume human-like.

## Which tool when

| Task | Tool (order of preference) |
|------|----------------------------|
| Public scrape / profile | XActions HTTP client, `xactions` CLI |
| Search trends / timelines | xsh, XActions, x-use read tools |
| Draft copy | Repo `drafts/<id>/`, x-use queue, `x-agent post draft` (if API) |
| Publish (browser) | Account `browser.tool_preference` |
| Analytics (API) | x-agent (optional submodule) |

See [docs/TOOL_MATRIX.md](docs/TOOL_MATRIX.md).

## Multi-account

1. Read account id from user or `accounts/<id>.yaml` (local, gitignored).
2. Load secrets from `%USERPROFILE%\.x-growth-hub\secrets\<id>\`.
3. Pass account id to MCP tools that support it (x-use, tweetly, xsh `--account`).

## Workflow

1. **Research** — read-only MCP/CLI.
2. **Draft** — markdown in `drafts/` or tool draft queue; match `persona`.
3. **Confirm** — user says post unless they pre-authorized automation.
4. **Publish** — single chosen write path; log time for rate limit.

## Submodules

Code lives under `upstream/`. Do not merge upstream into root. Update with `scripts/submodule-update.ps1`.

## Skill

For posting flows, use `.cursor/skills/x-post/SKILL.md`.
