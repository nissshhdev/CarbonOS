# CarbonOS ISO Builder for Windows (PowerShell)
# This script orchestrates building the ISO via Docker Desktop or WSL2

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "          CarbonOS ISO Build Assistant for Windows        " -ForegroundColor White
Write-Host "        IBM Carbon Design System Arch Linux Distro       " -ForegroundColor Blue
Write-Host "==========================================================" -ForegroundColor Cyan

$outputDir = Join-Path $PSScriptRoot "output"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# Check if Docker is available
$dockerInstalled = Get-Command docker -ErrorAction SilentlyContinue

if ($dockerInstalled) {
    Write-Host "[*] Docker detected. Building CarbonOS ISO container..." -ForegroundColor Green
    docker compose build
    Write-Host "[*] Launching build container with privileged mode (creating ISO)..." -ForegroundColor Green
    docker compose run --rm carbonos-builder
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "[✓] Build complete! Check the 'output' folder for your CarbonOS ISO." -ForegroundColor Green
} else {
    Write-Host "[!] Docker was not found on your system." -ForegroundColor Yellow
    Write-Host "[*] Alternative: If you have WSL2 (Arch/Ubuntu), you can build by running:" -ForegroundColor White
    Write-Host "    wsl sudo ./build.sh" -ForegroundColor Cyan
    Write-Host "[*] Or push this repository to GitHub to trigger the automated GitHub Actions ISO builder." -ForegroundColor White
}
