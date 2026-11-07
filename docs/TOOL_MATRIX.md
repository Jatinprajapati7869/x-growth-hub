# Tool matrix

When to use which vendored tool. All paths are under `upstream/` unless installed globally (`xsh`, `@talocode/x-agent`).

## Browser path (default)

| Tool | Best for | Avoid |
|------|----------|-------|
| **XActions** | Scraping, CLI batch ops, MCP breadth | Same account as tweetly/x-use writer |
| **x-use** | Multi-account, drafts, reviewed publish, inbox | Heavy scrape-only jobs (use XActions client) |
| **tweetly** | Queued writes, monitors, Cursor HTTP MCP | Parallel writer with x-use |
| **xsh** | Fast CLI, search, cookie auth from browser, MCP | Users who only want GUI MCP |
| **frigatebird** | Shell workflows (`bird`-style), cookie env vars | Deep MCP integration (use x-use/tweetly) |
| **playwright-twitter-automation** | Learning cookie + Playwright patterns | Production orchestration |

## Optional API path

| Tool | Best for |
|------|----------|
| **x-agent** | OAuth analytics, Phoenix scoring, API drafts |
| **twitter-agent** | Reference for scheduled API agents |
| **zanaX** | LangGraph + Telegram approval flows |
| **ai-twitter-bot** | RSS/news → tweet via tweepy (free API tier) |

## Research vs write

- **Read-only first:** XActions `client`, xsh search, x-use profile/search.
- **Write once:** check `browser.tool_preference` in account yaml.
