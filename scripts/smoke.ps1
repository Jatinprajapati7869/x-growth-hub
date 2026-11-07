#Requires -Version 5.1
# Read smoke (no cookies). Write smoke requires secrets — see docs/ACCOUNTS.md.
$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$Xa = Join-Path $RepoRoot "upstream\browser\XActions"

Write-Host "Smoke: XActions public read (@x profile)..." -ForegroundColor Cyan
Push-Location $Xa
npm run cli -- profile x
Pop-Location

$cookies = Join-Path $env:USERPROFILE ".x-growth-hub\secrets\example_account\cookies.json"
if (Test-Path $cookies) {
    Write-Host "Cookies present — use x-use / tweetly / xsh / XActions MCP for write smoke." -ForegroundColor Green
} else {
    Write-Host "Write smoke skipped: place cookies at $cookies then post via chosen MCP." -ForegroundColor Yellow
}
