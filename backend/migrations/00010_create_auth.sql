-- +goose Up
CREATE TABLE auth_users (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username      VARCHAR(150) NOT NULL UNIQUE,
    password_hash TEXT,
    role          VARCHAR(20) NOT NULL CHECK (role IN ('ADMIN', 'SUPERVISOR', 'EMPLOYEE')),
    employee_id   UUID UNIQUE REFERENCES employees(id) ON DELETE SET NULL,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE auth_sessions (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id    UUID NOT NULL REFERENCES auth_users(id) ON DELETE CASCADE,
    token_hash TEXT NOT NULL UNIQUE,
    expires_at TIMESTAMPTZ NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_auth_sessions_user_id ON auth_sessions(user_id);
CREATE INDEX idx_auth_sessions_expires_at ON auth_sessions(expires_at);

INSERT INTO auth_users (username, role, employee_id)
SELECT
    lower(regexp_replace(nombre || '.' || apellido, '\s+', '', 'g')),
    CASE WHEN tipo = 'SUPERVISOR' THEN 'SUPERVISOR' ELSE 'EMPLOYEE' END,
    id
FROM employees
ON CONFLICT (username) DO NOTHING;

-- +goose Down
DROP TABLE IF EXISTS auth_sessions;
DROP TABLE IF EXISTS auth_users;
