package planificacion

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/domain/planificacion"
	"github.com/tuusuario/nursery-portal/internal/ports"
)

type ListPlanificacionesQuery struct{}

type ListPlanificacionesHandler struct {
	repo ports.PlanificacionRepository
}

func NewListPlanificacionesHandler(repo ports.PlanificacionRepository) *ListPlanificacionesHandler {
	return &ListPlanificacionesHandler{repo: repo}
}

func (h *ListPlanificacionesHandler) Handle(ctx context.Context, _ ListPlanificacionesQuery) ([]*planificacion.Planificacion, error) {
	return h.repo.FindAll(ctx)
}
