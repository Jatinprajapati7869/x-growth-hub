#Requires -Version 5.1
$ErrorActionPreference = "Continue"
$RepoRoot = Split-Path -Parent $PSScriptRoot

function Report($level, $msg) {
    $color = switch ($level) { "ok" { "Green" } "warn" { "Yellow" } default { "Red" } }
    Write-Host "[$level] $msg" -ForegroundColor $color
}

Write-Host "Hermes stack doctor" -ForegroundColor Cyan

if (Get-Command hermes -ErrorAction SilentlyContinue) {
    Report "ok" "hermes on PATH"
    $ver = & hermes --version 2>&1 | Select-Object -First 1
    Report "ok" $ver
} else {
    Report "fail" "hermes not installed — see docs/HERMES_X.md"
}

$hermesHome = Join-Path $env:USERPROFILE ".hermes"
$envFile = Join-Path $hermesHome ".env"
$forbidden = @(
    "BROWSER_USE_API_KEY",
    "BROWSERBASE_API_KEY",
    "BROWSERBASE_PROJECT_ID",
    "XAI_API_KEY",
    "TWITTER_BEARER_TOKEN",
    "X_BEARER_TOKEN"
)
if (Test-Path $envFile) {
    foreach ($key in $forbidden) {
        if (Select-String -Path $envFile -Pattern "^\s*$key\s*=" -Quiet) {
            Report "warn" "Remove $key from ~/.hermes/.env for no-API stack"
        }
    }
} else {
    Report "ok" "no ~/.hermes/.env (or empty)"
}

if (Test-Path (Join-Path $RepoRoot "docs\HERMES_X.md")) { Report "ok" "docs/HERMES_X.md" }
if (Test-Path (Join-Path $RepoRoot "hermes\skills\x-post\SKILL.md")) { Report "ok" "hermes x-post skill" }

if (Get-Command agent -ErrorAction SilentlyContinue) {
    Report "ok" "Cursor agent CLI (for cursor-acp)"
} else {
    Report "warn" "agent CLI missing — run agent login for cursor-acp"
}

$profilesRoot = Join-Path $hermesHome "profiles"
if (Test-Path $profilesRoot) {
    $count = (Get-ChildItem $profilesRoot -Directory -ErrorAction SilentlyContinue | Measure-Object).Count
    Report "ok" "Hermes profiles dir ($count profiles)"
} else {
    Report "warn" "No profiles yet — run sync-hermes-profiles.ps1 -ProfileId <id>"
}

Write-Host ""
Write-Host "Run: hermes doctor"
