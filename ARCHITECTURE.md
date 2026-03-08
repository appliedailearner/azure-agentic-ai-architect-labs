# System Architecture Overview

The Azure Agentic AI Architect Labs reference implementation is a **production-grade enterprise AI platform** built on Microsoft Foundry and aligned with current best practices for security, observability, and scalability.

## High-Level System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      User/Application Layer                  │
│  (Web UI, Chat Interface, Slack Bot, Custom App)           │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│           API Gateway (APIM / App Gateway)                  │
│  • Authentication & authorization                            │
│  • Rate limiting & throttling                                │
│  • Request/response transformation                           │
│  • Logging & monitoring                                      │
└──────────────────────┬──────────────────────────────────────┘
                       │
                 (Private Link)
                       │
┌──────────────────────▼──────────────────────────────────────┐
│      Foundry Agent Service (Orchestration Core)             │
│  • Agent management & lifecycle                              │
│  • Tool orchestration & execution                            │
│  • Function calling & responses                              │
│  • Session & state management                                │
│  • Multi-turn conversation handling                          │
└──┬─────────────┬──────────────┬──────────────┬──────────────┘
   │             │              │              │
   │          (MCP)       (REST APIs)    (Managed ID)
   │             │              │              │
   ▼             ▼              ▼              ▼
┌───────────┐ ┌─────────┐ ┌──────────────┐ ┌────────────────┐
│  Azure    │ │  MCP    │ │ Azure AI     │ │ Azure OpenAI   │
│  AI       │ │ Servers │ │ Search       │ │ Service        │
│ Search    │ │ (Tools) │ │ (Hybrid RAG) │ │ (LLM Models)   │
│(Database) │ │         │ │              │ │                │
└───────────┘ └─────────┘ └──────────────┘ └────────────────┘
       │           │             │                │
       └───────────┴─────────────┴────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────────────────────┐
│                 Observability & Monitoring                   │
│  • Application Insights (Tracing, Metrics, Logs)            │
│  • Custom Dashboards & Alerts                                │
│  • Agent Performance Metrics                                 │
│  • Cost Analysis & FinOps                                    │
└──────────────────────────────────────────────────────────────┘
```

## Core Components

### 1. API Gateway (APIM or Application Gateway)

**Purpose:** Secure entry point, traffic management, request/response handling

**Key Features:**
- OAuth 2.0 / Azure AD authentication
- API key validation
- Rate limiting (per-user, per-API)
- Request/response logging
- Content transformation
- CORS policy management

**Why this matters:**
- Protects backend from direct exposure
- Enables API versioning and deprecation
- Centralizes security policies
- Provides analytics on API usage

### 2. Foundry Agent Service (Orchestration Core)

**Purpose:** Central intelligence orchestrating agents, tools, and conversations

**Key Features:**
- Agent lifecycle management
- Tool registration and invocation
- Function calling with structured outputs
- Conversation state persistence
- Multi-agent orchestration
- Safety & content filtering

**Why this matters:**
- Separates AI logic from infrastructure
- Provides Microsoft-aligned orchestration
- Handles complex agent workflows
- Integrates native Azure services

**Interacts with:**
- Azure OpenAI (LLM calls)
- Azure AI Search (RAG retrieval)
- MCP Servers (External tools)
- Application Insights (Tracing)

### 3. Azure AI Search with Hybrid Search

**Purpose:** Knowledge base and retrieval-augmented generation (RAG)

**Components:**
- Vector index (embeddings from Azure OpenAI)
- BM25 index (keyword search)
- Hybrid search combining both
- Semantic ranking for relevance
- Citation tracking for grounding

**Why this matters:**
- Grounds agent responses in real data
- Improves response accuracy
- Reduces hallucinations
- Enables domain-specific knowledge
- Supports multi-language search

**Architecture:**
```
Data Ingestion Pipeline
  ↓
Document chunking
  ↓
Embedding generation (Azure OpenAI Embedding model)
  ↓
Indexing
  ├─ Vector index (for semantic search)
  └─ BM25 index (for keyword search)
  ↓
Query Processing
  ├─ User query embedding
  ├─ Keyword search
  ├─ Hybrid search (combine both)
  └─ Semantic ranking
```

### 4. Model Context Protocol (MCP) Servers

**Purpose:** Securely integrate external tools and enterprise systems

**Examples:**
- Sales CRM tools (Salesforce, Dynamics)
- Knowledge management (SharePoint, Confluence)
- Business systems (ERP, accounting)
- Custom internal tools
- Public APIs (weather, news, data services)

**Why this matters:**
- Provides "hands" for agents (tool invocation)
- Standardizes tool integration
- Enables safe, isolated execution
- Reduces risk of prompt injection
- Allows tool approval workflows

**Security considerations:**
- Tools run in isolated containers
- Request/response validation
- Timeout enforcement
- Audit logging of tool use
- Rate limiting per tool

### 5. Azure OpenAI Service

**Purpose:** Large language models (LLMs) for reasoning and generation

**Models used:**
- `gpt-4-turbo` - Complex reasoning, multi-step tasks
- `gpt-4` - Balance of quality and cost
- `gpt-35-turbo` - Fast, cost-effective for simple tasks
- Text embedding model - Vector representations for RAG

**Why Azure OpenAI:**
- Data privacy (no training on your data)
- VNet integration
- Managed identity support
- Built-in content filtering
- Enterprise SLA

## Security Architecture

### Network Security

```
Public Internet
    │
    ├─ APIM Public Endpoint (Optional DDoS protection)
    │
    ▼
   (API Gateway)
    │
    ├─ (Private Link / Private Endpoint)
    │
    ▼
Private VNet
    ├─ Foundry Agent Service (Private endpoint)
    ├─ Azure AI Search (Private endpoint)
    ├─ Azure OpenAI (Private endpoint)
    └─ App Insights (Private endpoint)
```

**Key principles:**
- Zero-trust networking
- Private endpoints for all PaaS services
- No public IP exposure for backends
- Network isolation per environment
- Firewall rules restrict to required IPs

### Identity & Access Management

**Authentication layers:**
1. User auth → Azure AD → APIM
2. APIM → Foundry (managed identity)
3. Foundry → Azure services (managed identity)
4. No API keys in code or configuration

**RBAC roles:**
- Agent Developer (deploy, manage agents)
- Tool Administrator (manage MCP tools)
- Monitor Viewer (view metrics, logs)
- System Administrator (manage access)

### Data Protection

**Encryption:**
- In transit: TLS 1.2+ for all connections
- At rest: Azure Storage Service Encryption
- Keys managed in Azure Key Vault
- Customer-managed keys for sensitive data

**Data privacy:**
- Azure OpenAI does not train on user data
- Data residency controls (region selection)
- GDPR / regional compliance support
- Data retention policies enforced

## Observability & Monitoring

### Tracing

```
User Request
    ↓
API Gateway logs request
    ↓
Foundry Agent Service instruments execution
    ├─ Agent invocation
    ├─ Tool calls
    ├─ Latency per component
    └─ Token usage
    ↓
Application Insights ingests all events
    ↓
Traces available for debugging
```

### Key Metrics

**Performance:**
- Request latency (p50, p95, p99)
- Tool execution time
- Token usage (input, output, total cost)
- Cache hit rates

**Quality:**
- Agent response groundedness
- Retrieval relevance
- Tool success rate
- Error rate by type

**Safety:**
- Content filter violations
- Suspicious tool usage
- Rate limit breaches
- Failed authentication attempts

**Cost:**
- OpenAI tokens consumed
- Azure Search RUs used
- Storage consumption
- Network bandwidth

### Dashboards

ApplicationInsights provides dashboards for:
- Agent health & availability
- Performance trends
- Error analysis
- User behavior
- Cost breakdown

## Deployment & Infrastructure

### Bicep IaC

Infrastructure defined as code:
```bicep
module foundry 'modules/foundry.bicep' = {
  name: 'foundry-service'
  params: {
    location: location
    environment: environment
  }
}

module search 'modules/ai-search.bicep' = {
  name: 'search-service'
  params: {
    location: location
    vnetId: vnet.id
  }
}
```

**Benefits:**
- Reproducible deployments
- Version control for infrastructure
- Environment parity (dev, staging, prod)
- Disaster recovery & scaling

## Data Flow Examples

### Example 1: Question Answering

```
1. User asks: "What is our Q3 revenue?"
   ↓
2. API Gateway → Foundry Agent Service
   ↓
3. Agent decides: Need to search knowledge base
   ↓
4. Hybrid search in Azure AI Search
   - Keyword: "Q3 revenue"
   - Semantic: Similar documents
   ↓
5. Top results returned (with citations)
   ↓
6. Agent calls Azure OpenAI with:
   - User question
   - Retrieved documents
   - System prompt
   ↓
7. LLM generates grounded response
   ↓
8. Response logged to App Insights
   ↓
9. User receives answer with source citations
```

### Example 2: Tool Integration

```
1. User asks: "Create a customer record for ACME Corp"
   ↓
2. Agent recognizes need for CRM tool
   ↓
3. Agent calls MCP Server: crm-integration
   ↓
4. MCP validates request (auth, permissions)
   ↓
5. CRM tool creates record in Salesforce
   ↓
6. Response: "Created customer ID: 12345"
   ↓
7. Tool call logged to App Insights
   ↓
8. User receives confirmation
```

## Scaling Considerations

### Horizontal Scaling
- Foundry Agent Service: Auto-scale based on RPS
- Azure AI Search: Add replicas for query throughput
- APIM: Increase throughput units

### Optimization
- Caching for repeated queries
- Batch processing for bulk operations
- Asynchronous tool calls for long-running tasks
- Prompt compression to reduce token usage

### Cost Management
- Reserved capacity for predictable workloads
- Spot instances for non-critical components
- Model selection based on accuracy/cost trade-off
- Query optimization to reduce search RUs

## Design Decisions & Trade-offs

| Decision | Why | Trade-off |
|----------|-----|----------|
| Foundry for orchestration | Microsoft-aligned, native Azure integration | Learning curve if from different framework |
| Hybrid search (vector + BM25) | Better quality than vector alone | Higher complexity than simple keyword |
| MCP for tool integration | Standardized, secure, auditable | Additional abstraction layer |
| Private endpoints | Enhanced security, data residency | Slightly higher latency, complexity |
| Managed identity | No API keys in code | Requires proper Azure RBAC setup |
| Bicep for IaC | Native to Azure, first-class citizen | Not cloud-agnostic |

## Next Steps

- See [GOLDEN-PATH.md](./GOLDEN-PATH.md) for hands-on deployment
- See [QUICK-START.md](./QUICK-START.md) for 10-minute setup
- See [Module 01: Foundry Foundations](./01-foundry-foundations/) for detailed concepts
- See [Module 07: Secure Reference Architecture](./07-secure-reference-architecture/) for security deep-dive

## References

- [Azure Foundry Documentation](https://learn.microsoft.com/en-us/azure/foundry/)
- [Azure AI Search Hybrid Search](https://learn.microsoft.com/en-us/azure/search/hybrid-search-overview)
- [Foundry Agent Framework](https://github.com/microsoft/agent-framework)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Azure Architecture Center - AI Solutions](https://learn.microsoft.com/en-us/azure/architecture/ai-ml/)
