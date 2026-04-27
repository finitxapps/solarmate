CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS consumers
(
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    consumer_type VARCHAR(100) NOT NULL,
    type          VARCHAR(50) NOT NULL,
    normal_wattage INTEGER NOT NULL,
    surge_wattage  INTEGER NOT NULL,
    inverter      BOOLEAN,
    amper_control  BOOLEAN,
    features      JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS user_input
(
    id         BIGSERIAL PRIMARY KEY,
    session_id BIGINT NOT NULL,
    payload    TEXT NOT NULL
);
