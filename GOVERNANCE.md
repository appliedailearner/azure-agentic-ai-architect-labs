# Governance

This document defines the week 2 governance baseline for the repository.

## Governance Objective

The repo must distinguish clearly between:

- learning content
- draft reference patterns
- validated implementation paths

## Current Governance Rule

Only `09-end-to-end-reference-implementation` is the current runnable baseline. All other modules remain draft until they have:

- a setup path
- a run path
- a validation step
- expected output
- documented support boundaries

## Required Governance Areas

### Prompt Governance

- prompts and instructions must be version-controlled
- prompt changes that affect runtime behavior should be reviewed
- avoid undocumented prompt changes in golden-path modules

### Model Governance

- model assumptions must be documented
- deployment docs must not imply one model family if the code uses another
- model routing changes should be treated as architecture changes

### Tool Governance

- new tools must state purpose, auth boundary, and failure mode
- direct enterprise mutation paths should not be introduced casually
- future APIM mediation remains the target control point

### Documentation Governance

- README claims must match current code and validation evidence
- deprecated workflows and stale guidance should be removed, not left alongside active guidance

### Environment Governance

- dev, test, and prod should use explicit parameter overlays
- environment-specific deviations should be visible in source control

## Decision Standard

When repo content is uncertain:

- prefer truthful status labeling
- reduce claims instead of inflating confidence
- keep one validated path rather than many unverified paths

## Next Governance Artifacts

- ADR for Bicep as the primary infrastructure standard
- role ownership matrix
- release checklist for module promotion from `Draft` to `Runnable Baseline`

