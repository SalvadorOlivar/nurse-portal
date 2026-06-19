-- +goose Up
ALTER TABLE turnos ADD COLUMN sector VARCHAR(255) NOT NULL DEFAULT '';

-- +goose Down
ALTER TABLE turnos DROP COLUMN IF EXISTS sector;
