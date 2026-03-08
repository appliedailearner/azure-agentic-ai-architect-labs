from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["module"] == "07-secure-reference-architecture"


def test_assessment_returns_high_risk_for_failed_high_severity_control():
    payload = {
        "controls": [
            {"name": "managed-identity", "enabled": True, "severity": "high"},
            {"name": "private-endpoints", "enabled": False, "severity": "high"},
            {"name": "https-only", "enabled": True, "severity": "medium"},
        ]
    }
    response = client.post("/assess", json=payload)
    assert response.status_code == 200
    body = response.json()
    assert body["total_controls"] == 3
    assert body["enabled_controls"] == 2
    assert "private-endpoints" in body["failed_controls"]
    assert body["risk_level"] == "high"
