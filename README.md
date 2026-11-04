# GBSBFORYOU Universal AutoPay Manager

**One dashboard. Every recurring payment. Your control.**

A mobile-first Hindi/English PWA starter for organizing recurring payments in India: UPI mandates, card recurring payments, bank standing instructions, EMIs, insurance, utilities, OTT and SaaS subscriptions.

> **Important:** This project does not currently connect to banks, UPI apps or card networks. It cannot directly pause or cancel mandates. It provides a user-managed register and clear status tracking. Direct actions will only be added through verified, authorized provider integrations.

## MVP features
- Mobile-first dashboard with active, paused, cancelled and action-required statuses.
- Add and remove recurring-payment records.
- Search and status filters.
- Monthly spend estimate and due-date overview.
- Hindi/English interface.
- Demo records stored in browser localStorage.
- No card number, CVV, UPI PIN, OTP or banking password fields.

## Run locally
```bash
npm install
npm run dev
```

## Supabase Auth + cloud sync (Phase 2)

The app now supports Supabase email/password sign-up, sign-in, sign-out and per-user cloud records.

1. Apply `supabase/migrations/20261105000100_create_recurring_payments.sql` in the Supabase SQL Editor.
2. Copy `.env.example` to `.env.local`.
3. Set `VITE_SUPABASE_URL` and `VITE_SUPABASE_PUBLISHABLE_KEY` using the project's URL and publishable key.
4. Add the local/deployed app origin to Supabase Auth redirect URL allow-list.
5. Configure SMTP/email confirmation for production account verification.

If Supabase variables are missing, the UI stays in local demo mode. The frontend must only receive the publishable key; never use a secret/service-role key in VITE_ variables.

## Backend starter
```bash
cd backend
python -m venv .venv
pip install -r requirements.txt
uvicorn app.main:app --reload
```

## Project structure
- frontend/ — React + Vite mobile-first app.
- backend/ — FastAPI validation-only starter.
- database/ — Supabase/PostgreSQL schema draft.
- docs/ — architecture and security notes.

## Safety principles
1. Never collect or store UPI PIN, OTP, CVV, full card number or net-banking password.
2. Never represent a payment as stopped until the bank/provider confirms it.
3. Require explicit user confirmation before any future financial action.
4. Use official provider APIs and consent-based authorization only.
5. Keep audit records for integration actions.

## Roadmap
1. Manual register and dashboard (current starter).
2. Secure user accounts and cloud sync.
3. Provider directory with official cancellation/pause instructions.
4. Authorized bank/UPI/provider integrations where available.
5. Notifications, exports and spending insights.

## License
MIT — see LICENSE.
