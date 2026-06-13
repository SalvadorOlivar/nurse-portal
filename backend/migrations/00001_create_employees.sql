-- +goose Up
CREATE TABLE employees (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre      VARCHAR(100) NOT NULL,
    apellido    VARCHAR(100) NOT NULL,
    tipo        VARCHAR(20) NOT NULL CHECK (tipo IN ('NURSE', 'NURSE_ASSISTANT')),
    horas_minimas   INT NOT NULL,
    horas_maximas   INT NOT NULL,
    work_days   INT NOT NULL DEFAULT 4,
    rest_days   INT NOT NULL DEFAULT 1,
    activo      BOOLEAN NOT NULL DEFAULT true,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- +goose Down
DROP TABLE IF EXISTS employees;
