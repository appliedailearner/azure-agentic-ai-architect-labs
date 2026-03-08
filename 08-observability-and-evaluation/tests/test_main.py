from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["module"] == "08-observability-and-evaluation"


def test_evaluation_summary():
    payload = {
        "signals": [
            {"latency_ms": 400, "success": True, "grounded": True},
            {"latency_ms": 600, "success": True, "grounded": True},
            {"latency_ms": 700, "success": False, "grounded": False},
        ]
    }
    response = client.post("/evaluate", json=payload)
    assert response.status_code == 200
    body = response.json()
    assert body["total_requests"] == 3
    assert body["status"] in {"warning", "critical", "healthy"}
    assert body["avg_latency_ms"] > 0
