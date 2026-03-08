$ErrorActionPreference = "Stop"

Write-Host "Module 07 validation" -ForegroundColor Cyan

$moduleRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$requiredFiles = @(
    "README.md",
    "requirements.txt",
    "app\main.py",
    "tests\test_main.py",
    "infra\main.bicep",
    "deployment\deploy.sh"
)

foreach ($file in $requiredFiles) {
    $fullPath = Join-Path $moduleRoot $file
    if (-not (Test-Path $fullPath)) {
        throw "Missing required file: $file"
    }
}

$env:PYTHONPATH = $moduleRoot
Push-Location $moduleRoot
try {
    python -m pytest .\tests -q
    if ($LASTEXITCODE -ne 0) {
        throw "Module 07 tests failed."
    }
}
finally {
    Pop-Location
}

Write-Host "Module 07 runnable baseline is healthy." -ForegroundColor Green
