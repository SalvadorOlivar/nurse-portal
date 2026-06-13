-- +goose Up
ALTER TABLE employees DROP CONSTRAINT IF EXISTS employees_tipo_check;
ALTER TABLE employees ADD CONSTRAINT employees_tipo_check
    CHECK (tipo IN ('NURSE', 'NURSE_ASSISTANT', 'SUPERVISOR', 'AUXILIAR_SERVICIO'));

-- +goose Down
ALTER TABLE employees DROP CONSTRAINT IF EXISTS employees_tipo_check;
ALTER TABLE employees ADD CONSTRAINT employees_tipo_check
    CHECK (tipo IN ('NURSE', 'NURSE_ASSISTANT'));
