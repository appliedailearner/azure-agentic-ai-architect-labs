param(
    [Parameter(Mandatory = $true)]
    [string]$DisplayName
)

$policyId = az policy definition list `
    --query "[?policyType=='BuiltIn' && displayName=='$DisplayName'].id | [0]" `
    --output tsv

if (-not $policyId) {
    Write-Error "Built-in policy not found: $DisplayName"
    exit 1
}

$assignment = @{
    assignmentDisplayName = "Audit $DisplayName"
    policyDefinitionId = $policyId
}

$assignment | ConvertTo-Json -Depth 5
