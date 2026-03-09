# Azure Agentic AI Architect Labs

![Release](https://img.shields.io/badge/release-v0.1.0--alpha-blue)
![Maturity](https://img.shields.io/badge/maturity-alpha-orange)
![Primary%20Path](https://img.shields.io/badge/primary%20path-module%2009-success)
![Runnable%20Baselines](https://img.shields.io/badge/runnable%20baselines-4-brightgreen)
![Infrastructure](https://img.shields.io/badge/infrastructure-Bicep-4C7CF0)
![Validation](https://img.shields.io/badge/repo%20smoke-passing-success)

This repository is being evolved into a credible Azure-first learning and reference repo for agentic AI. As of March 8, 2026, the repo is in an **alpha baseline state**:

- the folder structure is documented explicitly
- module maturity is tracked in [MODULE-STATUS.md](./MODULE-STATUS.md)
- multiple runnable baselines now exist
- broad production-ready claims remain intentionally constrained

## What This Repo Is

This repo is intended to become:

- a structured learning path for Azure agentic AI labs
- a reference implementation for a secure, Azure-native agent workflow
- a delivery accelerator for architecture, security, and operations discussions

## Current Maturity

The repo is **not yet a full enterprise-grade reference implementation**. It currently has:

- one prioritized golden path in [09-end-to-end-reference-implementation](./09-end-to-end-reference-implementation/README.md)
- additional runnable baselines in modules 05, 07, and 08
- draft modules for the remaining curriculum
- Bicep, smoke validation, governance, policy, and release artifacts

See [MODULE-STATUS.md](./MODULE-STATUS.md) for the current truth.

## Start Here

Use this order:

1. Read [QUICK-START.md](./QUICK-START.md)
2. Review [REFERENCE-ARCHITECTURE.md](./REFERENCE-ARCHITECTURE.md)
3. Run the module 09 validation path in [09-end-to-end-reference-implementation](./09-end-to-end-reference-implementation/README.md)
4. Use [docs/repo-map.md](./docs/repo-map.md) to navigate the rest of the repo

## Repository Layout

```text
.
├── 01-foundry-foundations/
├── 02-foundry-agent-service/
├── 03-semantic-kernel-track/
├── 04-agent-framework-and-multi-agent/
├── 05-rag-with-azure-ai-search/
├── 06-mcp-and-enterprise-tooling/
├── 07-secure-reference-architecture/
├── 08-observability-and-evaluation/
├── 09-end-to-end-reference-implementation/
├── .github/
├── docs/
├── MODULE-STATUS.md
├── QUICK-START.md
├── REFERENCE-ARCHITECTURE.md
└── ARCHITECTURE.md
```

## Recommended Learning Path

The intended learning sequence is:

1. Foundry foundations
2. Foundry agent service
3. Semantic Kernel patterns
4. Multi-agent orchestration
5. RAG with Azure AI Search
6. MCP and enterprise tooling
7. Secure reference architecture
8. Observability and evaluation
9. End-to-end reference implementation

Module 09 remains the recommended first execution path.

## Current Alpha Scope

This repository is currently positioned as `v0.1.0-alpha`.

That means:

- the repo has multiple runnable baselines
- release, governance, and smoke-validation artifacts exist
- support boundaries are explicit
- the repo is still not production-ready

## Runnable Modules

| Module | Status | What It Proves |
| --- | --- | --- |
| `09-end-to-end-reference-implementation` | Runnable Baseline | primary golden path, agent baseline, Bicep overlays, repo validation |
| `05-rag-with-azure-ai-search` | Runnable Baseline | local RAG-style retrieval and grounded response flow |
| `07-secure-reference-architecture` | Runnable Baseline | local security control assessment baseline |
| `08-observability-and-evaluation` | Runnable Baseline | local evaluation and observability summary baseline |

## What Works Today

Current alpha baseline:

- a truthful top-level README and quick start
- a documented module maturity view
- a reference architecture and governance/security/operations docs
- runnable baselines for modules 09, 05, 07, and 08
- smoke validation and GitHub workflow coverage
- policy examples and an RBAC example

## What Is Still In Progress

- standardizing each module README to the same template
- expanding infrastructure as code beyond the current baseline
- adding security, governance, observability, and evaluation artifacts at enterprise depth
- separating learning labs from the future enterprise reference track more cleanly

## Support Boundary

This repository should currently be treated as:

- safe for learning and repo modernization work
- useful for architecture discussion and pattern exploration
- **not yet sufficient as a production deployment standard without further hardening**

## Not Yet Production Ready Because

- only some modules are runnable baselines
- policy enforcement is still partial
- Azure deployment validation is still maturing
- private networking and deeper control enforcement are not complete
- observability and evaluation are baseline implementations rather than production-grade systems

## Key Documents

- [QUICK-START.md](./QUICK-START.md)
- [MODULE-STATUS.md](./MODULE-STATUS.md)
- [REFERENCE-ARCHITECTURE.md](./REFERENCE-ARCHITECTURE.md)
- [ARCHITECTURE.md](./ARCHITECTURE.md)
- [SECURITY.md](./SECURITY.md)
- [THREAT-MODEL.md](./THREAT-MODEL.md)
- [GOVERNANCE.md](./GOVERNANCE.md)
- [OPERATIONS.md](./OPERATIONS.md)
- [RUNBOOKS.md](./RUNBOOKS.md)
- [FINOPS.md](./FINOPS.md)
- [OBSERVABILITY.md](./OBSERVABILITY.md)
- [CHANGELOG.md](./CHANGELOG.md)
- [KNOWN-LIMITATIONS.md](./KNOWN-LIMITATIONS.md)
- [RELEASE-CHECKLIST.md](./RELEASE-CHECKLIST.md)
- [RELEASE-STRATEGY.md](./RELEASE-STRATEGY.md)
- [VALIDATION-MATRIX.md](./VALIDATION-MATRIX.md)
- [MODULE-PROMOTION-CHECKLIST.md](./MODULE-PROMOTION-CHECKLIST.md)
- [docs/releases/v0.1.0-alpha.md](./docs/releases/v0.1.0-alpha.md)
- [docs/rbac-matrix.md](./docs/rbac-matrix.md)
- [09-end-to-end-reference-implementation/README.md](./09-end-to-end-reference-implementation/README.md)
- [docs/repo-map.md](./docs/repo-map.md)
- [docs/terminology.md](./docs/terminology.md)

## Current Release Position

The repository now has its first prerelease tag:

- current tag: `v0.1.0-alpha`
- positioning: structured, validated baseline with explicit limitations
- details: see [KNOWN-LIMITATIONS.md](./KNOWN-LIMITATIONS.md)
