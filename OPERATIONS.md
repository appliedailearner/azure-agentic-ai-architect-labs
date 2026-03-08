# Operations

This document defines the current operating model for the repository baseline.

## Current Operating Scope

The only validated runtime path in this repo remains:

- `09-end-to-end-reference-implementation`

The rest of the modules should be treated as draft content until promoted through the validation rules in `MODULE-STATUS.md`.

## Operations Objective

The repo should evolve from a learning scaffold into a supportable reference implementation. The week 3 objective is to define the minimum operating model before adding more breadth.

## Current SLO Direction

These are target operating signals for the golden path:

- local validation success rate: 100% before merge
- module 09 unit and integration baseline: pass before merge
- Bicep validation for module 09: pass before merge
- documented support boundary: always current

## Required Runtime Signals

The eventual production-shaped reference should track:

- request success rate
- latency by model call and retrieval step
- tool invocation success rate
- quota exhaustion events
- deployment failures
- cost per environment

## Deployment Model

Current deployment model:

- source-controlled Bicep
- parameter overlays for `dev`, `test`, and `prod`
- local validation before Azure deployment

Current limitation:

- no automated promotion workflow yet
- no post-deploy smoke automation yet

## Rollback Standard

At the current maturity level, rollback should be handled by:

- reverting the last bad commit
- rerunning local validation
- rerunning Bicep validation
- redeploying the last known good state

## Support Model

Current ownership expectation:

- repo maintainer owns docs and repo consistency
- platform owner owns Bicep and deployment logic
- AI owner owns module 09 behavior and tests
- security owner owns control and threat documentation

## Next Operations Artifacts

- alerting thresholds
- smoke tests after Azure deployment
- dashboards and KQL examples
- release checklist tied to evals and deployment validation

