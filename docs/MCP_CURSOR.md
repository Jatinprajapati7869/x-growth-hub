# Cursor MCP setup

Merge snippets from [config/mcp.recommended.json](../config/mcp.recommended.json) into your user or project MCP config. Adjust absolute paths for your machine.

## Prerequisites

Run `.\scripts\bootstrap.ps1` once. Initialize submodules:

```powershell
git submodule update --init --recursive
```

## Recommended minimal set

1. **x-actions** — research/scrape (large tool surface).
2. **x-use** *or* **tweetly** — primary publisher (pick one).
3. **x-agent** (optional) — only if account uses `transport: api`.

## XActions

From repo root:

```json
"x-actions": {
  "command": "npm",
  "args": ["run", "mcp"],
  "cwd": "C:\\path\\to\\x-growth-hub\\upstream\\browser\\XActions"
}
```

First time: `cd upstream/browser/XActions && npm install`.

## x-use (pip package)

```json
"x-use": {
  "command": "python",
  "args": ["-m", "x_use_mcp"],
  "env": {
    "X_USE_HOME": "C:\\Users\\YOU\\.x-growth-hub\\x-use-home"
  }
}
```

Install: `python -m pip install x-use-mcp` then `python -m patchright install chromium`.

## tweetly (submodule)

Follow `upstream/browser/tweetly/README.md` for HTTP MCP URL and env. Typical pattern uses a local server started by `npm run dev` or documented MCP transport — point Cursor at that command after `npm install` in the submodule.

## xsh (release binary)

Install `xsh` from [releases](https://github.com/benoitpetit/xsh/releases), then:

```json
"xsh": {
  "command": "xsh",
  "args": ["mcp"]
}
```

Run `xsh auth login --account <id>` per account.

## x-agent (optional)

```json
"x-agent": {
  "command": "x-agent",
  "args": ["mcp"]
}
```

Install: `npm install -g @talocode/x-agent`. Auth per [x-agent README](https://github.com/talocode/x-agent).

## Safety

- Disable write tools in MCP config until cookies are valid and user wants posting.
- Use separate `X_USE_HOME` or tweetly account profiles per X account.
