from typing import List

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="Azure Agentic AI - 05-rag-with-azure-ai-search")


class RetrieveRequest(BaseModel):
    query: str


class RetrieveResponse(BaseModel):
    query: str
    documents: List[dict]
    grounded_answer: str


KNOWLEDGE_BASE = [
    {
        "id": "rag-001",
        "content": "Azure AI Search can be used as the retrieval layer for enterprise RAG patterns.",
        "tags": ["azure-ai-search", "rag"],
    },
    {
        "id": "rag-002",
        "content": "A grounded answer should reflect retrieved content and avoid broader unsupported claims.",
        "tags": ["grounding", "response-quality"],
    },
    {
        "id": "rag-003",
        "content": "Enterprise RAG should separate retrieval, orchestration, and tool boundaries clearly.",
        "tags": ["architecture", "enterprise-rag"],
    },
]


def retrieve_documents(query: str) -> list[dict]:
    lowered = query.lower()
    matches = [
        doc for doc in KNOWLEDGE_BASE
        if any(term in doc["content"].lower() for term in lowered.split())
    ]
    return matches[:2] if matches else KNOWLEDGE_BASE[:1]


def build_grounded_answer(query: str, documents: list[dict]) -> str:
    sources = "; ".join(doc["content"] for doc in documents)
    return f"Query: {query}. Grounded context: {sources}"


@app.get("/health")
def health_check():
    return {"status": "healthy", "module": "05-rag-with-azure-ai-search"}


@app.post("/retrieve", response_model=RetrieveResponse)
def retrieve(request: RetrieveRequest):
    documents = retrieve_documents(request.query)
    return RetrieveResponse(
        query=request.query,
        documents=documents,
        grounded_answer=build_grounded_answer(request.query, documents),
    )


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
