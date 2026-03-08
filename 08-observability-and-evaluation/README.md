# Module 08: Observability and Evaluation

## Status

`Runnable Baseline`

This module is now a runnable local baseline for observability and evaluation concepts. It provides a small evaluation summary flow that turns raw request signals into an operational status summary.

## What This Module Proves

- a local evaluation endpoint exists
- telemetry-like request signals can be summarized consistently
- the module has tests
- the module has a validation script
- the module has corrected draft Azure deployment assets

## Support Boundary

This module is a local runnable baseline. It does not yet provide:

- real telemetry ingestion
- live dashboards
- alert routing
- production-grade tracing
- online evaluation loops

## Local Run Path

```powershell
cd 08-observability-and-evaluation
python -m pytest .\tests -q
.\validate.ps1
```

## Expected Output

- tests pass
- `/health` reports the module is healthy
- `/evaluate` returns request totals, success rate, grounded rate, latency summary, and overall status

## Files

- `app/main.py`
- `tests/test_main.py`
- `validate.ps1`
- `infra/main.bicep`
- `deployment/deploy.sh`

## Optional Azure Deployment Path

```bash
cd 08-observability-and-evaluation/deployment
./deploy.sh dev eastus
```

This is still a draft Azure baseline and should not be mistaken for a finished observability stack.
