package planificacion

import "github.com/tuusuario/nursery-portal/internal/domain/employee"

type SectorDotacion struct {
	Nombre       string
	Enfermeros   int
	AuxEnfermeria int
}

var sectores = []SectorDotacion{
	{Nombre: "1-8", Enfermeros: 2, AuxEnfermeria: 4},
	{Nombre: "9-14", Enfermeros: 1, AuxEnfermeria: 2},
	{Nombre: "15-20", Enfermeros: 1, AuxEnfermeria: 2},
}

const (
	SupervisoresPorTurno      = 1
	AuxiliaresServicioPorTurno = 4
)

type DotacionItem struct {
	TipoEmpleado   employee.Type
	Turno          string
	CantidadMinima int
	Sector         string
}

func CalcularDotacion() []DotacionItem {
	turnos := []string{"MANANA", "TARDE", "VESPERTINO", "NOCHE"}
	var result []DotacionItem
	for _, turno := range turnos {
		result = append(result,
			DotacionItem{TipoEmpleado: employee.Supervisor, Turno: turno, CantidadMinima: SupervisoresPorTurno},
			DotacionItem{TipoEmpleado: employee.AuxiliarServicio, Turno: turno, CantidadMinima: AuxiliaresServicioPorTurno},
		)
		for _, s := range sectores {
			result = append(result,
				DotacionItem{TipoEmpleado: employee.Nurse, Turno: turno, CantidadMinima: s.Enfermeros, Sector: s.Nombre},
				DotacionItem{TipoEmpleado: employee.NurseAssistant, Turno: turno, CantidadMinima: s.AuxEnfermeria, Sector: s.Nombre},
			)
		}
	}
	return result
}
