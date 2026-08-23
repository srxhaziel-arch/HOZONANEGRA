/*
# Clear tier, calidad and alliance_name data

1. Data Update
- Set `tier`, `calidad`, and `alliance_name` to NULL on all existing rows in `mapas_hideouts`.
- No rows are deleted; only these three columns are cleared.
2. Notes
- The columns remain in the table; they are just emptied of values.
- RLS and policies are unchanged.
*/

UPDATE mapas_hideouts
  SET tier = NULL,
      calidad = NULL,
      alliance_name = NULL;
