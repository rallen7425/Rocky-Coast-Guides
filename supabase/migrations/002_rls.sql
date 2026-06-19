-- ============================================================
-- Row-Level Security
-- ============================================================

-- Enable RLS on all tables
alter table public.alerts        enable row level security;
alter table public.events        enable row level security;
alter table public.amenities     enable row level security;
alter table public.content_pages enable row level security;
alter table public.weather_cache enable row level security;

-- ── ALERTS ───────────────────────────────────────────────────
-- Authenticated users can read active alerts
create policy "alerts: anyone can read active"
  on public.alerts for select
  using (is_active = true and (expires_at is null or expires_at > now()));

-- Only admins can write
create policy "alerts: admin full access"
  on public.alerts for all
  using ((auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin')
  with check ((auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin');

-- ── EVENTS ───────────────────────────────────────────────────
create policy "events: authenticated read active"
  on public.events for select
  to authenticated
  using (is_active = true);

create policy "events: admin full access"
  on public.events for all
  using ((auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin')
  with check ((auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin');

-- ── AMENITIES ────────────────────────────────────────────────
create policy "amenities: authenticated read"
  on public.amenities for select
  to authenticated
  using (true);

create policy "amenities: admin full access"
  on public.amenities for all
  using ((auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin')
  with check ((auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin');

-- ── CONTENT PAGES ────────────────────────────────────────────
create policy "content_pages: authenticated read"
  on public.content_pages for select
  to authenticated
  using (true);

create policy "content_pages: admin full access"
  on public.content_pages for all
  using ((auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin')
  with check ((auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin');

-- ── WEATHER CACHE ────────────────────────────────────────────
create policy "weather_cache: authenticated read"
  on public.weather_cache for select
  to authenticated
  using (true);

-- Weather cache is written only by the edge function (service role key)
