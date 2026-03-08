# Module 07: Secure Reference Architecture

## Status

`Runnable Baseline`

This module now provides a runnable local security baseline. It turns a set of control signals into a simple security assessment summary and pairs that with corrected draft Azure deployment assets.

## What This Module Proves

- a local security assessment flow exists
- control failures can be summarized into a risk level
- the module has tests
- the module has a validation script
- the module has corrected draft Bicep and deployment assets

## Support Boundary

This module is a runnable baseline, not a hardened production security implementation. It does not yet provide:

- policy enforcement at scale
- private networking implementation
- full Azure RBAC automation across every module
- security operations integration

## Local Run Path

```powershell
cd 07-secure-reference-architecture
python -m pytest .\tests -q
.\validate.ps1
```

## Expected Output

- tests pass
- `/health` reports the module is healthy
- `/assess` returns enabled control counts, failed controls, and a risk level

## Optional Azure Deployment Path

```bash
cd 07-secure-reference-architecture/deployment
./deploy.sh dev eastus
```

This remains a draft Azure baseline and should be used for reference, not as a finished secure landing zone.
