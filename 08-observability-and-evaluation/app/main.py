from statistics import mean
from typing import List

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="Azure Agentic AI - 08-observability-and-evaluation")


class EvaluationSignal(BaseModel):
    latency_ms: int
    success: bool
    grounded: bool


class EvaluationRequest(BaseModel):
    signals: List[EvaluationSignal]


class EvaluationSummary(BaseModel):
    total_requests: int
    success_rate: float
    grounded_rate: float
    avg_latency_ms: float
    status: str


def summarize(signals: list[EvaluationSignal]) -> EvaluationSummary:
    total = len(signals)
    success_rate = sum(1 for signal in signals if signal.success) / total
    grounded_rate = sum(1 for signal in signals if signal.grounded) / total
    avg_latency = mean(signal.latency_ms for signal in signals)

    status = "healthy"
    if success_rate < 0.9 or grounded_rate < 0.9:
        status = "warning"
    if success_rate < 0.75 or grounded_rate < 0.75:
        status = "critical"

    return EvaluationSummary(
        total_requests=total,
        success_rate=round(success_rate, 2),
        grounded_rate=round(grounded_rate, 2),
        avg_latency_ms=round(avg_latency, 2),
        status=status,
    )


@app.get("/health")
def health_check():
    return {"status": "healthy", "module": "08-observability-and-evaluation"}


@app.post("/evaluate", response_model=EvaluationSummary)
def evaluate(request: EvaluationRequest):
    return summarize(request.signals)


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
