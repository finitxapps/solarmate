CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS consumers
(
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type          VARCHAR(50) NOT NULL,
    normal_wattage INTEGER NOT NULL,
    surge_wattage  INTEGER NOT NULL,
    amper_control  BOOLEAN,
    features      JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW()
);
