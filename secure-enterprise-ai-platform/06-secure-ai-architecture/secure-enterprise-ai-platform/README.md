# Secure Enterprise AI Platform

## Overview

This portfolio project demonstrates a production-grade enterprise AI platform that prioritizes security, compliance, and governance. It showcases how to deploy AI agents with zero-trust networking, identity-based access, secrets management, and comprehensive monitoring suitable for regulated industries (finance, healthcare, government).

## Architecture

```
Clients (VPN)
    ↓
[Azure Front Door + WAF]
    ↓
[Private Endpoints]
    ↓
[VNet with NSGs]
    ↓
[Azure OpenAI]  [AI Foundry]
    ↓            ↓
[Managed Identity]
    ↓
[API Service]
    ↓
[Data Sources] (in VNet)
    ↓
[Key Vault] [App Insights] [Log Analytics]
```

### Security Layers

**Layer 1: Perimeter Security**
- Azure Front Door with Web Application Firewall (WAF)
- DDoS Protection Standard
- IP filtering and rate limiting

**Layer 2: Network Security**
- Azure VNet with private subnets
- Network Security Groups (NSGs)
- Private Endpoints for all Azure services
- No public IPs for AI services

**Layer 3: Identity & Access**
- Azure AD B2B for partner access
- Managed Identity for service-to-service
- Azure RBAC with least-privilege
- Service Principal with certificate-based auth

**Layer 4: Data Protection**
- Encryption at rest (Azure-managed keys)
- Encryption in transit (TLS 1.2+)
- Key Vault for secrets management
- Customer-managed encryption keys (CMEK) for sensitive data

**Layer 5: Compliance & Audit**
- Azure Policy for governance
- Azure Sentinel for threat detection
- Log Analytics with long-term retention
- Azure Purview for data lineage

## Azure Services Used

### Core AI Services
- **Azure OpenAI**: Foundational LLM with private endpoints
- **Azure AI Foundry**: Agent hosting, monitoring, and governance
- **Azure AI Search**: Vector search with RBAC and encryption

### Networking & Security
- **Azure VNet**: Isolated network boundary
- **Azure Private Endpoints**: Service connectivity without public internet
- **Azure Front Door**: Global load balancing with WAF
- **Network Security Groups**: Firewall rules at subnet level

### Identity & Secrets
- **Azure AD**: Identity provider and RBAC
- **Azure Key Vault**: Secrets, keys, certificates management
- **Managed Identities**: Automatic credential management

### Data & Storage
- **Azure Storage (with Private Endpoints)**: Document and log storage
- **Azure Cosmos DB (with Private Endpoints)**: State and audit logs
- **Azure SQL Database (Private Endpoints)**: Transactional data

### Monitoring & Compliance
- **Application Insights**: Agent telemetry and performance
- **Log Analytics**: Centralized logging and audit trail
- **Azure Monitor**: Infrastructure and application metrics
- **Azure Sentinel**: SIEM for threat detection
- **Azure Policy**: Compliance enforcement
- **Azure Purview**: Data governance and lineage

## Security Architecture Decisions

### 1. Private Endpoints Over Public Access
**Decision**: Route all Azure service traffic through private endpoints

**Rationale**:
- Zero exposure of service endpoints to public internet
- Traffic stays within Azure backbone network
- Compliance with data residency requirements
- Protection against data exfiltration
- Support for network-level access controls

### 2. Managed Identity vs Service Principals
**Decision**: Use Managed Identity for applications, Service Principals for CI/CD

**Rationale**:
- No credentials stored in code or config
- Automatic rotation handled by Azure AD
- Audit trail at Azure platform level
- Reduced attack surface from compromised creds

### 3. Key Vault with RBAC
**Decision**: Separate vaults per environment with fine-grained access

**Rationale**:
- Environment isolation prevents cross-contamination
- Least-privilege per application
- Audit trail for all secret access
- Support for compliance requirements

### 4. Encryption with Customer-Managed Keys
**Decision**: Use CMEK for data at rest in regulated workloads

**Rationale**:
- Full control over encryption keys
- Compliance with data sovereignty laws
- Ability to revoke access immediately
- Required for SOC 2, FedRAMP certifications

### 5. Network Segmentation
**Decision**: Multiple subnets with restrictive NSG rules

**Rationale**:
- Isolate AI services from data services
- Prevent lateral movement if compromised
- Support for network-level incident response
- Compliance with zero-trust architecture

## Compliance & Governance

### Compliance Frameworks Supported
- **SOC 2 Type II**: Security controls for service providers
- **ISO 27001**: Information security management
- **HIPAA**: For healthcare organizations
- **PCI-DSS**: For payment processing
- **GDPR**: Data privacy and residency

### Governance Policies
```json
{
  "Azure Policies": [
    "Require private endpoints for all PaaS services",
    "Enforce encryption at rest for storage accounts",
    "Require TLS 1.2 minimum for all connections",
    "Audit access to Key Vault",
    "Require diagnostic logs for all resources",
    "Block public IP assignments for AI services"
  ]
}
```

### Audit & Monitoring Strategy

**Real-Time Monitoring**
```kusto
// Log Analytics KQL Query
AzureDiagnostics
| where ResourceProvider == "Microsoft.CognitiveServices"
| where OperationName contains "Token"
| summarize Count = count() by CallerIPAddress, UserPrincipalName
| where Count > threshold
```

**Compliance Reporting**
- Monthly access log reviews
- Quarterly compliance attestation
- Annual security assessment
- Continuous drift detection

## Network Design

### VNet Architecture
```
VNet: 10.0.0.0/16
  ├─ Gateway Subnet: 10.0.1.0/24 (VPN/ExpressRoute)
  ├─ API Subnet: 10.0.2.0/24 (App Service)
  ├─ AI Subnet: 10.0.3.0/24 (Container Instances for agents)
  └─ Data Subnet: 10.0.4.0/24 (Databases)
```

### Private Endpoints Configuration
```python
# Example: Create private endpoint for OpenAI
from azure.identity import DefaultAzureCredential
from azure.mgmt.network import NetworkManagementClient

credential = DefaultAzureCredential()
client = NetworkManagementClient(credential, subscription_id)

private_endpoint = {
    "location": "eastus",
    "properties": {
        "subnet": {"id": subnet_id},
        "privateLinkServiceConnections": [{
            "name": "openai-connection",
            "properties": {
                "privateLinkServiceId": service_id,
                "groupIds": ["account"]
            }
        }]
    }
}
```

## Data Protection Strategy

### Encryption Layers
1. **In Transit**: TLS 1.2+ for all network traffic
2. **At Rest**: AES-256 (Azure-managed or CMEK)
3. **In Processing**: Secure enclaves for sensitive operations

### Key Management
```python
# Rotate keys every 90 days
from azure.keyvault.keys import KeyClient

client = KeyClient(vault_url, credential)

# Automatic rotation configuration
key_properties = {
    "rotation_policy": {
        "expires_in": "P90D",
        "auto_rotate": True
    }
}
```

## Deployment & Operations

### Infrastructure as Code
```bash
# Terraform deployment with security modules
terraform init
terraform plan -var-file=prod.tfvars \
  -target=module.security \
  -target=module.networking \
  -target=module.ai_services
terraform apply
```

### Post-Deployment Hardening
- Run Azure Security Benchmark assessment
- Enable continuous compliance monitoring
- Configure alerts for security events
- Implement incident response procedures

## Monitoring & Alerting

### Critical Metrics to Monitor
```
1. Unauthorized API calls (threshold: > 5 in 1 min)
2. Key Vault access failures (threshold: > 3 in 5 min)
3. Network policy violations (threshold: > 10 in 5 min)
4. Failed authentication attempts (threshold: > 10 in 5 min)
5. Unusual AI model parameter changes
```

### Alert Configuration
```python
from azure.monitor.query import MetricsQueryClient

# Create alert for failed auth attempts
alert_config = {
    "name": "Failed Auth Alert",
    "condition": "failed_auth_count > 10",
    "time_window": "5m",
    "severity": "high",
    "actions": ["email_admin", "create_incident"]
}
```

## Cost Optimization for Security

### Trade-offs & Mitigation
| Security Feature | Cost Impact | Mitigation |
|---|---|---|
| Private Endpoints | +$0.60/day each | Consolidate endpoints, share where possible |
| CMEK Encryption | +$0.30/key/month | Rotate less frequently, use HSM alternatives |
| Continuous Monitoring | +$2-5/GB/month | Set retention to 90 days, archive older logs |
| Network Appliances | +$0.15/hour | Use NSGs vs NVAs where possible |

### Total Security Cost (100 API calls/second)
- Private Endpoints: $180/month
- Key Vault: $30/month
- Log Analytics: $200/month
- Azure Sentinel (optional): $0.50/GB/month
- **Total: ~$410/month** (+ AI service costs)

## Key Deliverables

- ✅ Security architecture diagram (docs/security-architecture.png)
- ✅ Network diagram with private endpoints (docs/network-design.png)
- ✅ Zero-trust policy document (docs/ZERO_TRUST_POLICY.md)
- ✅ Terraform modules for secure deployment (deploy/terraform/modules/)
- ✅ Azure Policy definitions (deploy/policies/)
- ✅ Compliance checklist (docs/COMPLIANCE_CHECKLIST.md)
- ✅ Incident response playbooks (docs/INCIDENT_RESPONSE.md)
- ✅ Security baseline configuration (deploy/security-baseline/)

## Design Patterns Demonstrated

1. **Zero Trust**: Verify every access, no implicit trust
2. **Defense in Depth**: Multiple security layers
3. **Principle of Least Privilege**: Minimal permissions by default
4. **Separation of Concerns**: Isolated networks and identities
5. **Audit Everything**: Comprehensive logging and monitoring

## Lessons Learned

1. **Private Endpoints Cost**: Adds $0.60/day each; consolidated where possible
2. **Key Rotation Complexity**: Must plan for zero-downtime rotation
3. **Monitoring Overhead**: Logging everything can become expensive; tier logs by importance
4. **Compliance is a Journey**: Continuous assessment vs one-time audit
5. **Network Latency**: Private endpoints add 1-2ms latency; acceptable for most workloads

## Security Incident Response

### Response Procedures
1. **Detection**: Azure Sentinel picks up suspicious activity
2. **Investigation**: Log Analytics KQL queries to establish scope
3. **Containment**: NSG rules block compromised resource
4. **Eradication**: Rotate keys, reset credentials
5. **Recovery**: Restore from unaffected snapshots
6. **Post-Incident**: Root cause analysis, policy updates

## Continuous Improvement

- [ ] Implement automated penetration testing
- [ ] Add threat modeling for new features
- [ ] Extend to multi-region with failover
- [ ] Implement customer-managed encryption keys everywhere
- [ ] Add identity federation for partners

## References

- [Azure Security Benchmark](https://learn.microsoft.com/en-us/security/benchmark/azure/)
- [Zero Trust Implementation Guide](https://learn.microsoft.com/en-us/security/zero-trust/)
- [Azure Private Endpoints](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview)
- [Azure Key Vault Best Practices](https://learn.microsoft.com/en-us/azure/key-vault/general/best-practices)
