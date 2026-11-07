#Requires -Version 5.1
$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot

Write-Host "x-growth-hub bootstrap" -ForegroundColor Cyan
Write-Host "Repo: $RepoRoot"

$secretsRoot = Join-Path $env:USERPROFILE ".x-growth-hub"
foreach ($sub in @("secrets", "accounts", "x-use-home")) {
    $p = Join-Path $secretsRoot $sub
    if (-not (Test-Path $p)) {
        New-Item -ItemType Directory -Path $p -Force | Out-Null
        Write-Host "Created $p"
    }
}

function Test-Cmd($name) {
    if (Get-Command $name -ErrorAction SilentlyContinue) {
        Write-Host "[ok] $name"
        return $true
    }
    Write-Host "[--] $name not found"
    return $false
}

Test-Cmd git | Out-Null
Test-Cmd node | Out-Null
Test-Cmd npm | Out-Null
Test-Cmd python | Out-Null
Test-Cmd gh | Out-Null

if (Test-Path (Join-Path $RepoRoot "upstream\browser\XActions\package.json")) {
    Write-Host "Installing XActions dependencies..."
    Push-Location (Join-Path $RepoRoot "upstream\browser\XActions")
    npm install --no-audit --no-fund 2>&1 | Out-Host
    Pop-Location
} else {
    Write-Host "Submodule XActions missing — run: git submodule update --init --recursive"
}

Write-Host ""
Write-Host "Optional global tools:"
Write-Host "  pip install x-use-mcp && python -m patchright install chromium"
Write-Host "  npm install -g @talocode/x-agent"
Write-Host "  xsh — download from https://github.com/benoitpetit/xsh/releases"
Write-Host ""
Write-Host ""
Write-Host "Hermes stack (primary):"
Write-Host "  npx hermes-cursor-acp && agent login"
Write-Host "  .\scripts\sync-hermes-profiles.ps1 -ProfileId <account>"
Write-Host "  See docs/HERMES_X.md"
Write-Host ""
Write-Host "Done. Next: .\scripts\hermes-doctor.ps1"
