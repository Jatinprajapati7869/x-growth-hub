#Requires -Version 5.1
param(
    [Parameter(Mandatory = $true)]
    [string] $ProfileId,
    [ValidateSet("default", "ai-developer", "affiliate")]
    [string] $AccountType = "default",
    [string] $RealProfilePin = "",
    [string] $PersonaFile = ""
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$UserHome = $env:USERPROFILE

$hermesProfile = Join-Path $UserHome ".hermes\profiles\$ProfileId"
$chromeProfile = Join-Path $UserHome ".x-growth-hub\chrome-profiles\$ProfileId"
$repoSkill = Join-Path $RepoRoot "hermes\skills\x-post"

foreach ($p in @($hermesProfile, "$hermesProfile\skills", "$hermesProfile\skills\inbox", "$hermesProfile\workspace", "$hermesProfile\workspace\media", $chromeProfile)) {
    if (-not (Test-Path $p)) {
        New-Item -ItemType Directory -Path $p -Force | Out-Null
    }
}

$configTemplate = Join-Path $RepoRoot "hermes\profile-templates\config.yaml"
$configOut = Join-Path $hermesProfile "config.yaml"
$content = Get-Content $configTemplate -Raw
$content = $content.Replace("USER_HOME", $UserHome.Replace("\", "/"))
$content = $content.Replace("PROFILE_ID", $ProfileId)
$useReal = if ($RealProfilePin) { "true" } else { "false" }
$pin = if ($RealProfilePin) { $RealProfilePin } else { '""' }
$content = $content.Replace("USE_REAL_PROFILE", $useReal)
$content = $content.Replace("REAL_PROFILE_PIN", $pin)
$content = $content.Replace("PROVIDER", "xai")
$content = $content.Replace("MODEL_ID", "grok-4.7")

if (-not (Test-Path $configOut)) {
    Set-Content -Path $configOut -Value $content -Encoding utf8
    Write-Host "Created $configOut"
} else {
    Write-Host "Exists (skip): $configOut"
}

$soulFile = switch ($AccountType) {
    "ai-developer" { "SOUL.ai-developer.md" }
    "affiliate" { "SOUL.affiliate.md" }
    default { "SOUL.md" }
}
$soulTemplate = Join-Path $RepoRoot "hermes\profile-templates\$soulFile"
$soulOut = Join-Path $hermesProfile "SOUL.md"
if (-not (Test-Path $soulOut)) {
    $soul = Get-Content $soulTemplate -Raw
    $soul = $soul.Replace("PROFILE_ID", $ProfileId)
    if ($PersonaFile -and (Test-Path $PersonaFile)) {
        $persona = Get-Content $PersonaFile -Raw
        $soul += "`n`n## Account yaml persona`n`n$persona"
    }
    Set-Content -Path $soulOut -Value $soul -Encoding utf8
    Write-Host "Created $soulOut from $soulFile"
}

$skillDest = Join-Path $hermesProfile "skills\x-post"
if (-not (Test-Path $skillDest)) {
    try {
        New-Item -ItemType SymbolicLink -Path $skillDest -Target $repoSkill -Force | Out-Null
    } catch {
        Copy-Item -Path $repoSkill -Destination $skillDest -Recurse -Force
    }
}

@("post_log.json", "queue.json") | ForEach-Object {
    $out = Join-Path $hermesProfile "workspace\$_"
    if (-not (Test-Path $out)) {
        if ($_ -eq "queue.json") {
            Copy-Item (Join-Path $RepoRoot "hermes\workspace\queue.example.json") $out
        } else {
            Set-Content -Path $out -Value "[]" -Encoding utf8
        }
    }
}

Write-Host ""
Write-Host "Profile $ProfileId ($AccountType) ready."
Write-Host "Cron: see docs/CRON_EXAMPLES.md — attach skill x-post."
