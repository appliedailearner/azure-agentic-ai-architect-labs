# Multi-Agent Research Assistant

## Overview

This portfolio project demonstrates an advanced multi-agent system where specialized agents collaborate to solve complex research tasks. The coordinator agent orchestrates worker agents to gather, analyze, and validate information, showcasing production-grade agent collaboration patterns on Azure.

## Architecture

```
User Query
    ↓
[Coordinator Agent]
    ↓  ↓  ↓
[Research] [Analysis] [Validation]
Agent      Agent      Agent
    ↓      ↓         ↓
[External APIs] [Data Sources] [Fact Checkers]
    ↓      ↓         ↓
[Azure OpenAI]
    ↓
Final Response with Sources
```

### Agent Workflow

**1. Coordinator Agent**
- Receives research request
- Decomposes task into subtasks
- Orchestrates worker agents
- Merges results and provides final response

**2. Research Agent**
- Gathers information from multiple sources
- Calls external APIs (news, weather, stocks)
- Manages API rate limits and fallbacks
- Caches results for cost efficiency

**3. Analysis Agent**
- Synthesizes information from research
- Identifies patterns and trends
- Performs statistical summarization
- Enriches with domain-specific insights

**4. Validation Agent**
- Fact-checks findings
- Identifies conflicting information
- Assigns confidence scores
- Flags uncertain claims for human review

## Azure Services Used

### AI & Orchestration
- **Azure OpenAI**: GPT-4 for agent reasoning and decision-making
- **Azure AI Foundry**: Agent hosting and monitoring
- **Semantic Kernel**: Agent framework and plugin system

### Compute & Integration
- **Azure Functions**: Serverless API integration handlers
- **Azure Service Bus**: Message queue for agent coordination
- **Azure Logic Apps**: Workflow orchestration (optional)

### Data & Caching
- **Azure Cache for Redis**: Query and API response caching
- **Azure Cosmos DB**: Agent conversation history and state
- **Azure Table Storage**: Agent execution logs

### Monitoring
- **Application Insights**: Agent performance metrics
- **Azure Monitor**: Resource utilization
- **Log Analytics**: Agent decision traces

## Agent Orchestration Architecture

### Orchestration Pattern: Hierarchical with Feedback Loops

```python
class CoordinatorAgent:
    async def execute(self, query: str) -> Response:
        # 1. Plan: Decompose task
        plan = await self.planner.plan(query)
        
        # 2. Execute: Run agents in parallel
        research_task = research_agent.gather_info(plan.research_topics)
        analysis_task = analysis_agent.analyze(plan.data_sources)
        
        research_results = await research_task
        analysis_results = await analysis_task
        
        # 3. Validate: Check quality
        validation = await validation_agent.validate(
            research_results,
            analysis_results
        )
        
        # 4. Synthesize: Merge with confidence scores
        return await self.synthesizer.merge(
            research_results,
            analysis_results,
            validation
        )
```

## Architecture Decisions & Rationale

### 1. Hierarchical Orchestration vs Flat Networks
**Decision**: Use coordinator pattern with specialized workers

**Rationale**:
- Single point of control for task decomposition
- Easier to debug and trace decisions
- Natural scaling pattern (add more workers)
- Simpler cost management and rate limiting

### 2. Parallel Execution with Timeouts
**Decision**: Execute agents in parallel with graceful degradation

**Rationale**:
- Reduces latency from sequential (10s) to parallel (3-4s)
- One slow agent doesn't block others
- Partial results still valuable for users
- Better resource utilization of compute

### 3. Validation as Separate Agent
**Decision**: Build validation as independent agent vs inline checks

**Rationale**:
- Separates concerns (generation vs verification)
- Can be run async for non-critical paths
- Easier to update validation rules
- Enables A/B testing of fact-checking strategies

### 4. Agent State in Cosmos DB
**Decision**: Persist agent state vs ephemeral memory

**Rationale**:
- Resume interrupted conversations
- Audit trail for compliance
- Learn from agent decisions over time
- Enable multi-turn sessions

## Tool Integration Strategy

### Tool Definition Pattern
```python
@research_agent.define_tool()
async def search_news_api(query: str, days_back: int = 7) -> List[Article]:
    """
    Search recent news articles.
    
    Args:
        query: Search keywords
        days_back: Only articles from last N days
    
    Returns:
        List of articles with title, source, date, summary
    """
    # Implementation with rate limiting and caching
    cached_key = f"news_{query}_{days_back}"
    if cache.exists(cached_key):
        return cache.get(cached_key)
    
    results = await call_external_api(query, days_back)
    cache.set(cached_key, results, ttl=3600)
    return results
```

### Tool Registry
- News API (NewsAPI.org)
- Stock Data API (Alpha Vantage)
- Weather API (OpenWeatherMap)
- Wikipedia API (summaries)
- Custom internal APIs

## Planning & Reasoning

### Query Decomposition Strategy

```
User Query: "What are the latest trends in AI and how will they affect stock market?"

Coordinator Decomposition:
1. Research Tasks:
   - Find latest AI breakthroughs (last 30 days)
   - Identify key AI companies
   - Gather market sentiment about AI

2. Analysis Tasks:
   - Correlate AI news with stock movements
   - Identify winning/losing stocks
   - Assess market timing

3. Validation Tasks:
   - Verify stock price accuracy
   - Check fact claims
   - Assess confidence levels
```

## Cost Optimization

### Strategies

1. **Tool Call Caching**
   - Cache API responses for 1-24 hours
   - Reduces redundant API calls by 70%
   - Cost savings: $200-400/month

2. **Agent Model Tiering**
   - Coordinator: GPT-4 (complex reasoning)
   - Workers: GPT-35-Turbo (specific tasks)
   - Analyzer: GPT-35-Turbo (synthesis)
   - Saves 40% on token costs

3. **Parallel Execution**
   - Avoid sequential agent calls
   - Reduces total latency and OpenAI calls
   - Enables more concurrent users

4. **Fallback Strategies**
   - If API unavailable, use cached results
   - Degrade gracefully vs failing entirely
   - Maintain service SLA

### Cost Estimate (1000 research queries/month)
- Azure OpenAI: $800-1,200
- Azure Functions: $50-100
- Cosmos DB: $100-200
- Redis Cache: $50-75
- Total: ~$1,000-1,575/month

## Deployment & Scaling

### Container-Based Deployment
```yaml
# Kubernetes deployment for coordinator
apiVersion: apps/v1
kind: Deployment
metadata:
  name: coordinator-agent
spec:
  replicas: 3
  template:
    spec:
      containers:
      - name: coordinator
        image: coordinator-agent:latest
        env:
        - name: OPENAI_ENDPOINT
          valueFrom:
            secretKeyRef:
              name: azure-secrets
              key: openai-endpoint
```

### Worker Agent Scaling
- Research Agent: 5 replicas
- Analysis Agent: 3 replicas
- Validation Agent: 2 replicas
- Auto-scale based on queue depth

## Key Deliverables

- ✅ Multi-agent architecture diagram (docs/agent-architecture.png)
- ✅ Orchestration code (src/coordinator_agent.py)
- ✅ Worker agent implementations (src/workers/)
- ✅ Tool integration framework (src/tools/)
- ✅ Deployment manifests (deploy/kubernetes/)
- ✅ Agent communication protocols (docs/MESSAGE_PROTOCOL.md)

## Design Patterns Demonstrated

1. **Supervisor Pattern**: Coordinator oversees worker agents
2. **Pipeline Pattern**: Sequential processing stages
3. **Publish-Subscribe**: Agent communication via Service Bus
4. **Bulkhead**: Isolate critical paths from experimental agents
5. **Circuit Breaker**: Fallback when external APIs fail

## Lessons Learned

1. **Agent Prompt Engineering**: Clear task descriptions critical for worker quality
2. **Timeout Tuning**: Must balance waiting for good answers vs user latency
3. **Cost Management**: Tool calling can explode costs without rate limiting
4. **Error Handling**: Agents should retry with degraded data vs fail completely
5. **Monitoring Complexity**: Need detailed traces to debug multi-agent issues

## Improvements & Future Work

- [ ] Add dynamic agent creation for scaling
- [ ] Implement agent learning from validation feedback
- [ ] Add cost prediction per query
- [ ] Build agent performance benchmarking
- [ ] Extend to support human-in-the-loop validation

## References

- [Semantic Kernel GitHub](https://github.com/microsoft/semantic-kernel)
- [Azure AI Foundry Documentation](https://learn.microsoft.com/en-us/azure/ai-foundry/)
- [Agent-Oriented Design Patterns](https://arxiv.org/abs/2308.08155)
