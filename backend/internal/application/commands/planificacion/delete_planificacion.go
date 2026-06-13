package planificacion

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/ports"
)

type DeletePlanificacionHandler struct {
	planificacionRepo ports.PlanificacionRepository
	turnoRepo         ports.TurnoRepository
}

func NewDeletePlanificacionHandler(planificacionRepo ports.PlanificacionRepository, turnoRepo ports.TurnoRepository) *DeletePlanificacionHandler {
	return &DeletePlanificacionHandler{
		planificacionRepo: planificacionRepo,
		turnoRepo:         turnoRepo,
	}
}

func (h *DeletePlanificacionHandler) Handle(ctx context.Context, id string) error {
	if err := h.turnoRepo.DeleteByPlanificacion(ctx, id); err != nil {
		return err
	}
	return h.planificacionRepo.Delete(ctx, id)
}
