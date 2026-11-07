#Requires -Version 5.1
$ErrorActionPreference = "Continue"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$failed = 0

function Check($cond, $msg) {
    if ($cond) { Write-Host "[ok] $msg" -ForegroundColor Green }
    else { Write-Host "[fail] $msg" -ForegroundColor Red; $script:failed++ }
}

Write-Host "verify-hermes-stack" -ForegroundColor Cyan

Check (Test-Path (Join-Path $RepoRoot "AGENTS.md")) "AGENTS.md"
Check (Test-Path (Join-Path $RepoRoot "docs\HERMES_X.md")) "HERMES_X.md"
Check (Test-Path (Join-Path $RepoRoot "docs\SCHEDULING.md")) "SCHEDULING.md"
Check (Test-Path (Join-Path $RepoRoot "hermes\skills\x-post\SKILL.md")) "x-post skill"

$agents = Get-Content (Join-Path $RepoRoot "AGENTS.md") -Raw
Check ($agents -match "Hermes") "AGENTS.md Hermes-first"

$matrix = Get-Content (Join-Path $RepoRoot "docs\TOOL_MATRIX.md") -Raw
Check ($matrix -match "browser_exec") "TOOL_MATRIX mentions browser_exec"

$example = Get-Content (Join-Path $RepoRoot "accounts\example.account.yaml") -Raw
Check ($example -notmatch "transport:\s*api") "example account not API transport"
Check ($example -match "hermes_profile") "example account maps hermes_profile"

$mcp = Get-Content (Join-Path $RepoRoot "config\mcp.recommended.json") -Raw
Check ($mcp -match "emergency") "mcp.recommended marks emergency MCP"

if (Get-Command hermes -ErrorAction SilentlyContinue) {
    Check $true "hermes installed"
} else {
    Check $false "hermes installed"
}

exit $(if ($failed -eq 0) { 0 } else { 1 })
