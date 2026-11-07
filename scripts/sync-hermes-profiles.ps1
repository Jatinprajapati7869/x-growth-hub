#Requires -Version 5.1
param(
    [Parameter(Mandatory = $true)]
    [string] $ProfileId,
    [string] $PersonaFile = ""
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$UserHome = $env:USERPROFILE

$hermesProfile = Join-Path $UserHome ".hermes\profiles\$ProfileId"
$chromeProfile = Join-Path $UserHome ".x-growth-hub\chrome-profiles\$ProfileId"
$repoSkill = Join-Path $RepoRoot "hermes\skills\x-post"

foreach ($p in @($hermesProfile, "$hermesProfile\skills", "$hermesProfile\workspace", $chromeProfile)) {
    if (-not (Test-Path $p)) {
        New-Item -ItemType Directory -Path $p -Force | Out-Null
    }
}

$templateConfig = Join-Path $RepoRoot "hermes\profile-templates\config.yaml"
$configOut = Join-Path $hermesProfile "config.yaml"
$content = Get-Content $templateConfig -Raw
$content = $content.Replace("USER_HOME", $UserHome.Replace("\", "/"))
$content = $content.Replace("PROFILE_ID", $ProfileId)
if (-not (Test-Path $configOut)) {
    Set-Content -Path $configOut -Value $content -Encoding utf8
    Write-Host "Created $configOut"
} else {
    Write-Host "Exists (skip): $configOut"
}

$soulTemplate = Join-Path $RepoRoot "hermes\profile-templates\SOUL.md"
$soulOut = Join-Path $hermesProfile "SOUL.md"
if (-not (Test-Path $soulOut)) {
    $soul = Get-Content $soulTemplate -Raw
    $soul = $soul.Replace("PROFILE_ID", $ProfileId)
    if ($PersonaFile -and (Test-Path $PersonaFile)) {
        $persona = Get-Content $PersonaFile -Raw
        $soul = $soul -replace "(?s)Replace this block.*\n\nVoice:.*", "Replace this block when syncing a profile from accounts/*.yaml.`n`n$persona"
    }
    Set-Content -Path $soulOut -Value $soul -Encoding utf8
    Write-Host "Created $soulOut"
}

$skillDest = Join-Path $hermesProfile "skills\x-post"
if (-not (Test-Path $skillDest)) {
    try {
        New-Item -ItemType SymbolicLink -Path $skillDest -Target $repoSkill -Force | Out-Null
        Write-Host "Linked skill $skillDest -> $repoSkill"
    } catch {
        Copy-Item -Path $repoSkill -Destination $skillDest -Recurse -Force
        Write-Host "Copied skill to $skillDest (symlink unavailable)"
    }
}

$queueExample = Join-Path $RepoRoot "hermes\workspace\queue.example.json"
$queueOut = Join-Path $hermesProfile "workspace\queue.json"
if (-not (Test-Path $queueOut)) {
    Copy-Item $queueExample $queueOut
    Write-Host "Created empty queue at $queueOut"
}

Write-Host ""
Write-Host "Next:"
Write-Host "  1. Set browser.headed: true in $configOut"
Write-Host "  2. hermes -p $ProfileId"
Write-Host "  3. Log into X manually, then set headed: false"
