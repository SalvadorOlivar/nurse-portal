-- +goose Up
CREATE TABLE planificaciones (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    mes INTEGER NOT NULL CHECK (mes BETWEEN 1 AND 12),
    anio INTEGER NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'BORRADOR' CHECK (estado IN ('BORRADOR', 'PUBLICADO', 'CERRADO')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(mes, anio)
);

CREATE TABLE turnos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    planificacion_id UUID NOT NULL REFERENCES planificaciones(id) ON DELETE CASCADE,
    empleado_id UUID NOT NULL REFERENCES employees(id),
    dia INTEGER NOT NULL CHECK (dia BETWEEN 1 AND 31),
    turno VARCHAR(20) NOT NULL DEFAULT 'MANANA' CHECK (turno IN ('MANANA', 'TARDE', 'VESPERTINO', 'NOCHE')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(planificacion_id, empleado_id, dia)
);

CREATE INDEX idx_turnos_planificacion ON turnos(planificacion_id);
CREATE INDEX idx_turnos_empleado ON turnos(empleado_id);

-- +goose Down
DROP INDEX IF EXISTS idx_turnos_planificacion;
DROP INDEX IF EXISTS idx_turnos_empleado;
DROP TABLE IF EXISTS turnos;
DROP TABLE IF EXISTS planificaciones;
