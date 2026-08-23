/*
# Create radar_entries table (single-tenant, no auth)

1. New Tables
- `radar_entries`
  - `id` (uuid, primary key)
  - `radar` (text, not null) — which radar: 'black-zone' or 'roads'
  - `map` (text, not null) — map name
  - `guilds` (jsonb, not null) — array of { name, type } guilds
  - `last_edited` (text) — human-readable last edit timestamp
  - `created_at` (timestamptz, default now())
2. Security
- Enable RLS on `radar_entries`.
- Allow anon + authenticated full CRUD because the data is intentionally shared/public.
3. Indexes
- Unique constraint on (radar, map) so each map appears once per radar.
*/

CREATE TABLE IF NOT EXISTS radar_entries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  radar text NOT NULL,
  map text NOT NULL,
  guilds jsonb NOT NULL DEFAULT '[]'::jsonb,
  last_edited text,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE radar_entries ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_select_radar" ON radar_entries;
CREATE POLICY "anon_select_radar" ON radar_entries FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "anon_insert_radar" ON radar_entries;
CREATE POLICY "anon_insert_radar" ON radar_entries FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_radar" ON radar_entries;
CREATE POLICY "anon_update_radar" ON radar_entries FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_radar" ON radar_entries;
CREATE POLICY "anon_delete_radar" ON radar_entries FOR DELETE
  TO anon, authenticated USING (true);

CREATE UNIQUE INDEX IF NOT EXISTS radar_entries_radar_map_key
  ON radar_entries (radar, map);
