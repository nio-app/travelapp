-- ═══════════════════════════════════════════════════════════
--  ExoticTravel — Supabase Database Schema
--  Plak dit in de Supabase SQL Editor en klik "Run"
-- ═══════════════════════════════════════════════════════════

-- Reisplannen
CREATE TABLE IF NOT EXISTS trips (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      UUID NOT NULL,
  naam         TEXT NOT NULL,
  land         TEXT NOT NULL,
  emoji        TEXT NOT NULL DEFAULT '🌍',
  steden       TEXT[] DEFAULT '{}',
  status       TEXT NOT NULL DEFAULT 'idee'
               CHECK (status IN ('gepland','idee','wens','geweest')),
  beschrijving TEXT,
  created_at   TIMESTAMPTZ DEFAULT now(),
  updated_at   TIMESTAMPTZ DEFAULT now()
);

-- Bezienswaardigheden
CREATE TABLE IF NOT EXISTS bezienswaardigheden (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id        UUID REFERENCES trips(id) ON DELETE CASCADE NOT NULL,
  naam           TEXT NOT NULL,
  categorie      TEXT NOT NULL DEFAULT 'Overig',
  stad           TEXT NOT NULL DEFAULT '',
  land           TEXT NOT NULL DEFAULT '',
  lat            DOUBLE PRECISION NOT NULL,
  lng            DOUBLE PRECISION NOT NULL,
  beschrijving   TEXT DEFAULT '',
  tips           TEXT[] DEFAULT '{}',
  labels         TEXT[] DEFAULT '{}',
  beste_periode  TEXT,
  website        TEXT,
  openingstijden TEXT,
  foto_url       TEXT,
  created_at     TIMESTAMPTZ DEFAULT now()
);

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trips_updated_at
  BEFORE UPDATE ON trips
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Row Level Security
ALTER TABLE trips ENABLE ROW LEVEL SECURITY;
ALTER TABLE bezienswaardigheden ENABLE ROW LEVEL SECURITY;

-- Anonieme gebruikers zien alleen hun eigen data
CREATE POLICY "eigen trips" ON trips
  FOR ALL USING (auth.uid()::text = user_id::text);

CREATE POLICY "eigen bezienswaardigheden" ON bezienswaardigheden
  FOR ALL USING (
    trip_id IN (SELECT id FROM trips WHERE user_id::text = auth.uid()::text)
  );

-- Indexes
CREATE INDEX IF NOT EXISTS idx_trips_user ON trips(user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_sights_trip ON bezienswaardigheden(trip_id, created_at);
