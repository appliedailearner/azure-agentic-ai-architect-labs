# Enterprise RAG Assistant Architecture

This lab module focuses on building production-ready Retrieval-Augmented Generation (RAG) solutions on Azure.

### Learning Objectives:
* • Implement hybrid search using Azure AI Search
* • Optimize document chunking and embedding strategies
* • Design secure RAG architectures with Private Endpoints
* • Implement citation and grounding to minimize hallucinations
* • Evaluate RAG performance with RAGAS and Azure AI Evaluation

### Lab Contents:
* • **Lab 1**: Setting up Azure AI Search for Vector and Hybrid search
* • **Lab 2**: Advanced Chunking and Embedding patterns
* • **Lab 3**: Building the RAG Pipeline with Semantic Kernel
* • **Lab 4**: Implementing Citations and Grounding
* • **Lab 5**: Evaluation and Observability with Azure AI Studio

---

## Project Overview: Enterprise RAG Knowledge Agent

This portfolio project demonstrates a production-ready Retrieval-Augmented Generation (RAG) platform that grounds AI responses in enterprise documents. The agent intelligently retrieves relevant context from a vector-indexed knowledge base and generates accurate, sourced answers.

### Architecture
`User Request ↓ [API/Frontend] ↓ [Semantic Kernel Agent] ↓ [Azure OpenAI] ← Vector Embeddings ↓ [Azure AI Search] ← Document Index ↓ [Azure Storage] (Documents)`

### Data Flow
1. **User Query**: User submits question via API or chat interface
2. **Agent Processing**: Semantic Kernel agent analyzes intent and generates search embeddings
3. **Vector Search**: Azure AI Search performs semantic similarity search against indexed documents
4. **Context Retrieval**: Top-K relevant documents are retrieved with metadata
5. **Response Generation**: Azure OpenAI generates response grounded in retrieved context
6. **Response Delivery**: Answer returned with source citations

### Azure Services Used
* **Azure OpenAI**: GPT-4 or GPT-3.5-Turbo for response generation and embeddings
* **Azure AI Search**: Vector indexing and semantic search capabilities
* **Azure Storage (Blob)**: Secure document storage with versioning
* **Managed Identity**: Service-to-service authentication without secrets
* **Private Endpoints**: Network isolation for all Azure services

### Architecture Decisions & Rationale
1. **Vector Search Strategy**: Use Azure AI Search for hybrid search (BM25 + vector) to provide better relevance.
2. **Semantic Kernel**: Used for first-class Azure OpenAI integration and native function composition.
3. **Managed Identity**: Eliminates credential rotation complexity and enhances security.

### Key Deliverables
* ✅ Architecture diagram
* ✅ Terraform deployment scripts
* ✅ Document ingestion pipeline
* ✅ Semantic Kernel agent functions
* ✅ Security configuration guide
