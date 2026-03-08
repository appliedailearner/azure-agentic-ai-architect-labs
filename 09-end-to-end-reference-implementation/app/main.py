"""FastAPI Application for Azure Agentic AI.

Main application entry point with REST API endpoints for agent interaction.
"""

import logging
from contextlib import asynccontextmanager
from typing import Dict, Any

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

from app.config import get_settings
from app.agents import SemanticKernelAgent, AgentOrchestrator, AgentRole

logger = logging.getLogger(__name__)
settings = get_settings()


class AgentRequest(BaseModel):
    """Request model for agent execution."""

    prompt: str
    agent_id: str = "default"
    temperature: float = 0.7
    max_tokens: int = 2048


class AgentResponse(BaseModel):
    """Response model from agent."""

    status: str
    response: str
    agent_id: str
    model: str


class OrchestratorRequest(BaseModel):
    """Request for multi-agent orchestration."""

    task: str
    agents: list[str] = ["planner", "executor"]


class OrchestratorResponse(BaseModel):
    """Response from orchestrator."""

    status: str
    results: Dict[str, Any]
    total_execution_time: float


# Initialize agents
agent = SemanticKernelAgent(
    name="default",
    description="Default Semantic Kernel Agent",
    model=settings.openai_model,
)

orchestrator = AgentOrchestrator(name="main")
orchestrator.register_agent("default", agent, AgentRole.EXECUTOR)


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Application lifespan context manager."""
    logger.info(f"✅ {settings.app_name} v{settings.app_version} started")
    yield
    logger.info(f"❌ {settings.app_name} shutdown")


app = FastAPI(
    title=settings.app_name,
    description="Azure Agentic AI Reference Implementation",
    version=settings.app_version,
    lifespan=lifespan,
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/health")
async def health_check() -> Dict[str, str]:
    """Health check endpoint."""
    return {
        "status": "healthy",
        "app": settings.app_name,
        "version": settings.app_version,
    }


@app.post("/agents/invoke", response_model=AgentResponse)
async def invoke_agent(request: AgentRequest) -> AgentResponse:
    """Invoke an agent with a prompt.

    Args:
        request: Agent execution request

    Returns:
        Agent execution response

    Raises:
        HTTPException: If agent execution fails
    """
    try:
        logger.info(f"Invoking agent {request.agent_id} with prompt: {request.prompt[:50]}...")

        result = await agent.execute(
            prompt=request.prompt,
            temperature=request.temperature,
            max_tokens=request.max_tokens,
        )

        return AgentResponse(
            status=result["status"],
            response=result["response"],
            agent_id=request.agent_id,
            model=result["model"],
        )

    except Exception as e:
        logger.error(f"Error invoking agent: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/agents/status")
async def agent_status() -> Dict[str, Any]:
    """Get agent status."""
    return {
        "agent_id": "default",
        "name": agent.name,
        "description": agent.description,
        "status": "ready",
        "model": agent.model,
    }


@app.post("/orchestrate", response_model=OrchestratorResponse)
async def orchestrate(request: OrchestratorRequest) -> OrchestratorResponse:
    """Execute task using agent orchestrator.

    Args:
        request: Orchestration request

    Returns:
        Orchestration results

    Raises:
        HTTPException: If orchestration fails
    """
    try:
        logger.info(f"Orchestrating task with agents: {request.agents}")

        results = await orchestrator.execute_sequential(
            agent_ids=request.agents,
            prompt=request.task,
        )

        return OrchestratorResponse(
            status="success",
            results=results,
            total_execution_time=0.0,
        )

    except Exception as e:
        logger.error(f"Error orchestrating: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/")
async def root() -> Dict[str, str]:
    """Root endpoint."""
    return {
        "message": "Welcome to Azure Agentic AI",
        "version": settings.app_version,
        "docs": "/docs",
        "openapi": "/openapi.json",
    }


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(
        "app.main:app",
        host=settings.api_host,
        port=settings.api_port,
        workers=settings.api_workers,
        reload=settings.debug,
    )
