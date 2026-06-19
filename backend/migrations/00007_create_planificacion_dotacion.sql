-- +goose Up
CREATE TABLE planificacion_sectores (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    planificacion_id  UUID NOT NULL REFERENCES planificaciones(id) ON DELETE CASCADE,
    nombre            VARCHAR(50) NOT NULL,
    created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(planificacion_id, nombre)
);

CREATE TABLE planificacion_dotacion (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    planificacion_id  UUID NOT NULL REFERENCES planificaciones(id) ON DELETE CASCADE,
    sector            VARCHAR(50) NOT NULL DEFAULT '',
    tipo_empleado     VARCHAR(20) NOT NULL,
    turno             VARCHAR(20) NOT NULL,
    cantidad_minima   INTEGER NOT NULL DEFAULT 0,
    created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(planificacion_id, sector, tipo_empleado, turno)
);

CREATE INDEX idx_planif_sectores_planificacion ON planificacion_sectores(planificacion_id);
CREATE INDEX idx_planif_dotacion_planificacion ON planificacion_dotacion(planificacion_id);

-- +goose Down
DROP INDEX IF EXISTS idx_planif_dotacion_planificacion;
DROP INDEX IF EXISTS idx_planif_sectores_planificacion;
DROP TABLE IF EXISTS planificacion_dotacion;
DROP TABLE IF EXISTS planificacion_sectores;
