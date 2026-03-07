# Secure AI Architecture

This module provides a deep dive into securing Agentic AI solutions on Azure, following the Five-Layer Security Architecture.

## 🎯 Learning Objectives

*   Implement **Zero Trust** security principles for AI agents.
*   Configure network isolation using **Private Endpoints** and Subnets.
*   Master **Identity & Access** management (RBAC + Managed Identity).
*   Enforce **Data Protection** with encryption (CMEK) and classification.
*   Establish **Continuous Oversight** using Azure Monitor and AI Evaluation.

## 🛠️ Hands-on Labs

*   **Lab 6.1**: Configuring Private Link for Secure AI Service Access.
*   **Lab 6.2**: Implementing Managed Identity and RBAC for Agent Authorization.
*   **Lab 6.3**: Adversarial Prompt Testing and Guardrail Configuration.
*   **Lab 6.4**: Monitoring Agent Egress with Azure Firewall and APIM.

## 🔐 Security Layers

### Layer 1: Perimeter Security
*   Azure Front Door with Web Application Firewall (WAF)
*   DDoS Protection Standard
*   IP filtering and rate limiting

### Layer 2: Network Security
*   Azure VNet with private subnets
*   Network Security Groups (NSGs)
*   Private Endpoints for all Azure services
*   No public IPs for AI services

### Layer 3: Identity & Access
*   Managed Identity for service-to-service
*   Azure RBAC with least-privilege
*   Entra ID B2B/B2C for user access

### Layer 4: Data Protection
*   Encryption at rest (Azure-managed or CMEK)
*   Encryption in transit (TLS 1.2+)
*   Key Vault for secrets management

## 🛡️ Best Practices

*   ✅ Never expose LLM endpoints to the public internet.
*   ✅ Regularly perform red-teaming and adversarial testing.
*   ✅ Use Content Safety filters with custom thresholds.
