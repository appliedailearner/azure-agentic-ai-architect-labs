# RBAC Matrix

This matrix defines the minimum role boundaries implied by the current repository baseline.

## Current Scope

The matrix is centered on the current runnable baselines:

- `09-end-to-end-reference-implementation`
- `05-rag-with-azure-ai-search`
- `08-observability-and-evaluation`

## Role Matrix

| Role | Primary Responsibility | Minimum Access | Should Not Have |
| --- | --- | --- | --- |
| Repo Maintainer | docs, repo hygiene, release coordination | GitHub repo admin, workflow management | broad Azure production owner by default |
| Platform Engineer | Bicep, deployment scripts, environment overlays | resource-group deployment rights in non-prod | unrestricted production secrets access |
| AI Engineer | module logic, tests, prompt and retrieval behavior | contributor access to app code and test paths | direct uncontrolled access to enterprise systems |
| Security Reviewer | threat model, controls, governance review | read access to repo and deployment definitions | routine mutation rights to app code without review |
| Release Approver | release readiness review | access to changelog, checklists, CI results | undocumented bypass of validation gates |

## Azure Role Direction

Current Azure direction for the repo:

- least privilege for deployment identities
- managed identity preferred for running services
- Key Vault access scoped to secret read needs
- Search and OpenAI access scoped to the service boundary

## Current Gaps

This repo does not yet contain:

- deployable RBAC assignments for every module
- policy-backed enforcement of these boundaries
- environment-specific principal mapping

## Immediate Rule

Do not add repo content that implies broad standing privileges are acceptable for normal operation.

