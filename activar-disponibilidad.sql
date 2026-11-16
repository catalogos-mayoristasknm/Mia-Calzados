BEGIN;

ALTER TABLE public.mia_products
  ADD COLUMN IF NOT EXISTS sold_out boolean NOT NULL DEFAULT false;

DROP POLICY IF EXISTS mia_admin_borrar_articulo ON public.mia_products;
CREATE POLICY mia_admin_borrar_articulo ON public.mia_products
  FOR DELETE TO authenticated
  USING (EXISTS (
    SELECT 1 FROM public.mia_admins AS a WHERE a.user_id = auth.uid()
  ));

COMMIT;
