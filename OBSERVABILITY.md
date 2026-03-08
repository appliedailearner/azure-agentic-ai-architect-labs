# Observability

This document defines the observability baseline for the repository.

## Current Scope

The current runnable baseline remains:

- `09-end-to-end-reference-implementation`

Observability work in this repo is currently about defining the minimum signals, dashboards, and alerts required to make that golden path supportable.

## Observability Objectives

- make runtime behavior diagnosable
- make deployment failures visible
- make cost and quality drift visible
- tie alerts to operational runbooks

## Minimum Signals for the Golden Path

The reference implementation should ultimately emit:

- request count and success rate
- end-to-end latency
- model call latency
- retrieval latency
- retrieval failure count
- tool invocation success and failure count
- environment and deployment metadata
- cost-relevant usage markers

## Trace Model

Each request should eventually carry a correlation identifier across:

- request intake
- prompt construction
- retrieval
- model invocation
- tool invocation
- final response

## Minimum Dashboards

### 1. Service Health

- requests
- failures
- latency

### 2. Retrieval Health

- search call count
- failed retrievals
- retrieval latency

### 3. Tool Health

- tool call count
- tool timeout count
- tool failure count

### 4. Cost and Capacity

- estimated model usage
- search SKU context
- Cosmos throughput context
- environment deployment footprint

## Minimum Alerts

- sustained test or validation failure on `main`
- Bicep validation failure
- deployment validation failure
- retrieval failure spikes
- tool failure spikes
- sudden cost increase once cost telemetry exists

## Current Gap

The repo does not yet contain:

- live dashboard definitions
- KQL queries
- Application Insights instrumentation
- production-grade tracing

Those are the next-level observability tasks after the current baseline scaffolding.

## Related Documents

- [OPERATIONS.md](./OPERATIONS.md)
- [RUNBOOKS.md](./RUNBOOKS.md)
- [FINOPS.md](./FINOPS.md)

