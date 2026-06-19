package planificacion

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/domain/employee"
	"github.com/tuusuario/nursery-portal/internal/domain/planificacion"
	"github.com/tuusuario/nursery-portal/internal/domain/turno"
	"github.com/tuusuario/nursery-portal/internal/ports"
)

type CreatePlanificacionCommand struct {
	Mes    int
	Anio   int
	Nombre string
}

type CreatePlanificacionHandler struct {
	repo         ports.PlanificacionRepository
	dotacionRepo ports.DotacionRepository
}

func NewCreatePlanificacionHandler(repo ports.PlanificacionRepository, dotacionRepo ports.DotacionRepository) *CreatePlanificacionHandler {
	return &CreatePlanificacionHandler{
		repo:         repo,
		dotacionRepo: dotacionRepo,
	}
}

func (h *CreatePlanificacionHandler) Handle(ctx context.Context, cmd CreatePlanificacionCommand) (*planificacion.Planificacion, error) {
	p, err := planificacion.NewPlanificacion(planificacion.NewPlanificacionParams{
		Mes:    cmd.Mes,
		Anio:   cmd.Anio,
		Nombre: cmd.Nombre,
	})
	if err != nil {
		return nil, err
	}
	if err := h.repo.Create(ctx, p); err != nil {
		return nil, err
	}

	if err := h.seedDefaultDotacion(ctx, p.ID, cmd.Mes); err != nil {
		return nil, err
	}

	return p, nil
}

func defaultSectoresForMonth(mes int) []string {
	if mes == 6 || mes == 7 || mes == 8 {
		return []string{"1-8", "9-14", "15-20"}
	}
	return []string{"1-8", "9-14"}
}

func (h *CreatePlanificacionHandler) seedDefaultDotacion(ctx context.Context, planificacionID string, mes int) error {
	defaultSectores := defaultSectoresForMonth(mes)
	if err := h.dotacionRepo.SaveSectores(ctx, planificacionID, defaultSectores); err != nil {
		return err
	}

	turnos := turno.AllTiposTurno
	var items []*planificacion.DotacionPlanificacion

	for _, t := range turnos {
		turnoStr := string(t)
		items = append(items,
			&planificacion.DotacionPlanificacion{
				PlanificacionID: planificacionID,
				Sector:          "",
				TipoEmpleado:    string(employee.Supervisor),
				Turno:           turnoStr,
				CantidadMinima:  1,
			},
			&planificacion.DotacionPlanificacion{
				PlanificacionID: planificacionID,
				Sector:          "",
				TipoEmpleado:    string(employee.AuxiliarServicio),
				Turno:           turnoStr,
				CantidadMinima:  4,
			},
		)
		for _, s := range defaultSectores {
			items = append(items,
				&planificacion.DotacionPlanificacion{
					PlanificacionID: planificacionID,
					Sector:          s,
					TipoEmpleado:    string(employee.Nurse),
					Turno:           turnoStr,
					CantidadMinima:  2,
				},
				&planificacion.DotacionPlanificacion{
					PlanificacionID: planificacionID,
					Sector:          s,
					TipoEmpleado:    string(employee.NurseAssistant),
					Turno:           turnoStr,
					CantidadMinima:  4,
				},
			)
		}
	}

	return h.dotacionRepo.SaveDotacion(ctx, items)
}
