# Known Limitations

This repository is ready for an **alpha** release, not a production release.

## Current Scope Limitations

- only `09-end-to-end-reference-implementation`, `05-rag-with-azure-ai-search`, and `08-observability-and-evaluation` are runnable baselines
- the remaining modules are still draft or reference-stage assets
- not every Azure deployment path is hardened or fully validated

## Security and Governance Limitations

- policy is currently a scaffold, not full policy-as-code enforcement
- RBAC direction is documented, but not fully encoded across all modules
- private networking and private endpoint patterns are not yet implemented end to end
- no claim of production-grade compliance or regulated-workload readiness should be made

## Operations and Observability Limitations

- observability and evaluation are baseline implementations, not mature production systems
- runbooks and operations docs exist, but are still early compared to a full service operating model
- smoke validation is local and repo-focused rather than a full post-deployment Azure verification suite

## Release Positioning

- this repo should currently be described as an evolving reference implementation
- `v0.1.0-alpha` means the repo is structured, increasingly validated, and intentionally governed
- `v0.1.0-alpha` does **not** mean feature-complete or enterprise-production-ready

