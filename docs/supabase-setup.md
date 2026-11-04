# Supabase setup (Phase 2)

1. Create/activate the dedicated Supabase project for this app.
2. Apply `supabase/migrations/20261105000100_create_recurring_payments.sql` in the Supabase SQL Editor.
3. In Project Settings → API, copy the Project URL and **publishable** key.
4. Add them to local `.env.local` or your hosting provider's environment variables:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_PUBLISHABLE_KEY`
5. In Authentication → URL Configuration, add your local and deployed app origins to the allowed redirect URLs.
6. Configure email confirmation and SMTP before public production use. With email confirmation enabled, a new user must verify their email before signing in.
7. Test two separate accounts: each account must only see its own records.

## Security requirements
- Only a publishable key belongs in frontend variables. Never expose a secret/service-role key.
- The table has RLS policies restricted to the authenticated owner.
- Public/anonymous access is revoked; only authenticated role is granted table access.
- Do not store payment credentials, UPI PIN, OTP, CVV, full card number or net-banking passwords.
- A locally changed status is a user-maintained note, not confirmation from the bank/provider.
