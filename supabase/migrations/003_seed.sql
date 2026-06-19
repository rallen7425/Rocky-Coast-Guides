-- ============================================================
-- Sample Data Seed
-- ============================================================

-- ALERTS
insert into public.alerts (message, severity, is_active) values
  ('Adult Pool closed until 11am — routine maintenance', 'warning', true);

-- EVENTS — relative to today for demo freshness
insert into public.events (title, date, time_start, time_end, is_onsite, venue, distance_miles, city, category) values
  ('Annual Meeting',           current_date + 1, '10:00', '11:00', true,  'Barn',                  null,  null,                 'community'),
  ('Lobster Rock Festival',    current_date,     '15:00', '18:00', false, null,                    19.0,  'Old Orchard Beach',  'food'),
  ('Game Night',               current_date + 1, '20:00', '22:00', true,  'Barn',                  null,  null,                 'community'),
  ('55th Open Air Arts Gallery',current_date + 1,'09:00', '15:00', false, null,                    16.0,  'Saco',               'arts'),
  ('Father''s Day Celebration', current_date + 2,'12:00', '14:00', true,  'Pavilion',              null,  null,                 'community'),
  ('8th Annual York Car Show',  current_date + 2,'08:00', null,    false, '1 Robert Stevens Dr',   12.0,  'York',               'auto'),
  ('Pool Yoga',                 current_date,    '08:00', '09:00', true,  'Adult Pool',            null,  null,                 'fitness'),
  ('Movie Night',               current_date + 3,'20:30', '23:00', true,  'Barn',                  null,  null,                 'community'),
  ('Ogunquit Sidewalk Art Show',current_date + 3,'10:00', '16:00', false, null,                    3.5,   'Ogunquit',           'arts'),
  ('Morning Stretch',           current_date + 4,'08:00', '09:00', true,  'Pavilion',              null,  null,                 'fitness');

-- AMENITIES — Pools
insert into public.amenities (name, category, status, hours_open, hours_close, age_restriction, sort_order) values
  ('Adult Pool',                'pool',    'open',        '08:00', '22:00', 'Ages 16 and up', 1),
  ('Family Pool (Heated)',      'pool',    'open',        '08:00', '22:00', null,             2),
  ('Pavilion Pool (Not Heated)','pool',    'maintenance', '08:00', '22:00', null,             3);

-- AMENITIES — Other
insert into public.amenities (name, category, status, hours_open, hours_close, location, sort_order) values
  ('Pickleball Courts',  'amenity', 'open', '07:00', '22:00', null,                     1),
  ('Fitness Center',     'amenity', 'open', '00:00', '23:59', 'Downstairs at the Barn', 2),
  ('Sauna',              'amenity', 'open', '08:00', '20:00', 'Downstairs at the Barn', 3),
  ('Game Room',          'amenity', 'open', '10:00', '22:00', 'Upstairs at the Barn',   4),
  ('Tennis Courts',      'amenity', 'open', '07:00', '22:00', null,                     5),
  ('Basketball Courts',  'amenity', 'open', '07:00', '22:00', null,                     6),
  ('Playground',         'amenity', 'open', '07:00', '20:00', null,                     7),
  ('Pavilion',           'amenity', 'open', '07:00', '22:00', null,                     8);

-- CONTENT PAGES
insert into public.content_pages (slug, title, body) values
  ('arrival-guide',   'Arrival Guide',   '## Arriving at Summer Village\n\nCheck-in is at **3:00 PM**. Please proceed to the main gate on Route 1 and provide your cottage number to the attendant.\n\n### Parking\nPark in the numbered spots near your cottage. Overflow parking is available at the main lot by the Barn.\n\n### WiFi\nConnect to **SummerVillage-Guest**. The password is provided at check-in.'),
  ('renters-guide',   'Renter''s Guide',  '## Welcome to The Cottages at Summer Village\n\nWe are so glad you are here! This guide covers everything you need to know for a wonderful stay.\n\n### Quiet Hours\nQuiet hours are **10:00 PM – 8:00 AM**. Please be respectful of your neighbors.\n\n### Trash & Recycling\nDumpsters are located at the main entrance. Please separate recyclables.'),
  ('faq',             'FAQ',             '## Frequently Asked Questions\n\n**What is the check-out time?**\nCheck-out is at 10:00 AM.\n\n**Is there a store on-site?**\nNo, but there are convenience stores and grocery options within 3 miles on Route 1.\n\n**Can I have guests visit?**\nYes, but all guests must register at the gate. Please limit day guests to 4 per cottage.'),
  ('property-rules',  'Property Rules',  '## Community Rules\n\n1. **Speed limit** is 10 mph throughout the property.\n2. **Pets** must be leashed at all times and are not permitted in the pool areas.\n3. **Alcohol** is not permitted in common areas.\n4. **Fires** — no open fires. Propane grills on cottage decks only.\n5. **Trespassing** — please respect the private areas of other cottages.');

-- WEATHER CACHE — sample row
insert into public.weather_cache (temp_f, feels_like_f, wind_mph, beach_status, next_tide_at, next_tide_type) values
  (74.0, 78.0, 8.0, 'Ideal',
   (now() + interval '5 hours')::timestamptz,
   'Low');
