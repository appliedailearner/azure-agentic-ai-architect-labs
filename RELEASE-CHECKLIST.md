# Release Checklist

Use this checklist before calling a repo state release-ready.

## Documentation

- [ ] README reflects actual repo state
- [ ] QUICK-START reflects actual runnable path
- [ ] MODULE-STATUS is current
- [ ] CHANGELOG updated

## Golden Path Validation

- [ ] `python -m pytest 09-end-to-end-reference-implementation\app\tests -q` passes
- [ ] `python -m ruff check 09-end-to-end-reference-implementation\app\agent.py` passes
- [ ] `09-end-to-end-reference-implementation\validate.ps1` passes
- [ ] `tests\smoke\smoke-validate.ps1` passes

## Infrastructure

- [ ] module 09 Bicep builds
- [ ] environment parameter files parse and align with documented environments
- [ ] deployment guide matches the active Bicep path

## Governance and Security

- [ ] security and governance docs are current
- [ ] threat model reflects the current golden path
- [ ] RBAC matrix is current
- [ ] policy scaffold reflects current control direction
- [ ] no draft module is presented as validated

## Release Hygiene

- [ ] commit history and release notes are understandable
- [ ] support boundary is stated honestly
- [ ] open known gaps are not hidden by inflated claims
