-- Treningsdagbok: databaseoppsett for Supabase
-- Lim inn alt dette i Supabase > SQL Editor og trykk "Run".

create table if not exists public.okter (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null default auth.uid() references auth.users (id) on delete cascade,
  dato        date not null,
  type        text not null check (type in ('styrke', 'kondisjon', 'fotball', 'generell')),
  tittel      text,
  varighet    integer not null check (varighet > 0 and varighet <= 600),
  rpe         integer check (rpe between 1 and 10),
  notat       text,
  ovelser     jsonb not null default '[]'::jsonb,  -- styrke: [{navn, sett, reps, kg}]
  aktivitet   text,                               -- kondisjon: Løping, Sykling ...
  distanse    numeric,                            -- kondisjon: km
  puls        integer,                            -- kondisjon: snittpuls
  fotball     text,                               -- fotball: Lagtrening, Kamp ...
  mal         text,                               -- fotball: mål / målgivende
  opprettet   timestamptz not null default now()
);

create index if not exists okter_user_dato on public.okter (user_id, dato desc);

-- Row Level Security: hver bruker ser og endrer bare sine egne økter.
alter table public.okter enable row level security;

drop policy if exists "Se egne økter" on public.okter;
drop policy if exists "Lage egne økter" on public.okter;
drop policy if exists "Endre egne økter" on public.okter;
drop policy if exists "Slette egne økter" on public.okter;

create policy "Se egne økter"     on public.okter for select to authenticated using ((select auth.uid()) = user_id);
create policy "Lage egne økter"   on public.okter for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Endre egne økter"  on public.okter for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "Slette egne økter" on public.okter for delete to authenticated using ((select auth.uid()) = user_id);

-- Innloggede brukere får lov til å bruke tabellen (reglene over bestemmer hvilke rader).
grant select, insert, update, delete on public.okter to authenticated;
revoke all on public.okter from anon;
