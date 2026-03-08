# Azure Agentic AI Architect Labs

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![License](https://img.shields.io/badge/license-MIT-blue)

Hands-on labs and architecture patterns for building **enterprise Agentic AI solutions** on Azure using **Microsoft Foundry**, **Agent Framework**, **Azure OpenAI**, **Semantic Kernel**, **Azure AI Search**, and **Model Context Protocol (MCP)**.

## 📄 Quick Navigation

- **New here?** Start with [QUICK-START.md](./QUICK-START.md) (10 minutes)
- **Have 20 hours?** Follow [GOLDEN-PATH.md](./09-end-to-end-reference-implementation/GOLDEN-PATH.md)
- **Want the full curriculum?** See [Full Curriculum](#full-curriculum) below
- **Need architecture help?** See [ARCHITECTURE.md](./ARCHITECTURE.md)

## 🌟 What Is This Repository?

This is a **production-grade reference curriculum** for building Agentic AI solutions aligned to current Microsoft guidance. Unlike scattered tutorials, this repo provides:

✅ **Runnable code** - Every lab has working Python examples  
✅ **Infrastructure-as-Code** - Bicep templates for Azure services  
✅ **Architecture patterns** - Real-world scenarios with trade-offs  
✅ **Security by design** - Zero-trust, private endpoints, managed identity  
✅ **Evaluation frameworks** - Quality, safety, and reliability validation  
✅ **Observability** - Tracing, monitoring, and cost analysis  
✅ **Production ready** - Red teaming, failure analysis, operational guidance  

## 📃 Module Status

| Module | Status | Runnable | Code | IaC |
|--------|--------|----------|------|-----|
| 01 - Foundry Foundations | 🟢 Complete | ✅ | ✅ | ✅ |
| 02 - Foundry Agent Service | 🟢 Complete | ✅ | ✅ | ✅ |
| 03 - Semantic Kernel Track | 🟡 In Progress | ⚠️ | ✅ | 🔄 |
| 04 - Agent Framework & Multi-Agent | 🟢 Complete | ✅ | ✅ | ✅ |
| 05 - RAG with Azure AI Search | 🟢 Complete | ✅ | ✅ | ✅ |
| 06 - MCP & Enterprise Tooling | 🟡 In Progress | ⚠️ | ✅ | 🔄 |
| 07 - Secure Reference Architecture | 🟢 Complete | ✅ | ✅ | ✅ |
| 08 - Observability & Evaluation | 🟢 Complete | ✅ | ✅ | ✅ |
| 09 - End-to-End Reference (Golden Path) | 🟢 Complete | ✅ | ✅ | ✅ |

**Legend:** 🟢 Complete | 🟡 In Progress | ✅ Available | ⚠️ Partial | 🔄 WIP

## 🚀 Golden Path (Start Here!)

**If you have 15-20 hours and want a working solution immediately:**

```
09-end-to-end-reference-implementation/GOLDEN-PATH.md
  ✕ Deploy full stack with Bicep
  ✕ Run validation tests
  ✕ Customize tools and re-deploy
  ✕ Run evaluations and analyze costs
```

**Outcome:** Complete working Agentic AI solution with production patterns

**Time:** 15-20 hours

See [GOLDEN-PATH.md](./09-end-to-end-reference-implementation/GOLDEN-PATH.md) for detailed walkthrough.

## 📚 Full Curriculum

### Learning Path 1: Microsoft Foundry Focus (Recommended)

Build on **current Microsoft direction** using **Foundry Agent Service** as orchestration backbone.

1. **[01 - Foundry Foundations](./01-foundry-foundations/README.md)** (3-4 hrs)
   - Core concepts, projects, models, deployments
   - Azure OpenAI service architecture
   - Authentication, networking, cost basics

2. **[02 - Foundry Agent Service Core](./02-foundry-agent-service-core/README.md)** (4-5 hrs)
   - Building agents with Foundry
   - Tool integration and execution
   - State management and orchestration

3. **[05 - RAG with Azure AI Search](./05-rag-with-azure-ai-search/README.md)** (4-5 hrs)
   - Chunking strategies and embeddings
   - Hybrid search setup and semantic ranking
   - RAG evaluation and grounding validation

4. **[06 - MCP & Enterprise Tooling](./06-mcp-and-enterprise-tooling/README.md)** (3-4 hrs)
   - Model Context Protocol (MCP) fundamentals
   - Remote server setup and authentication
   - APIM gateway patterns for agent access

5. **[07 - Secure Reference Architecture](./07-secure-reference-architecture/README.md)** (3-4 hrs)
   - Private endpoints and DNS
   - Managed identity and RBAC
   - Zero-trust implementation

6. **[08 - Observability & Evaluation](./08-observability-evaluation-red-teaming/README.md)** (3-4 hrs)
   - Application Insights tracing
   - Agent evaluation frameworks
   - Red teaming and failure analysis

**Total:** ~20-26 hours | **Best for:** Production deployments, architects

### Learning Path 2: Semantic Kernel Focus

Alternative if your architecture prefers **Semantic Kernel** for orchestration.

1. Start with **01-Foundry Foundations**
2. Follow **03-Semantic Kernel Track** instead of module 02
3. Continue with modules 05-08

**Total:** ~20-26 hours | **Best for:** Teams using SK microservices patterns

### Learning Path 3: Agent Framework Deep Dive

For understanding **Microsoft Agent Framework** patterns and multi-agent orchestration.

1. Start with **01-Foundry Foundations**
2. Follow **02-Foundry Agent Service Core**
3. Deep dive: **04-Agent Framework & Multi-Agent**
4. Continue with modules 05-08

**Best for:** Advanced users, hierarchical workflows, multi-agent systems

## 👨‍💼 Audience & Prerequisites

**This is for:**
- Azure Cloud Architects building AI solutions
- AI Engineers implementing Agentic patterns
- Enterprise developers integrating AI with existing systems
- Serious learners pursuing Azure AI certifications

**Before starting, have:**
- Azure subscription with appropriate permissions
- Python 3.9+ and familiarity with REST APIs
- Understanding of cloud architecture basics
- 20+ hours available for full curriculum (or 15-20 for golden path)

## ⚡ Quick Start (10 minutes)

### Prerequisites

```bash
# Install Python 3.9+
python --version

# Clone this repository
git clone https://github.com/appliedailearner/azure-agentic-ai-architect-labs.git
cd azure-agentic-ai-architect-labs

# Install dependencies
pip install -r requirements.txt
```

### Deploy the Golden Path

```bash
cd 09-end-to-end-reference-implementation/deployment

# Copy and configure environment
cp .env.example .env
# Edit .env with your Azure subscription details

# Deploy using Bicep
./deploy.sh

# Validate deployment
./verify-deployment.sh
```

**See [QUICK-START.md](./QUICK-START.md) for detailed walkthrough.**

## 📁 Repository Structure

```
.
├── 01-foundry-foundations/              # Core Foundry concepts
├── 02-foundry-agent-service-core/      # Agent Service patterns
├── 03-semantic-kernel-track/          # SK orchestration (alternative)
├── 04-agent-framework-and-multi-agent/ # Agent Framework patterns
├── 05-rag-with-azure-ai-search/       # Hybrid RAG & evaluation
├── 06-mcp-and-enterprise-tooling/     # MCP & APIM integration
├── 07-secure-reference-architecture/  # Zero-trust & security
├── 08-observability-evaluation-red-teaming/ # Monitoring & safety
├── 09-end-to-end-reference-implementation/ # GOLDEN PATH
├── docs/                                # Guides, FAQs, templates
├── diagrams/                            # Architecture diagrams
├── .github/workflows/                  # CI/CD pipelines
├── README.md                            # This file
├── ARCHITECTURE.md                     # Architecture overview
├── GOLDEN-PATH.md                      # Golden path detailed guide
├── QUICK-START.md                      # 10-minute quick start
├── CONTRIBUTING.md                     # Contribution guidelines
└── LICENSE                             # MIT License
```

## 🔗 Official References

### Microsoft Learn & Documentation
- [Azure Foundry Documentation](https://learn.microsoft.com/en-us/azure/foundry/)
- [Develop AI Agents with Azure](https://learn.microsoft.com/en-us/training/modules/develop-ai-agent-azure/)
- [Agent Framework GitHub](https://github.com/microsoft/agent-framework)
- [Semantic Kernel GitHub](https://github.com/microsoft/semantic-kernel)
- [Azure AI Search Documentation](https://learn.microsoft.com/en-us/azure/search/)
- [Azure AI Foundry Security Baseline](https://learn.microsoft.com/en-us/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline)

### Sample Repositories
- [Azure AI Foundry Agent Samples](https://github.com/Azure-Samples/ai-foundry-agents-samples)
- [Get Started with AI Agents](https://github.com/Azure-Samples/get-started-with-ai-agents)
- [Azure Search OpenAI Demo](https://github.com/Azure-Samples/azure-search-openai-demo)
- [Microsoft Foundry Baseline](https://github.com/Azure-Samples/microsoft-foundry-baseline)

### Videos
- [Microsoft Learn YouTube Channel](https://www.youtube.com/@MicrosoftLearn)
- [Azure AI Agent Patterns](https://www.youtube.com/watch?v=ltt7JNd30Ag)

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

### How to Help

- **Improve modules** - Add missing documentation, code examples, or tests
- **Fix bugs** - Report issues or submit PRs
- **Add examples** - Share your real-world patterns and implementations
- **Enhance IaC** - Improve Bicep templates or add Terraform equivalents
- **Expand evaluation** - Add new evaluation metrics or red team scenarios

## 💫 Support & Questions

- **GitHub Issues** - Report bugs or suggest improvements
- **Discussions** - Ask questions and share ideas
- **Reach out** - Contact [@appliedailearner](https://github.com/appliedailearner)

## 📄 License

MIT License - See [LICENSE](./LICENSE) file for details

---

**Created by [Applied AI Learner](https://github.com/appliedailearner)**  
Aligned with Microsoft Azure AI Foundry and Agent Framework best practices.

Last Updated: March 2026
