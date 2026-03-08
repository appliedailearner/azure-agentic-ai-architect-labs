from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["module"] == "05-rag-with-azure-ai-search"


def test_retrieve_returns_grounded_response():
    response = client.post("/retrieve", json={"query": "Azure AI Search grounding"})
    assert response.status_code == 200
    payload = response.json()
    assert payload["query"] == "Azure AI Search grounding"
    assert len(payload["documents"]) >= 1
    assert "Grounded context" in payload["grounded_answer"]
