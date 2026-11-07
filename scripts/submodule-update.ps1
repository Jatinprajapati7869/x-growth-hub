#Requires -Version 5.1
$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot

Write-Host "Updating submodules (remote)..." -ForegroundColor Cyan
git submodule update --init --recursive
git submodule foreach git pull origin main 2>$null
if ($LASTEXITCODE -ne 0) {
    git submodule foreach git pull origin master 2>$null
}
Write-Host "Submodule status:"
git submodule status
Write-Host "Regenerate docs/UPSTREAM.md pins if you changed commits intentionally."
