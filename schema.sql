-- Execute uma vez no editor SQL do projeto Supabase.
create table if not exists public.resina_records (
  owner_id uuid not null references auth.users(id) on delete cascade,
  id text not null,
  kind text not null check (kind in ('quote','settings')),
  payload jsonb not null check (jsonb_typeof(payload) = 'object'),
  revision integer not null default 1 check (revision > 0),
  updated_at timestamptz not null default now(),
  primary key (owner_id,id)
);
alter table public.resina_records enable row level security;
revoke all on public.resina_records from anon;
grant select,insert,update,delete on public.resina_records to authenticated;
create policy "Read own records" on public.resina_records for select to authenticated using ((select auth.uid()) = owner_id);
create policy "Insert own records" on public.resina_records for insert to authenticated with check ((select auth.uid()) = owner_id);
create policy "Update own records" on public.resina_records for update to authenticated using ((select auth.uid()) = owner_id) with check ((select auth.uid()) = owner_id);
create policy "Delete own records" on public.resina_records for delete to authenticated using ((select auth.uid()) = owner_id);
create or replace function public.resina_touch_record() returns trigger language plpgsql set search_path = '' as $$
begin new.updated_at = now(); return new; end; $$;
create trigger resina_touch_record before update on public.resina_records for each row execute function public.resina_touch_record();
