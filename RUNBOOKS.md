# Runbooks

These runbooks cover the top failure modes for the current repo baseline.

## 1. Module 09 Tests Fail

### Signals

- `python -m pytest 09-end-to-end-reference-implementation\app\tests -q` fails
- `validate.ps1` fails

### Actions

1. inspect the failing test output
2. confirm `PYTHONPATH` points at `09-end-to-end-reference-implementation`
3. rerun:
   - `python -m pytest 09-end-to-end-reference-implementation\app\tests -q`
4. if the failure is SDK drift, fix the adapter or pin the dependency explicitly

## 2. Bicep Validation Fails

### Signals

- GitHub workflow fails on Bicep validation
- `az deployment group validate` fails locally

### Actions

1. confirm the parameter file for the target environment exists
2. validate the JSON formatting of the parameter file
3. inspect `09-end-to-end-reference-implementation/infra/main.bicep`
4. rerun validation with:
   - `VALIDATE_ONLY=true ./deploy.sh dev eastus`

## 3. Key Vault Access Fails During Deployment

### Signals

- deployment reports missing or unauthorized secret operations

### Actions

1. confirm the signed-in principal is correct
2. confirm `principalId` is being passed into deployment
3. inspect Key Vault access configuration in Bicep
4. rerun deployment validation

## 4. Azure Search Access Fails

### Signals

- retrieval path cannot access the search service

### Actions

1. confirm the endpoint output is correct
2. confirm the environment values match the deployed environment
3. inspect Bicep outputs and Search configuration
4. verify the repo is not assuming hardened networking that is not yet present

## 5. Broken Draft Module Misleads Users

### Signals

- a draft module claims completeness
- broken scripts or invalid Bicep remain active

### Actions

1. reduce the claim immediately
2. mark module status accurately
3. replace invalid assets with a truthful draft baseline or archive them

## 6. Deployment Script Drift

### Signals

- docs mention Terraform while code uses Bicep
- deploy script and parameter files diverge

### Actions

1. fix docs first
2. align script arguments with actual parameter files
3. rerun validation

