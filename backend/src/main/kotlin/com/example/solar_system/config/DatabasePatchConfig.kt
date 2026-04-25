package com.example.solar_system.config

import org.springframework.boot.ApplicationRunner
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.jdbc.core.JdbcTemplate

@Configuration
class DatabasePatchConfig {
    @Bean
    fun patchConsumersSchema(jdbcTemplate: JdbcTemplate): ApplicationRunner {
        return ApplicationRunner {
            // Ensure the table exists even if Flyway history is out of sync.
            jdbcTemplate.execute("CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\"")
            jdbcTemplate.execute(
                """
                CREATE TABLE IF NOT EXISTS public.consumers
                (
                    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                    type VARCHAR(50) NOT NULL,
                    normal_wattage INTEGER NOT NULL DEFAULT 0,
                    surge_wattage INTEGER NOT NULL DEFAULT 0,
                    inverter BOOLEAN,
                    amper_control BOOLEAN,
                    features TEXT NOT NULL DEFAULT '{}',
                    created_at TIMESTAMP NOT NULL DEFAULT NOW()
                )
                """.trimIndent()
            )

            jdbcTemplate.execute("ALTER TABLE consumers DROP COLUMN IF EXISTS session_id")
            jdbcTemplate.execute("DROP INDEX IF EXISTS idx_consumers_session_id")
            jdbcTemplate.execute("ALTER TABLE consumers ADD COLUMN IF NOT EXISTS normal_wattage INTEGER NOT NULL DEFAULT 0")
            jdbcTemplate.execute("ALTER TABLE consumers ADD COLUMN IF NOT EXISTS surge_wattage INTEGER NOT NULL DEFAULT 0")
            jdbcTemplate.execute("ALTER TABLE consumers ADD COLUMN IF NOT EXISTS inverter BOOLEAN")
            jdbcTemplate.execute("ALTER TABLE consumers ADD COLUMN IF NOT EXISTS amper_control BOOLEAN")
            jdbcTemplate.execute("ALTER TABLE consumers ADD COLUMN IF NOT EXISTS features TEXT NOT NULL DEFAULT '{}'")
            jdbcTemplate.execute("ALTER TABLE consumers ALTER COLUMN features DROP DEFAULT")
            jdbcTemplate.execute("ALTER TABLE consumers ALTER COLUMN features TYPE jsonb USING features::jsonb")
            jdbcTemplate.execute("ALTER TABLE consumers ALTER COLUMN features SET DEFAULT '{}'::jsonb")
        }
    }
}
