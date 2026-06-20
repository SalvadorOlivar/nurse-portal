-- +goose Up
ALTER TABLE auth_users ADD COLUMN must_change_password BOOLEAN NOT NULL DEFAULT false;

-- +goose Down
ALTER TABLE auth_users DROP COLUMN must_change_password;
