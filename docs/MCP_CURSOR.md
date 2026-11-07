# Cursor MCP (Hermes-first)

**Default:** run X automation in **Hermes terminal**, not Cursor MCP browsers.

## Recommended

1. Install [cursor-acp](https://hermes-agent.nousresearch.com/marketplace/cursor-acp) for Composer inside Hermes.
2. Optional messaging only — [config/mcp.recommended.json](../config/mcp.recommended.json) `hermes-messaging` after `hermes plugins install mcp-serve`.

```json
"hermes-messaging": {
  "command": "hermes",
  "args": ["mcp-serve"]
}
```

Use for notify/wait on channels — **not** for driving `browser_exec`.

## Do not enable by default

The `_emergency_do_not_enable_with_hermes_writes` block in `mcp.recommended.json` (x-use, x-actions, xsh MCP) causes double-writer risk with Hermes.

## Cursor chat pattern

Composer in this repo should **edit skills** and suggest:

```powershell
hermes -p <profile> -q "Load x-post; …"
```

## Legacy doc

For vendored submodule MCP setup (emergency only), see upstream READMEs under `upstream/browser/`.
