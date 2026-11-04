-- GBSBFORYOU AutoPay Manager: user-owned recurring payment records.
-- Tables created in public are NOT auto-exposed in current Supabase projects.
-- Explicit grants below expose only this RLS-protected table to authenticated users.

create table if not exists public.recurring_payments (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 name text not null check (char_length(name) between 1 and 120),
 provider text not null default '',
 amount_inr numeric(12,2) not null check (amount_inr > 0),
 due_day integer not null check (due_day between 1 and 31),
 frequency text not null default 'monthly',
 category text not null default 'other',
 payment_method text not null default 'unknown',
 status text not null default 'active' check (status in ('active','paused','cancelled','action_required')),
 provider_reference_last4 text,
 notes text,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);

alter table public.recurring_payments enable row level security;

drop policy if exists "Users read own payments" on public.recurring_payments;
drop policy if exists "Users insert own payments" on public.recurring_payments;
drop policy if exists "Users update own payments" on public.recurring_payments;
drop policy if exists "Users delete own payments" on public.recurring_payments;

create policy "Users read own payments" on public.recurring_payments
 for select to authenticated using ((select auth.uid()) = user_id);
create policy "Users insert own payments" on public.recurring_payments
 for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Users update own payments" on public.recurring_payments
 for update to authenticated using ((select auth.uid()) = user_id)
 with check ((select auth.uid()) = user_id);
create policy "Users delete own payments" on public.recurring_payments
 for delete to authenticated using ((select auth.uid()) = user_id);

grant usage on schema public to authenticated;
grant select, insert, update, delete on public.recurring_payments to authenticated;
revoke all on public.recurring_payments from anon;

create index if not exists recurring_payments_user_created_idx
 on public.recurring_payments(user_id, created_at desc);

comment on table public.recurring_payments is
 'User-managed recurring payment metadata only. Never store UPI PIN, OTP, CVV, full card numbers or banking passwords.';
