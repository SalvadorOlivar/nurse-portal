-- +goose Up
DROP TABLE IF EXISTS staffing_requirements;

-- +goose Down
CREATE TABLE staffing_requirements (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    planificacion_id UUID NOT NULL REFERENCES planificaciones(id) ON DELETE CASCADE,
    tipo_empleado   VARCHAR(20) NOT NULL,
    turno           VARCHAR(20) NOT NULL,
    cantidad_minima INT NOT NULL CHECK (cantidad_minima > 0),
    UNIQUE (planificacion_id, tipo_empleado, turno)
);
