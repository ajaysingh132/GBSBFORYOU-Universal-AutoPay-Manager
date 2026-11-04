from datetime import datetime, timezone
from typing import Literal
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field

app = FastAPI(title="GBSBFORYOU AutoPay Manager API", version="0.1.0")
app.add_middleware(CORSMiddleware, allow_origins=["http://localhost:5173"], allow_credentials=True, allow_methods=["GET", "POST"], allow_headers=["Content-Type", "Authorization"])

class RecurringPayment(BaseModel):
    name: str = Field(min_length=1, max_length=120)
    provider: str = Field(default="", max_length=120)
    amount_inr: float = Field(gt=0)
    due_day: int = Field(ge=1, le=31)
    category: str = Field(default="Other", max_length=40)
    status: Literal["active", "paused", "cancelled", "action_required"] = "active"

@app.get("/health")
def health():
    return {"status": "ok", "service": "gbsbforyou-autopay-manager", "utc": datetime.now(timezone.utc).isoformat()}

@app.post("/api/validate-payment")
def validate_payment(payment: RecurringPayment):
    """Validation only. This endpoint does not contact banks or change mandates."""
    return {"valid": True, "payment": payment.model_dump(), "financial_action_performed": False}
