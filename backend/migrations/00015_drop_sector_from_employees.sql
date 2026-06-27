-- +goose Up
ALTER TABLE employees DROP COLUMN IF EXISTS sector;

-- +goose Down
ALTER TABLE employees ADD COLUMN sector VARCHAR(20) DEFAULT '';
