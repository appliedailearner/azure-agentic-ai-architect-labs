# Security Baseline

This repository is in a staged hardening process. The current security posture should be read as a **baseline direction**, not as proof that every module is production-ready.

## Current Security Position

The repo is converging on these standards:

- Managed Identity preferred over static secrets
- Azure Key Vault for secret storage in deployment scenarios
- Azure API Management as the future tool mediation boundary
- Azure RBAC for service authorization
- Azure AI Search as the governed retrieval layer
- Bicep as the infrastructure standard for Azure deployment

## Current Support Boundary

Only `09-end-to-end-reference-implementation` should currently be treated as the working security baseline. The remaining modules are still draft curriculum assets and may contain incomplete or non-hardened patterns.

## Security Controls Expected in the Target State

- identity-first authentication
- least-privilege RBAC
- no secrets committed to the repo
- Key Vault-backed secret retrieval
- explicit external tool boundaries
- environment separation for dev, test, and prod
- CI validation before merge
- threat-model-driven reviews for tool and retrieval changes

## Known Gaps

These areas are still in progress:

- policy-as-code
- private networking and private endpoints
- complete logging and audit control documentation
- automated dependency and secret scanning in a hardened release workflow
- formal incident response and runbooks

## Immediate Rules for Contributors

- do not add live credentials or test secrets to the repository
- do not describe a module as production-ready unless it has matching validation evidence
- prefer Bicep and Azure-native identity patterns over manual portal-only instructions
- treat enterprise tools and mutations as high-risk surfaces

## Next Security Artifacts

- [THREAT-MODEL.md](./THREAT-MODEL.md)
- [GOVERNANCE.md](./GOVERNANCE.md)
- module-level RBAC and environment overlays under `09-end-to-end-reference-implementation/infra/environments/`

