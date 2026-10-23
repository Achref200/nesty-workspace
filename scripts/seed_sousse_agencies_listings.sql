/*
  Sousse demo inventory seed: 1 existing Auth owner profile + 35 listings.

  This is an artifact only; it has not been applied to a database.

  Before running:
    1. Provision the agency owner in Supabase Auth with email
       gestion@lejasminimmob.tn and replace REPLACE_WITH_AUTH_USER_UUID below.
    2. Obtain Le Jasmin Immobilier's explicit authorization to publish these
       listings under its account.
    3. Replace the example.com image URLs and the placeholder phone with
       agency-hosted, authorized photos and the agency's real phone number.
    4. Replace the clearly marked sample property details/prices with
       owner-verified inventory before using this as live rental stock.

  Listings are created as private drafts and marked `is_demo = true`. This
  prevents synthetic sample data from appearing in public search or being
  reserved. Replace every sample detail with owner-verified data before
  publishing any listing.
*/

begin;

do $$
declare
  v_owner_id constant uuid := 'REPLACE_WITH_AUTH_USER_UUID';
  v_auth_email text;
begin
  if to_regclass('public.agencies') is null then
    raise exception 'public.agencies is missing; provision the agency through Nesty Base first';
  end if;

  if not exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'listings'
      and column_name = 'pricing'
  ) then
    raise exception 'Listing lifecycle migration is missing; apply it before this seed';
  end if;

  select lower(u.email) into v_auth_email
  from auth.users u
  where u.id = v_owner_id;

  if v_auth_email is null then
    raise exception 'No Supabase Auth user exists for REPLACE_WITH_AUTH_USER_UUID';
  end if;
  if v_auth_email <> 'gestion@lejasminimmob.tn' then
    raise exception 'Auth user email must be gestion@lejasminimmob.tn; found %', v_auth_email;
  end if;
  if not exists (
    select 1 from public.agencies a
    where a.auth_user_id = v_owner_id
      and lower(a.email) = 'gestion@lejasminimmob.tn'
      and a.status = 'active'
  ) then
    raise exception 'Provision an active Nesty agency row for gestion@lejasminimmob.tn before seeding';
  end if;

  insert into public.profiles (id, email, full_name, role)
  values (v_owner_id, 'gestion@lejasminimmob.tn', 'Le Jasmin Immobilier — équipe gestion', 'host')
  on conflict (id) do update set
    email = excluded.email,
    full_name = excluded.full_name,
    role = 'host';
end $$;

with seed (
  n, title, district, property_type, listing_type, bedrooms, bathrooms,
  area_sqm, price, latitude, longitude, tags, amenities
) as (
  values
  ( 1, 'DEMO · T2 lumineux près de la médina',             'Sousse Centre',       'apartment', 'entire_place', 1, 1, 58,  850, 35.8258, 10.6372, array['cityCenter','authenticTunisian','nearShops'], array['wifi','ac','kitchen','fridge','tv']),
  ( 2, 'DEMO · Appartement familial centre-ville',         'Sousse Centre',       'apartment', 'entire_place', 2, 1, 82, 1250, 35.8270, 10.6401, array['cityCenter','family','nearShops'], array['wifi','ac','heating','kitchen','washer','elevator']),
  ( 3, 'DEMO · Studio calme à deux pas des commerces',     'Sousse Centre',       'studio',    'entire_place', 0, 1, 35,  650, 35.8239, 10.6348, array['cityCenter','quietArea','nearShops'], array['wifi','ac','hotWater','kitchen','workspace']),
  ( 4, 'DEMO · T3 avec balcon au cœur de Sousse',          'Sousse Centre',       'apartment', 'entire_place', 2, 1, 91, 1450, 35.8292, 10.6364, array['cityCenter','family','nearShops'], array['wifi','ac','kitchen','fridge','washer','balcony']),
  ( 5, 'DEMO · Chambre privée près des transports',         'Sousse Centre',       'room',      'private_room', 1, 1, 22,  420, 35.8218, 10.6422, array['cityCenter','nearShops','quietArea'], array['wifi','heating','hotWater','workspace']),
  ( 6, 'DEMO · Appartement clair côté Corniche',           'Corniche',            'apartment', 'entire_place', 2, 1, 88, 1600, 35.8340, 10.6448, array['seaView','nearBeach','romantic'], array['wifi','ac','balcony','kitchen','tv']),
  ( 7, 'DEMO · T2 avec vue mer et terrasse',               'Corniche',            'apartment', 'entire_place', 1, 1, 72, 1380, 35.8371, 10.6473, array['seaView','nearBeach','romantic'], array['wifi','ac','balcony','kitchen','fridge']),
  ( 8, 'DEMO · Appartement spacieux pour famille',         'Corniche',            'apartment', 'entire_place', 3, 2, 126, 2200, 35.8394, 10.6419, array['seaView','family','nearBeach'], array['wifi','ac','kitchen','washer','tv','elevator']),
  ( 9, 'DEMO · Studio meublé près du front de mer',        'Corniche',            'studio',    'entire_place', 0, 1, 39,  780, 35.8325, 10.6490, array['nearBeach','quietArea','romantic'], array['wifi','ac','hotWater','kitchen','balcony']),
  (10, 'DEMO · T3 calme avec parking privé',               'Corniche',            'apartment', 'entire_place', 2, 2, 105, 1950, 35.8418, 10.6460, array['quietArea','family','nearBeach'], array['wifi','ac','parking','kitchen','washer','elevator']),
  (11, 'DEMO · Maison de ville proche de la médina',        'Sousse Medina',       'house',     'entire_place', 2, 1, 96, 1320, 35.8250, 10.6317, array['authenticTunisian','cityCenter','nearShops'], array['wifi','ac','kitchen','fridge','tv']),
  (12, 'DEMO · Petit appartement dans la médina',          'Sousse Medina',       'apartment', 'entire_place', 1, 1, 54,  790, 35.8235, 10.6332, array['authenticTunisian','quietArea','cityCenter'], array['wifi','ac','hotWater','kitchen']),
  (13, 'DEMO · Logement traditionnel rénové',              'Sousse Medina',       'riad',      'entire_place', 2, 1, 83, 1480, 35.8262, 10.6298, array['authenticTunisian','romantic','cityCenter'], array['wifi','ac','kitchen','balcony','tv']),
  (14, 'DEMO · Chambre au calme dans maison ancienne',     'Sousse Medina',       'room',      'private_room', 1, 1, 25,  450, 35.8209, 10.6350, array['authenticTunisian','quietArea','nearShops'], array['wifi','heating','hotWater','workspace']),
  (15, 'DEMO · T3 familial avec cour intérieure',          'Sousse Medina',       'house',     'entire_place', 2, 1, 110, 1680, 35.8279, 10.6289, array['authenticTunisian','family','quietArea'], array['wifi','ac','kitchen','garden','washer']),
  (16, 'DEMO · Appartement pratique à Hammam Sousse',      'Hammam Sousse',       'apartment', 'entire_place', 1, 1, 61,  920, 35.8611, 10.5970, array['nearShops','quietArea','family'], array['wifi','ac','kitchen','fridge','parking']),
  (17, 'DEMO · T3 avec jardin près des commerces',          'Hammam Sousse',       'house',     'entire_place', 2, 1, 104, 1520, 35.8642, 10.5934, array['nature','family','nearShops'], array['wifi','ac','kitchen','garden','parking','washer']),
  (18, 'DEMO · Studio meublé à Hammam Sousse',              'Hammam Sousse',       'studio',    'entire_place', 0, 1, 37,  690, 35.8585, 10.6012, array['quietArea','nearShops','remoteWork'], array['wifi','ac','workspace','kitchen','hotWater']),
  (19, 'DEMO · Appartement lumineux avec ascenseur',      'Hammam Sousse',       'apartment', 'entire_place', 2, 1, 89, 1350, 35.8670, 10.5908, array['family','quietArea','nearShops'], array['wifi','ac','elevator','kitchen','washer']),
  (20, 'DEMO · Villa familiale avec espace extérieur',     'Hammam Sousse',       'villa',     'entire_place', 3, 2, 158, 2650, 35.8557, 10.6041, array['family','nature','quietArea'], array['wifi','ac','pool','garden','parking','kitchen']),
  (21, 'DEMO · T2 rénové à Sahloul',                       'Sahloul',             'apartment', 'entire_place', 1, 1, 63,  890, 35.8352, 10.6074, array['nearShops','quietArea','remoteWork'], array['wifi','ac','workspace','kitchen','elevator']),
  (22, 'DEMO · Studio près des services de Sahloul',       'Sahloul',             'studio',    'entire_place', 0, 1, 34,  600, 35.8327, 10.6113, array['nearShops','cityCenter','remoteWork'], array['wifi','ac','workspace','hotWater','kitchen']),
  (23, 'DEMO · Appartement T3 avec parking',               'Sahloul',             'apartment', 'entire_place', 2, 1, 98, 1450, 35.8379, 10.6039, array['family','nearShops','quietArea'], array['wifi','ac','parking','kitchen','washer','elevator']),
  (24, 'DEMO · Chambre privée dans colocation',            'Sahloul',             'room',      'private_room', 1, 1, 20,  390, 35.8308, 10.6150, array['nearShops','remoteWork','quietArea'], array['wifi','workspace','washer','kitchen']),
  (25, 'DEMO · Maison familiale à Sahloul',                'Sahloul',             'house',     'entire_place', 3, 2, 142, 2380, 35.8401, 10.6105, array['family','nature','nearShops'], array['wifi','ac','garden','parking','kitchen','babyBed']),
  (26, 'DEMO · Appartement confortable à Khezama',         'Khezama',             'apartment', 'entire_place', 1, 1, 59,  850, 35.8430, 10.6212, array['nearShops','cityCenter','quietArea'], array['wifi','ac','kitchen','fridge','tv']),
  (27, 'DEMO · T3 avec balcon dans quartier calme',        'Khezama',             'apartment', 'entire_place', 2, 1, 96, 1580, 35.8468, 10.6248, array['quietArea','nearShops','family'], array['wifi','ac','balcony','kitchen','washer','elevator']),
  (28, 'DEMO · Studio fonctionnel à Khezama',              'Khezama',             'studio',    'entire_place', 0, 1, 36,  640, 35.8397, 10.6273, array['quietArea','nearShops','remoteWork'], array['wifi','ac','workspace','kitchen','hotWater']),
  (29, 'DEMO · Villa avec piscine à Khezama',              'Khezama',             'villa',     'entire_place', 3, 2, 174, 2850, 35.8502, 10.6199, array['luxury','nearShops','family'], array['wifi','ac','pool','garden','parking','kitchen']),
  (30, 'DEMO · Appartement lumineux près de la plage',     'Khezama',             'apartment', 'entire_place', 2, 1, 90, 1450, 35.8370, 10.6290, array['nearBeach','family','nearShops'], array['wifi','ac','balcony','kitchen','fridge']),
  (31, 'DEMO · T2 meublé à Port El Kantaoui',              'Port El Kantaoui',    'apartment', 'entire_place', 1, 1, 66, 1320, 35.8933, 10.5948, array['nearBeach','seaView','romantic'], array['wifi','ac','balcony','kitchen','pool']),
  (32, 'DEMO · Appartement avec terrasse et piscine',     'Port El Kantaoui',    'apartment', 'entire_place', 2, 1, 94, 1980, 35.8960, 10.5905, array['nearBeach','luxury','family'], array['wifi','ac','pool','balcony','parking','kitchen']),
  (33, 'DEMO · Studio calme près du port',                 'Port El Kantaoui',    'studio',    'entire_place', 0, 1, 38,  820, 35.8907, 10.5993, array['nearBeach','quietArea','romantic'], array['wifi','ac','kitchen','hotWater','balcony']),
  (34, 'DEMO · Maison avec jardin à Chott Meriam',         'Chott Meriam',        'house',     'entire_place', 2, 1, 112, 1580, 36.0005, 10.5607, array['nature','quietArea','family'], array['wifi','ac','garden','parking','kitchen','washer']),
  (35, 'DEMO · Villa spacieuse à Chott Meriam',            'Chott Meriam',        'villa',     'entire_place', 3, 2, 186, 2780, 35.9974, 10.5561, array['nature','luxury','family'], array['wifi','ac','pool','garden','parking','kitchen'])
)
insert into public.listings (
  id, host_id, title, city, address, price_per_month, currency,
  type, rental_term, audience, bedrooms, bathrooms, area_sqm,
  cover_image, gallery, rooms, amenities, rating, review_count,
  host_name, description, tour_3d_url, is_superhost, available_from,
  bills_included, flatmates, latitude, longitude, status, tags,
  property_type, max_guests, district, contact_phone, house_rules,
  pricing, booking_conditions, wizard_step, is_demo
)
select
  ('95000000-0000-4000-8000-' || lpad(s.n::text, 12, '0'))::uuid,
  'REPLACE_WITH_AUTH_USER_UUID'::uuid,
  s.title,
  'Sousse',
  format('%s, Sousse, Tunisie (adresse à confirmer)', s.district),
  s.price,
  'TND',
  s.listing_type,
  'long_term',
  array['adults','children'],
  s.bedrooms,
  s.bathrooms,
  s.area_sqm,
  format('https://example.com/images/sousse-%s-1.jpg', lpad(s.n::text, 2, '0')),
  array[
    format('https://example.com/images/sousse-%s-1.jpg', lpad(s.n::text, 2, '0')),
    format('https://example.com/images/sousse-%s-2.jpg', lpad(s.n::text, 2, '0')),
    format('https://example.com/images/sousse-%s-3.jpg', lpad(s.n::text, 2, '0')),
    format('https://example.com/images/sousse-%s-4.jpg', lpad(s.n::text, 2, '0')),
    format('https://example.com/images/sousse-%s-5.jpg', lpad(s.n::text, 2, '0'))
  ],
  '[]'::jsonb,
  s.amenities,
  0,
  0,
  'Le Jasmin Immobilier — équipe gestion',
  'DEMO — Exemple de logement. Adresse, disponibilité, description et prix à confirmer par Le Jasmin Immobilier avant diffusion.',
  null,
  false,
  null,
  false,
  0,
  s.latitude,
  s.longitude,
  'draft',
  s.tags,
  s.property_type,
  greatest(2, s.bedrooms * 2),
  s.district,
  '+21600000000',
  '{"pets":false,"smoking":false,"party":false,"instructions":"Règles de la maison à confirmer par l'agence."}'::jsonb,
  jsonb_build_object(
    'model','month', 'amount',s.price, 'minNights',28,
    'longStayDiscountPct',0, 'extraFee',0
  ),
  '{"cancellation":"flexible","paymentMethods":["cash"],"paymentPolicy":"optionalAdvance","advancePct":0}'::jsonb,
  6,
  true
from seed s
on conflict (id) do nothing;

commit;

-- Read-only proof: expect 35 listings and 35 published rows for the owner.
select
  p.id as host_id,
  p.full_name,
  p.email,
  count(l.id) filter (where l.id::text like '95000000-0000-4000-8000-%') as listing_count,
  count(l.id) filter (where l.id::text like '95000000-0000-4000-8000-%' and l.status = 'draft' and l.is_demo) as protected_draft_count,
  min(cardinality(l.gallery)) filter (where l.id::text like '95000000-0000-4000-8000-%') as min_gallery,
  max(cardinality(l.gallery)) filter (where l.id::text like '95000000-0000-4000-8000-%') as max_gallery,
  bool_and(l.latitude between 30.2 and 37.7 and l.longitude between 7.4 and 11.7) filter (where l.id::text like '95000000-0000-4000-8000-%') as coordinates_in_tunisia
from public.profiles p
join public.listings l on l.host_id = p.id
where p.id = 'REPLACE_WITH_AUTH_USER_UUID'::uuid
  and p.email = 'gestion@lejasminimmob.tn'
group by p.id, p.full_name, p.email;
