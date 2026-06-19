package planificacion

import "github.com/tuusuario/nursery-portal/internal/domain/employee"

type DotacionItem struct {
	TipoEmpleado   employee.Type
	Turno          string
	CantidadMinima int
	Sector         string
}
