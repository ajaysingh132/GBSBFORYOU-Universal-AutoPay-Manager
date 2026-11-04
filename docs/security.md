# Security and financial safety

- Never collect UPI PINs, OTPs, CVVs, full card numbers, bank passwords or internet-banking credentials.
- Never store raw payment credentials in browser storage, databases, logs or analytics.
- Use official provider APIs and documented authorization flows only.
- Require explicit consent and final confirmation before any financial action.
- A UI status change is not proof that a bank mandate was paused or cancelled.
- Record provider reference IDs and confirmation timestamps, never secret credentials.
- Add authentication, authorization, rate limits, input validation and audit logging before production.
- Keep secrets in deployment environment variables; never commit them to Git.
