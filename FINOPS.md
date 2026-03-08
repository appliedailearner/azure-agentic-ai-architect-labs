# FinOps

This document defines the current FinOps posture for the repo baseline.

## Current Principle

Do not imply enterprise credibility without cost visibility. Even in a learning repo, environment defaults should reflect intentional cost choices.

## Current Environment Cost Direction

### Dev

- lower-cost search SKU
- low Cosmos throughput
- optimized for experimentation

### Test

- closer to production behavior than dev
- still cost-controlled

### Prod

- higher search SKU
- higher Cosmos throughput
- intended as a placeholder for future production-shaped scaling decisions

## Current Cost Drivers

- model usage
- Azure AI Search SKU
- Cosmos DB throughput
- Application Insights and monitoring growth over time
- API Management if expanded beyond the current baseline

## Current Repo-Level FinOps Controls

- source-controlled environment parameter files
- explicit environment overlays
- truthful support boundaries to prevent overprovisioning based on false assumptions

## Immediate FinOps Guidance

- use `dev` unless you are explicitly testing environment overlays
- do not deploy `prod` as a default learning path
- keep cost commentary in docs aligned with actual IaC defaults

## Next FinOps Work

- cost estimate table per environment
- token and model routing guidance
- quota strategy
- cost alerts and budget examples

