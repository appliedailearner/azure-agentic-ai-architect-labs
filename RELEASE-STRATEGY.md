# Release Strategy

This document defines how the repository should move from iterative hardening into tagged prereleases.

## Current Release Position

The repo is approaching prerelease readiness, but it should still be treated as an evolving reference implementation.

## Release Stages

### Draft

- docs and code may still shift rapidly
- no release tag required

### Runnable Baseline

- at least one module has a repeatable validation path
- no prerelease claim yet by default

### Prerelease

- multiple runnable baselines exist
- release checklist passes
- smoke validation passes
- support boundary is explicit

### More Mature Release

- policy and RBAC coverage are deeper
- deployment smoke checks are richer
- more modules are promoted through evidence

## First Recommended Tag

When the repo owner is satisfied with smoke validation and release hygiene, the first recommended tag is:

- `v0.1.0-alpha`

## Requirements for `v0.1.0-alpha`

- release checklist complete
- smoke validation passes
- module 09, 05, and 08 validation paths pass
- changelog updated
- no README drift

## Current Constraint

Do not tag a prerelease simply because the repo looks cleaner. Tag only when the validation paths and governance artifacts are all current.

