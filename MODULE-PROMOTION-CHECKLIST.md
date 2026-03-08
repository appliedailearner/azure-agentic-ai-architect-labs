# Module Promotion Checklist

Use this checklist before promoting a module from `Draft` to `Runnable Baseline` or from `Runnable Baseline` to `Validated`.

## Draft to Runnable Baseline

- [ ] module README includes purpose, support boundary, and truthful status
- [ ] setup steps are documented
- [ ] local run path exists
- [ ] validation path exists
- [ ] expected output is documented
- [ ] troubleshooting notes exist

## Runnable Baseline to Validated

- [ ] another person can follow the documented path successfully
- [ ] validation results are repeatable
- [ ] infra and deployment guidance match actual files
- [ ] module is listed correctly in `MODULE-STATUS.md`
- [ ] no broken placeholder assets remain

## Promotion Rule

If any item above is false, do not promote the module status.

