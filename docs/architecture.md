# Architecture

## Current starter
- React + Vite responsive mobile-first frontend.
- Browser localStorage for demo records.
- FastAPI validation-only backend.
- Supabase schema draft with per-user Row Level Security.

## Planned production architecture
1. Supabase Auth for identity.
2. Supabase Postgres with RLS for user-owned mandate metadata.
3. FastAPI for trusted server-side operations.
4. Provider adapters isolated behind a capability interface.
5. Notification worker for due-date reminders.
6. Audit log for every attempted provider action.

## Provider capability contract
An adapter must declare whether it supports read, pause, resume or cancel. Unsupported actions return not_supported and guide the user to the provider's official channel. Never scrape credentials or simulate success.

## Status semantics
- active: user-recorded active state.
- paused: user-recorded pause; provider confirmation is stored separately.
- cancelled: mark confirmed only after bank/provider confirmation.
- action_required: user must complete a step with the provider.

## Deployment
Frontend can be deployed to Vercel or Cloudflare Pages. Backend is deployed separately on a trusted HTTPS host. Configure CORS for the exact production origin before launch.
