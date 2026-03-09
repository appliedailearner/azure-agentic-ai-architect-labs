# Validation Matrix

This file summarizes the current validated paths for the alpha release.

| Area | Validation Path | Current State |
| --- | --- | --- |
| Module 09 | `.\09-end-to-end-reference-implementation\validate.ps1` | passing |
| Module 05 | `.\05-rag-with-azure-ai-search\validate.ps1` | passing |
| Module 07 | `.\07-secure-reference-architecture\validate.ps1` | passing |
| Module 08 | `.\08-observability-and-evaluation\validate.ps1` | passing |
| Repo smoke validation | `.\tests\smoke\smoke-validate.ps1` | passing |
| Policy JSON artifacts | parsed during local checks and CI workflow | passing |
| Module 09 env parameter files | parsed during local checks and CI workflow | passing |

## Notes

- Azure CLI Bicep build validation is expected to run most reliably in CI because local sandbox access to the Azure profile can be restricted
- this matrix should be updated whenever a new module is promoted or a validation path changes

