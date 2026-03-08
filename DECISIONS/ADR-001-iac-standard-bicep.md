# ADR-001: Bicep as the Primary IaC Standard

## Status

Accepted

## Context

The repository previously mixed terminology and deployment guidance in a way that overstated maturity. The current repo baseline already contains Bicep in the module 09 golden path, while some older docs still referenced Terraform-style workflows that were not present or not accurate.

## Decision

The repository standardizes on **Bicep** as the primary infrastructure-as-code standard for the current reference path.

## Why

- the repo is Azure-first
- module 09 already uses Bicep
- Bicep aligns well with Azure-native learning and reference scenarios
- using one active IaC standard reduces confusion and documentation drift

## Consequences

Positive:

- clearer deployment path
- easier alignment between docs and infra
- lower ambiguity for contributors

Negative:

- any Terraform-oriented guidance must either be archived or explicitly marked non-primary
- future cross-cloud abstraction is not a current goal

## Follow-On Actions

- keep deployment docs aligned to Bicep
- add Bicep validation in CI
- use environment parameter overlays for `dev`, `test`, and `prod`

