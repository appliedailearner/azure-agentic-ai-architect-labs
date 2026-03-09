# Deployment Guide

This guide documents the **current** deployment baseline for module 09. It replaces the older Terraform-centric guidance with the Bicep path that actually exists in the repo.

## Current Support Boundary

This deployment path is suitable for:

- validating the current infrastructure baseline
- learning the intended Azure service shape
- proving a dev, test, or prod parameter overlay exists in source control

It is **not yet** a full production landing zone.

## Prerequisites

- Azure CLI
- Bash shell for `deploy.sh`
- Python 3.10+ for local validation
- permissions to create resources in the target subscription

## Environment Overlays

Module 09 now includes explicit parameter files:

- `infra/environments/dev.parameters.json`
- `infra/environments/test.parameters.json`
- `infra/environments/prod.parameters.json`

These files control environment-specific values such as:

- `environment`
- `searchSku`
- `cosmosdbThroughput`

## Validate Locally First

From the repo root:

```powershell
$env:PYTHONPATH = (Resolve-Path .\09-end-to-end-reference-implementation).Path
python -m pytest .\09-end-to-end-reference-implementation\app\tests -q
.\09-end-to-end-reference-implementation\validate.ps1
```

## Validate Bicep

```bash
cd 09-end-to-end-reference-implementation/deployment
VALIDATE_ONLY=true ./deploy.sh dev eastus
VALIDATE_ONLY=true ./deploy.sh test eastus
```

The script uses the matching parameter file when it exists.

## Deploy

```bash
cd 09-end-to-end-reference-implementation/deployment
./deploy.sh dev eastus
```

Or:

```bash
./deploy.sh test eastus
./deploy.sh prod eastus
```

## Current Deployment Notes

- `principalId` is still supplied at deploy time for Key Vault access
- the Bicep currently uses public network access for several services
- private networking, policy controls, and full non-prod/prod gates remain follow-on work

## Expected Outputs

The deployment currently emits:

- OpenAI endpoint
- Search endpoint
- Cosmos DB endpoint
- Key Vault URI
- managed identity client ID

## Post-Deploy Smoke Validation

After a successful deployment, run:

```powershell
.\post-deploy-smoke.ps1 -Environment dev
```

This script checks for the expected non-prod resource set and verifies that Key Vault returns a vault URI.

## What Still Needs Hardening

- environment promotion workflow
- private endpoint strategy
- RBAC matrix and policy-as-code
- deployment smoke tests after Azure provisioning
- richer operations and monitoring artifacts
