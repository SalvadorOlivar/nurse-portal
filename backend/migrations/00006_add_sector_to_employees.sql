-- +goose Up
ALTER TABLE employees ADD COLUMN sector VARCHAR(20) DEFAULT '';

-- +goose Down
ALTER TABLE employees DROP COLUMN IF EXISTS sector;
