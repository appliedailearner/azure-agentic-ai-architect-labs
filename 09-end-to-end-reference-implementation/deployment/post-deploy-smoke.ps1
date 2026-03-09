$ErrorActionPreference = "Stop"

param(
    [string]$Environment = "dev",
    [string]$ProjectName = "agentic-ai",
    [string]$ResourceGroupName = ""
)

if (-not $ResourceGroupName) {
    $ResourceGroupName = "rg-$ProjectName-$Environment"
}

Write-Host "Module 09 post-deploy smoke validation" -ForegroundColor Cyan
Write-Host "Environment: $Environment"
Write-Host "Resource Group: $ResourceGroupName"

$expectedResources = @(
    "aih-$ProjectName-$Environment",
    "oai-$ProjectName-$Environment",
    "search-$ProjectName-$Environment",
    "cosmos-$ProjectName-$Environment",
    "kv-$ProjectName-$Environment",
    "appins-$ProjectName-$Environment",
    "plan-$ProjectName-$Environment",
    "func-$ProjectName-$Environment",
    "apim-$ProjectName-$Environment",
    "id-agent-$ProjectName-$Environment"
)

foreach ($resourceName in $expectedResources) {
    $exists = az resource show --resource-group $ResourceGroupName --name $resourceName --query name -o tsv 2>$null
    if (-not $exists) {
        throw "Expected resource not found: $resourceName"
    }
}

$storageAccountName = ("st{0}{1}" -f $ProjectName, $Environment).Replace("-", "").ToLower()
$storageExists = az resource show --resource-group $ResourceGroupName --name $storageAccountName --resource-type "Microsoft.Storage/storageAccounts" --query name -o tsv 2>$null
if (-not $storageExists) {
    throw "Expected storage account not found: $storageAccountName"
}

$kvUri = az keyvault show --name "kv-$ProjectName-$Environment" --resource-group $ResourceGroupName --query properties.vaultUri -o tsv
if (-not $kvUri) {
    throw "Key Vault URI was not returned."
}

Write-Host "Post-deploy smoke validation passed." -ForegroundColor Green
