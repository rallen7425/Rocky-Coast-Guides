-- ============================================================
-- Summer Village Life — MVP Schema
-- ============================================================

-- ALERTS
create table if not exists public.alerts (
  id          uuid primary key default gen_random_uuid(),
  message     text not null,
  severity    text not null default 'warning' check (severity in ('info', 'warning', 'emergency')),
  is_active   boolean not null default true,
  created_at  timestamptz not null default now(),
  expires_at  timestamptz
);

-- EVENTS
create table if not exists public.events (
  id              uuid primary key default gen_random_uuid(),
  title           text not null,
  date            date not null,
  time_start      time,
  time_end        time,
  is_onsite       boolean not null default true,
  venue           text,
  distance_miles  numeric(4,1),
  city            text,
  category        text,
  is_active       boolean not null default true,
  created_at      timestamptz not null default now()
);

-- AMENITIES
create table if not exists public.amenities (
  id               uuid primary key default gen_random_uuid(),
  name             text not null,
  category         text not null check (category in ('pool', 'amenity')),
  status           text not null default 'open' check (status in ('open', 'closed', 'maintenance')),
  hours_open       time,
  hours_close      time,
  location         text,
  notes            text,
  age_restriction  text,
  sort_order       int not null default 0
);

-- CONTENT PAGES
create table if not exists public.content_pages (
  id          uuid primary key default gen_random_uuid(),
  slug        text unique not null,
  title       text not null,
  body        text,
  updated_at  timestamptz not null default now()
);

-- WEATHER CACHE
create table if not exists public.weather_cache (
  id              uuid primary key default gen_random_uuid(),
  fetched_at      timestamptz not null default now(),
  temp_f          numeric(4,1),
  feels_like_f    numeric(4,1),
  wind_mph        numeric(4,1),
  beach_status    text check (beach_status in ('Ideal', 'Fair', 'Poor')),
  next_tide_at    timestamptz,
  next_tide_type  text check (next_tide_type in ('Low', 'High'))
);

-- ── INDEXES ──────────────────────────────────────────────────
create index if not exists alerts_active_idx      on public.alerts  (is_active, expires_at);
create index if not exists events_date_idx        on public.events  (date, time_start) where is_active;
create index if not exists amenities_category_idx on public.amenities (category, sort_order);
create index if not exists weather_fetched_idx    on public.weather_cache (fetched_at desc);
