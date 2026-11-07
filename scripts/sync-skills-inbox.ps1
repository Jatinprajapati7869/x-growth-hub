#Requires -Version 5.1
# Shallow-clone allowlisted repos; copy SKILL.md trees into hermes/skills/inbox/

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$allowlist = Join-Path $RepoRoot "config\skills-allowlist.yaml"
$inboxRoot = Join-Path $RepoRoot "hermes\skills\inbox"

if (-not (Test-Path $inboxRoot)) {
    New-Item -ItemType Directory -Path $inboxRoot -Force | Out-Null
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "git required"
}

$lines = Get-Content $allowlist -Raw
$urls = [regex]::Matches($lines, 'url:\s*(https://[^\s]+)') | ForEach-Object { $_.Groups[1].Value }

foreach ($url in $urls) {
    $name = ($url -replace 'https://github.com/|\.git$','' -replace '/','__')
    $dest = Join-Path $inboxRoot $name
    if (Test-Path (Join-Path $dest ".git")) {
        Write-Host "Update $name"
        git -C $dest pull --depth 1 2>$null
    } else {
        Write-Host "Clone $url -> $dest"
        git clone --depth 1 $url $dest
    }
    Get-ChildItem -Path $dest -Recurse -Filter "SKILL.md" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Host "  found $($_.FullName.Replace($dest,''))"
    }
}

Write-Host "Done. Hermes profiles should symlink or copy from hermes/skills/inbox into profile skills/inbox."
