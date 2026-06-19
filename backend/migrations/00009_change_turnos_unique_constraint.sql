-- +goose Up
ALTER TABLE turnos DROP CONSTRAINT IF EXISTS turnos_planificacion_id_empleado_id_dia_key;
ALTER TABLE turnos ADD CONSTRAINT turnos_planificacion_empleado_dia_turno_key
  UNIQUE(planificacion_id, empleado_id, dia, turno);

-- +goose Down
ALTER TABLE turnos DROP CONSTRAINT IF EXISTS turnos_planificacion_empleado_dia_turno_key;
ALTER TABLE turnos ADD CONSTRAINT turnos_planificacion_id_empleado_id_dia_key
  UNIQUE(planificacion_id, empleado_id, dia);
