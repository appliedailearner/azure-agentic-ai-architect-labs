# Secure Enterprise AI Platform

## Overview
This portfolio project demonstrates a production-grade enterprise AI platform that prioritizes security, compliance, and governance. It showcases how to deploy AI agents with zero-trust networking, identity-based access, secrets management, and comprehensive monitoring suitable for regulated industries (finance, healthcare, government).

## Architecture
```text
Clients (VPN)
    ↓
[Azure Front Door + WAF]
    ↓
[Private Endpoints]
    ↓
[VNet with NSGs]
    ↓
[Azure OpenAI]  [AI Foundry]
    ↓           ↓
[Managed Identity]
```

## Security Layers

### Layer 1: Perimeter Security
- Azure Front Door with Web Application Firewall (WAF)
- DDoS Protection Standard
- IP filtering and rate limiting

### Layer 2: Network Security
- Azure VNet with private subnets
- Network Security Groups (NSGs)
- Private Endpoints for all Azure services
- No public IPs for AI services

### Layer 3: Identity & Access
- Azure AD B2B for partner access
- Managed Identity for service-to-service
- Azure RBAC with least-privilege
- Service Principal with certificate-based auth

### Layer 4: Data Protection
- Encryption at rest (Azure-managed keys)
- Encryption in transit (TLS 1.2+)
- Key Vault for secrets management
- Customer-managed encryption keys (CMEK) for sensitive data

### Layer 5: Compliance & Audit
- Azure Policy for governance
- Azure Sentinel for threat detection
- Log Analytics with long-term retention
- Azure Purview for data lineage
