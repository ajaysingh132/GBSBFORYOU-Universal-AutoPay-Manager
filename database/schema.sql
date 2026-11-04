-- Supabase/PostgreSQL starter schema. Never store payment secrets.
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
create policy "Users read own payments" on public.recurring_payments for select using (auth.uid() = user_id);
create policy "Users insert own payments" on public.recurring_payments for insert with check (auth.uid() = user_id);
create policy "Users update own payments" on public.recurring_payments for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users delete own payments" on public.recurring_payments for delete using (auth.uid() = user_id);
-- Never add columns for UPI PIN, OTP, CVV, full card number or bank passwords.
