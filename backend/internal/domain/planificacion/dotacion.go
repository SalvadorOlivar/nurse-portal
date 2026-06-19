package planificacion

import "time"

type SectorPlanificacion struct {
	ID              string
	PlanificacionID string
	Nombre          string
	CreatedAt       time.Time
}

type DotacionPlanificacion struct {
	ID              string
	PlanificacionID string
	Sector          string
	TipoEmpleado    string
	Turno           string
	CantidadMinima  int
	CreatedAt       time.Time
	UpdatedAt       time.Time
}
