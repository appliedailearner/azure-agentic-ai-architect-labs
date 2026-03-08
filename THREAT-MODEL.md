# Threat Model

This is the initial threat model for the current golden path in `09-end-to-end-reference-implementation`.

## Scope

In scope:

- Python agent baseline
- model invocation path
- retrieval path
- secret handling path
- deployment baseline using Bicep

Out of scope for now:

- private networking implementation details
- full production incident handling
- compliance mappings by industry

## Key Assets

- model endpoints
- retrieval content and indexes
- Key Vault secrets
- deployment credentials
- agent prompts and configuration
- enterprise tool integrations

## Trust Boundaries

1. user to agent application
2. agent application to model endpoint
3. agent application to retrieval system
4. agent application to external tools
5. deployment operator to Azure control plane

## Primary Threat Scenarios

### 1. Prompt injection causes unsafe tool use

Risk:
- agent follows malicious instructions embedded in retrieved or user-supplied content

Current mitigation direction:
- future API mediation boundary
- constrained tool patterns
- explicit governance over tool registration

### 2. Secret leakage through code or configuration

Risk:
- contributors commit credentials to the repo or use long-lived secrets in examples

Current mitigation direction:
- `.gitignore`
- Key Vault direction
- explicit no-secret rule in `SECURITY.md`

### 3. Retrieval poisoning

Risk:
- untrusted content enters the RAG corpus and manipulates agent behavior

Current mitigation direction:
- governed source lists
- metadata and content review in future pipeline work

### 4. Overstated security claims

Risk:
- users assume non-hardened modules are production-safe

Current mitigation direction:
- module status tracking
- explicit support boundary in top-level docs

### 5. Environment drift

Risk:
- dev, test, and prod are deployed with different undocumented settings

Current mitigation direction:
- environment parameter files under module 09

## Abuse Cases

- contributor bypasses documented deployment path and adds manual secrets
- agent or developer connects directly to enterprise tools without a mediation layer
- draft modules are reused as production templates without validation

## Required Follow-On Controls

- policy-as-code
- private networking
- RBAC matrix
- deployment gates
- security scanning in CI
- runbooks for incident response

