# GitHub Actions Azure Setup

This document completes the remaining external setup for the `azure-deployment-validation` workflow.

## Purpose

The workflow at [`.github/workflows/azure-deployment-validation.yml`](/c:/MyResumePortfolio/azure-agentic-ai-architect-labs-publish/.github/workflows/azure-deployment-validation.yml) validates the module 09 Bicep deployment against a real Azure subscription.

It only runs when the required GitHub Actions secrets exist.

## Required GitHub Secrets

Add these repository secrets in GitHub:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
- `AZURE_PRINCIPAL_ID`

## Recommended Azure Access Model

Use a dedicated non-production service principal or workload identity for GitHub Actions.

Minimum recommended scope:

- subscription or resource-group scope for non-production validation
- ability to create or validate resource-group deployments
- ability to read policy definitions used by module 09

Recommended Azure roles:

- `Contributor` on the non-production resource group used for validation
- `Resource Policy Contributor` if policy assignment validation is included
- `User Access Administrator` only if role assignment validation is intentionally added to CI

Do not use production credentials for this workflow.

## GitHub Setup Steps

1. Open the repository settings.
2. Go to `Settings` > `Secrets and variables` > `Actions`.
3. Add the four required secrets.
4. Open the `Actions` tab.
5. Run the `Azure Deployment Validation` workflow manually.

## Expected Validation Path

The workflow will:

1. authenticate to Azure
2. create or update a non-production validation resource group
3. run `az deployment group validate`
4. validate the module 09 Bicep template with the `dev` parameter file

## Common Failure Modes

### Authentication failure

Cause:
- incorrect client, tenant, or subscription values
- service principal not granted Azure access

Fix:
- verify the service principal exists
- verify the secret values
- verify Azure role assignment scope

### Authorization failure

Cause:
- service principal lacks deployment or policy permissions

Fix:
- ensure `Contributor` is assigned to the validation resource group
- add `Resource Policy Contributor` if policy assignment validation is enabled

### Invalid policy definition ID

Cause:
- `policyAssignments` references a policy definition that does not exist in the target scope

Fix:
- use a valid built-in or custom policy definition ID
- confirm the definition is available in the subscription

### Parameter drift

Cause:
- the Bicep template changes but environment parameter files are not updated

Fix:
- keep `dev/test/prod` parameter files aligned with `main.bicep`
- rerun local smoke validation before pushing

## Recommended Next Step After Setup

After the workflow passes:

1. wire one real development policy assignment into `dev.parameters.json`
2. verify the validation still passes
3. use that result as part of `v0.2.0-alpha` release readiness

Recommended first built-in:

- `Azure Key Vault should disable public network access`

Suggested command:

```powershell
.\09-end-to-end-reference-implementation\infra\environments\resolve-built-in-policy.ps1 `
  -DisplayName "Azure Key Vault should disable public network access"
```

Then place the returned `policyDefinitionId` into:

- `09-end-to-end-reference-implementation/infra/environments/dev.parameters.json`
