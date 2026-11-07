#Requires -Version 5.1
# Prefer local Chromium — disable bundled cloud browser provider plugins when no API keys are used.

$ErrorActionPreference = "Continue"
$names = @("browser-browser-use", "browser-browserbase")
foreach ($n in $names) {
    Write-Host "Disabling plugin (if present): $n"
    & hermes plugins disable $n 2>&1
}
Write-Host "Done. Confirm with: hermes plugins list"
