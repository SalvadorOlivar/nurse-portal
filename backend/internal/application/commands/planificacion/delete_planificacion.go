package planificacion

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/ports"
)

type DeletePlanificacionHandler struct {
	planificacionRepo ports.PlanificacionRepository
	turnoRepo         ports.TurnoRepository
	dotacionRepo      ports.DotacionRepository
}

func NewDeletePlanificacionHandler(planificacionRepo ports.PlanificacionRepository, turnoRepo ports.TurnoRepository, dotacionRepo ports.DotacionRepository) *DeletePlanificacionHandler {
	return &DeletePlanificacionHandler{
		planificacionRepo: planificacionRepo,
		turnoRepo:         turnoRepo,
		dotacionRepo:      dotacionRepo,
	}
}

func (h *DeletePlanificacionHandler) Handle(ctx context.Context, id string) error {
	if err := h.dotacionRepo.DeleteByPlanificacion(ctx, id); err != nil {
		return err
	}
	if err := h.turnoRepo.DeleteByPlanificacion(ctx, id); err != nil {
		return err
	}
	return h.planificacionRepo.Delete(ctx, id)
}
