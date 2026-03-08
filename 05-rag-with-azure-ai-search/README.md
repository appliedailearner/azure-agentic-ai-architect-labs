# Module 05: RAG with Azure AI Search

## Status

`Runnable Baseline`

This module is the first promoted module outside the main golden path. It now provides a small, local RAG-oriented baseline that is runnable and testable.

## What This Module Proves

- a local retrieval flow exists
- retrieval results are turned into a grounded response
- the module has tests
- the module has a validation script
- the module has a corrected draft Bicep baseline

## Support Boundary

This module is a **local runnable baseline**, not a production-ready RAG implementation. It does not yet prove:

- Azure AI Search index provisioning logic beyond baseline infrastructure
- ingestion pipelines
- relevance evaluation
- access control and private networking

## Local Run Path

```powershell
cd 05-rag-with-azure-ai-search
python -m pytest .\tests -q
.\validate.ps1
```

## Expected Output

- tests pass
- `/health` reports the module is healthy
- `/retrieve` returns at least one document and a grounded response

## Files

- `app/main.py`
- `tests/test_main.py`
- `validate.ps1`
- `infra/main.bicep`
- `deployment/deploy.sh`

## Optional Azure Deployment Path

```bash
cd 05-rag-with-azure-ai-search/deployment
./deploy.sh dev eastus
```

This deployment path is still a draft Azure baseline and should not be mistaken for a hardened enterprise RAG stack.
