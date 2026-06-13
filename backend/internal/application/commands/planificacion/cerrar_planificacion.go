package planificacion

import (
	"context"
	"fmt"

	"github.com/tuusuario/nursery-portal/internal/ports"
)

type CerrarPlanificacionHandler struct {
	repo ports.PlanificacionRepository
}

func NewCerrarPlanificacionHandler(repo ports.PlanificacionRepository) *CerrarPlanificacionHandler {
	return &CerrarPlanificacionHandler{repo: repo}
}

func (h *CerrarPlanificacionHandler) Handle(ctx context.Context, id string) error {
	p, err := h.repo.FindByID(ctx, id)
	if err != nil {
		return fmt.Errorf("planificacion not found")
	}
	if err := p.Cerrar(); err != nil {
		return err
	}
	return h.repo.Update(ctx, p)
}
