-- Istanbul Nights / Supabase schema
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  name_ar text not null,
  name_en text,
  age integer check (age is null or age >= 18),
  bio_ar text,
  bio_en text,
  image_url text,
  gallery jsonb not null default '[]'::jsonb,
  whatsapp text,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

drop policy if exists "Public can view active profiles" on public.profiles;
create policy "Public can view active profiles"
on public.profiles for select
using (active = true);

drop policy if exists "Authenticated admins manage profiles" on public.profiles;
create policy "Authenticated admins manage profiles"
on public.profiles for all to authenticated
using (true) with check (true);

create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end $$;

drop trigger if exists profiles_updated_at on public.profiles;
create trigger profiles_updated_at before update on public.profiles
for each row execute function public.set_updated_at();

-- Storage bucket for real profile photos.
insert into storage.buckets (id,name,public)
values ('profile-photos','profile-photos',true)
on conflict (id) do nothing;

drop policy if exists "Public profile photos" on storage.objects;
create policy "Public profile photos"
on storage.objects for select
using (bucket_id = 'profile-photos');

drop policy if exists "Authenticated upload profile photos" on storage.objects;
create policy "Authenticated upload profile photos"
on storage.objects for insert to authenticated
with check (bucket_id = 'profile-photos');

drop policy if exists "Authenticated update profile photos" on storage.objects;
create policy "Authenticated update profile photos"
on storage.objects for update to authenticated
using (bucket_id = 'profile-photos')
with check (bucket_id = 'profile-photos');

drop policy if exists "Authenticated delete profile photos" on storage.objects;
create policy "Authenticated delete profile photos"
on storage.objects for delete to authenticated
using (bucket_id = 'profile-photos');
