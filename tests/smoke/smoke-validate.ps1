$ErrorActionPreference = "Stop"

Write-Host "Repo smoke validation" -ForegroundColor Cyan

$repoRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path))

$requiredFiles = @(
    "README.md",
    "MODULE-STATUS.md",
    "SECURITY.md",
    "THREAT-MODEL.md",
    "GOVERNANCE.md",
    "OPERATIONS.md",
    "RUNBOOKS.md",
    "FINOPS.md",
    "OBSERVABILITY.md",
    "CHANGELOG.md",
    "RELEASE-CHECKLIST.md",
    "MODULE-PROMOTION-CHECKLIST.md",
    "docs\rbac-matrix.md",
    "policy\README.md",
    "policy\azure-policy\README.md",
    "tests\smoke\README.md"
)

foreach ($file in $requiredFiles) {
    $fullPath = Join-Path $repoRoot $file
    if (-not (Test-Path $fullPath)) {
        throw "Missing required repo artifact: $file"
    }
}

Push-Location $repoRoot
try {
    .\05-rag-with-azure-ai-search\validate.ps1
    .\08-observability-and-evaluation\validate.ps1
    .\09-end-to-end-reference-implementation\validate.ps1
}
finally {
    Pop-Location
}

Write-Host "Repo smoke validation passed." -ForegroundColor Green
