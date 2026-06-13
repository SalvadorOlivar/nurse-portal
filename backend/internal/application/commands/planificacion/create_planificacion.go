package planificacion

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/domain/planificacion"
	"github.com/tuusuario/nursery-portal/internal/ports"
)

type CreatePlanificacionCommand struct {
	Mes    int
	Anio   int
	Nombre string
}

type CreatePlanificacionHandler struct {
	repo ports.PlanificacionRepository
}

func NewCreatePlanificacionHandler(repo ports.PlanificacionRepository) *CreatePlanificacionHandler {
	return &CreatePlanificacionHandler{repo: repo}
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
	return p, nil
}
