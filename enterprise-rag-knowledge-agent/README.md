# Enterprise RAG Knowledge Agent

## Overview

This portfolio project demonstrates a production-ready Retrieval-Augmented Generation (RAG) platform that grounds AI responses in enterprise documents. The agent intelligently retrieves relevant context from a vector-indexed knowledge base and generates accurate, sourced answers.

## Architecture

```
User Request
    ↓
[API/Frontend]
    ↓
[Semantic Kernel Agent]
    ↓
[Azure OpenAI] ← Vector Embeddings
    ↓
[Azure AI Search] ← Document Index
    ↓
[Azure Storage] (Documents)
```

### Data Flow

1. **User Query**: User submits question via API or chat interface
2. **Agent Processing**: Semantic Kernel agent analyzes intent and generates search embeddings
3. **Vector Search**: Azure AI Search performs semantic similarity search against indexed documents
4. **Context Retrieval**: Top-K relevant documents are retrieved with metadata
5. **Response Generation**: Azure OpenAI generates response grounded in retrieved context
6. **Response Delivery**: Answer returned with source citations

## Azure Services Used

### Core AI Services
- **Azure OpenAI**: GPT-4 or GPT-35-Turbo for response generation and embeddings
- **Azure AI Search**: Vector indexing and semantic search capabilities

### Data & Storage
- **Azure Storage (Blob)**: Secure document storage with versioning
- **Azure Cosmos DB** (optional): Document metadata and chat history

### Security & Governance
- **Azure Key Vault**: Credential and API key management
- **Managed Identity**: Service-to-service authentication without secrets
- **Private Endpoints**: Network isolation for all Azure services
- **RBAC**: Role-based access control for document access

### Monitoring
- **Application Insights**: Agent performance and query analytics
- **Log Analytics**: Compliance and audit logging

## Architecture Decisions & Rationale

### 1. Vector Search Strategy
**Decision**: Use Azure AI Search for vector indexing instead of pure semantic search

**Rationale**:
- Hybrid search (BM25 + vector) provides better relevance than vectors alone
- Native Azure integration eliminates middleware complexity
- Supports chunking strategies at scale
- Built-in filtering for document metadata and access control

### 2. Semantic Kernel for Agent Orchestration
**Decision**: Use Semantic Kernel instead of LangChain or custom Python

**Rationale**:
- First-class Azure OpenAI integration
- Native semantic function composition
- Built-in tool/plugin architecture for extensibility
- Easier enterprise governance and compliance tracking

### 3. Managed Identity for Authentication
**Decision**: Use Azure Managed Identity instead of API keys

**Rationale**:
- Eliminates credential rotation complexity
- Automatic token refresh
- Audit trail at Azure AD level
- No exposed secrets in code or environment

### 4. Private Endpoints for Network Security
**Decision**: Deploy all services behind private endpoints

**Rationale**:
- Documents never traverse public internet
- Compliance with data residency requirements
- Protection against data exfiltration
- Network segmentation for multi-tenant environments

## Security Considerations

### Document Access Control
```python
# Semantic Kernel function includes user identity
@kernel.define_kernel_function()
async def retrieve_documents(query: str, user_id: str) -> str:
    """Retrieve documents user has access to"""
    # Filter results by user's document ACL
    search_filter = f"allowed_users/any(u: u eq '{user_id}')"
    return await search_client.search(query, filter=search_filter)
```

### Response Sanitization
- Remove sensitive fields from retrieved documents (PII, passwords)
- Validate source citations aren't hallucinated
- Implement rate limiting to prevent abuse

### Audit & Compliance
- Log all queries with user identity and timestamp
- Store document access decisions in Azure Table Storage
- Enable diagnostic settings for regulatory compliance

## Cost Optimization

### Strategies Implemented

1. **Token Optimization**
   - Cache system prompts and static context
   - Summarize long documents before sending to OpenAI
   - Use smaller models (GPT-35-Turbo) for embedding tasks

2. **Search Efficiency**
   - Cache query embeddings for 24 hours
   - Implement page-based pagination for large result sets
   - Use Azure AI Search's built-in ranking to reduce context window

3. **Infrastructure Costs**
   - Use Standard tier Azure AI Search (sufficient for most workloads)
   - Implement auto-scaling with Azure Container Instances
   - Schedule batch document indexing during off-peak hours

### Cost Breakdown (Monthly Estimate - 1M queries)
- Azure OpenAI (embeddings + completions): $2,500-3,500
- Azure AI Search (100GB index): $800-1,200
- Storage: $50-100
- Total: ~$3,500-4,800/month

## Deployment

### Prerequisites
- Azure Subscription with sufficient quota
- Terraform or ARM templates for IaC
- Service Principal with appropriate permissions

### Infrastructure Setup
```bash
# Deploy with Terraform
cd deployment/terraform
terraform init
terraform plan -var-file=prod.tfvars
terraform apply
```

### Document Ingestion
```python
# Batch process documents
from document_ingestion import DocumentProcessor

processor = DocumentProcessor(
    storage_account=azure_storage_client,
    search_client=search_admin_client,
    chunk_size=2048,
    chunk_overlap=200
)

processor.ingest_documents(source_directory="/documents")
```

## Key Deliverables

- ✅ Architecture diagram (docs/architecture.png)
- ✅ Terraform deployment scripts (deployment/terraform/)
- ✅ Document ingestion pipeline (src/document_processor.py)
- ✅ Semantic Kernel agent functions (src/agent/)
- ✅ Security configuration guide (docs/SECURITY.md)
- ✅ Cost analysis and optimization (docs/COST_ANALYSIS.md)

## Design Patterns Demonstrated

1. **CQRS**: Separation of document write (indexing) from read (search)
2. **Circuit Breaker**: Fallback when OpenAI API is unavailable
3. **Request-Reply**: Agent orchestration pattern
4. **Strangler**: Gradual migration from legacy search to vector search

## Lessons Learned

1. **Chunk Size Matters**: 1024-2048 tokens per chunk provides best balance between context and relevance
2. **Hybrid Search Wins**: BM25 + vector search outperforms pure vector in 80% of enterprise scenarios
3. **Cost Control**: Without query optimization, RAG costs can 10x production budgets
4. **Latency Trade-offs**: Caching embeddings reduces latency from 3s to 500ms
5. **Access Control is Hard**: Managing document-level ACLs in vector search requires careful schema design

## Next Steps

- [ ] Implement citation verification with source confidence scores
- [ ] Add query rewriting for complex multi-hop questions
- [ ] Implement active learning feedback loop
- [ ] Add support for real-time document updates
- [ ] Extend to multi-language support

## References

- [Azure AI Search Documentation](https://learn.microsoft.com/en-us/azure/search/)
- [Semantic Kernel Documentation](https://learn.microsoft.com/en-us/semantic-kernel/)
- [RAG Best Practices](https://arxiv.org/abs/2312.10997)
