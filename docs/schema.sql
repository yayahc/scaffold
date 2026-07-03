
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'content_type') THEN
    CREATE TYPE content_type AS ENUM ('quiz');
  END IF;
END$$;

CREATE TABLE IF NOT EXISTS content (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type        content_type NOT NULL,
  title       text        NOT NULL,
  description text,
  cover_image text,
  published   boolean     NOT NULL DEFAULT false,
  locked      boolean     NOT NULL DEFAULT false,
  unlock_code text,                                   -- null unless locked
  payload     jsonb       NOT NULL DEFAULT '{}'::jsonb,
  created_at  timestamptz NOT NULL DEFAULT now(),
  updated_at  timestamptz NOT NULL DEFAULT now()
);
