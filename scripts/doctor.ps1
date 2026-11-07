#Requires -Version 5.1
param(
    [string] $AccountId = "example_account"
)

$ErrorActionPreference = "Continue"
$RepoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot

$ok = 0
$warn = 0

function Report-Ok($msg) { Write-Host "[ok] $msg" -ForegroundColor Green; $script:ok++ }
function Report-Warn($msg) { Write-Host "[warn] $msg" -ForegroundColor Yellow; $script:warn++ }
function Report-Fail($msg) { Write-Host "[fail] $msg" -ForegroundColor Red; $script:warn++ }

Write-Host "x-growth-hub doctor" -ForegroundColor Cyan
Write-Host "Account check id: $AccountId"

if (Test-Path (Join-Path $RepoRoot "scripts\hermes-doctor.ps1")) {
    & (Join-Path $RepoRoot "scripts\hermes-doctor.ps1")
}

@(
    "README.md",
    "AGENTS.md",
    "accounts\example.account.yaml",
    ".gitmodules"
) | ForEach-Object {
    $p = Join-Path $RepoRoot $_
    if (Test-Path $p) { Report-Ok $_ } else { Report-Warn "missing $_" }
}

$subRoots = @(
    "upstream\browser\XActions",
    "upstream\browser\x-use",
    "upstream\browser\tweetly",
    "upstream\browser\xsh",
    "upstream\browser\frigatebird",
    "upstream\browser\playwright-twitter-automation",
    "upstream\optional-api\x-agent",
    "upstream\optional-api\zanaX",
    "upstream\optional-api\twitter-agent",
    "upstream\optional-api\ai-twitter-bot",
    "upstream\reference\twitter-setup"
)
foreach ($rel in $subRoots) {
    $p = Join-Path $RepoRoot $rel
    if (Test-Path (Join-Path $p ".git")) { Report-Ok "submodule $rel" }
    elseif (Test-Path $p) { Report-Warn "$rel exists but may not be submodule" }
    else { Report-Warn "submodule missing $rel" }
}

$secretsDir = Join-Path $env:USERPROFILE ".x-growth-hub\secrets\$AccountId"
$cookies = Join-Path $secretsDir "cookies.json"
if (Test-Path $cookies) {
    Report-Ok "cookies for $AccountId"
} else {
    Report-Warn "no cookies at $cookies (expected before live post)"
}

if (Get-Command xsh -ErrorAction SilentlyContinue) {
    Report-Ok "xsh on PATH"
    # Read-only smoke when authenticated
    $who = & xsh auth whoami 2>&1
    if ($LASTEXITCODE -eq 0) { Report-Ok "xsh whoami: $who" }
    else { Report-Warn "xsh not authenticated — xsh auth login --account $AccountId" }
} else {
    Report-Warn "xsh not installed (optional CLI/MCP)"
}

$xa = Join-Path $RepoRoot "upstream\browser\XActions"
if (Test-Path (Join-Path $xa "node_modules")) {
    Report-Ok "XActions node_modules present"
    if (Test-Path (Join-Path $xa "package.json")) {
        $pkg = Get-Content (Join-Path $xa "package.json") -Raw | ConvertFrom-Json
        if ($pkg.scripts.mcp) { Report-Ok "XActions mcp script defined (read/write via MCP)" }
    }
} elseif (Test-Path $xa) {
    Report-Warn "run bootstrap or npm install in XActions"
}

try {
    $py = & python -c "import importlib.util; print('yes' if importlib.util.find_spec('x_use_mcp') else 'no')" 2>&1
    if ($py -eq "yes") { Report-Ok "x-use-mcp python package" }
    else { Report-Warn "pip install x-use-mcp for x-use MCP" }
} catch {
    Report-Warn "python check failed"
}

Write-Host ""
Write-Host "Summary: $ok ok, $warn warnings"
if ($warn -eq 0) { exit 0 } else { exit 0 }
