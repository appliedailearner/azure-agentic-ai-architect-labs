from typing import List

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="Azure Agentic AI - 07-secure-reference-architecture")


class SecurityControl(BaseModel):
    name: str
    enabled: bool
    severity: str


class SecurityAssessmentRequest(BaseModel):
    controls: List[SecurityControl]


class SecurityAssessmentResponse(BaseModel):
    total_controls: int
    enabled_controls: int
    failed_controls: List[str]
    risk_level: str


def assess_controls(controls: list[SecurityControl]) -> SecurityAssessmentResponse:
    failed = [control.name for control in controls if not control.enabled]
    enabled = sum(1 for control in controls if control.enabled)

    risk_level = "low"
    if len(failed) >= 1:
        risk_level = "medium"
    if any(control.severity == "high" and not control.enabled for control in controls):
        risk_level = "high"

    return SecurityAssessmentResponse(
        total_controls=len(controls),
        enabled_controls=enabled,
        failed_controls=failed,
        risk_level=risk_level,
    )


@app.get("/health")
def health_check():
    return {"status": "healthy", "module": "07-secure-reference-architecture"}


@app.post("/assess", response_model=SecurityAssessmentResponse)
def assess(request: SecurityAssessmentRequest):
    return assess_controls(request.controls)


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
