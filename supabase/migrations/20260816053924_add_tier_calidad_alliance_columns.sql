/*
# Add tier, calidad and alliance_name columns to mapas_hideouts

1. Modified Tables
- `mapas_hideouts`
  - `tier` (integer, nullable) — map tier (4-8), used only for "HO Zona Negra" radar
  - `calidad` (integer, nullable) — map quality (1-6), used only for "HO Zona Negra" radar
  - `alliance_name` (text, nullable) — optional alliance name per guild row, used only for "HO Zona Negra" radar
2. Notes
- All three new columns are nullable so existing "HO Caminos" rows are unaffected.
- No security changes needed: RLS is already enabled and policies allow anon+authenticated CRUD.
*/

ALTER TABLE mapas_hideouts
  ADD COLUMN IF NOT EXISTS tier integer,
  ADD COLUMN IF NOT EXISTS calidad integer,
  ADD COLUMN IF NOT EXISTS alliance_name text;
