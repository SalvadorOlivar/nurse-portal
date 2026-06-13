package planificacion

import (
	"context"
	"fmt"

	"github.com/tuusuario/nursery-portal/internal/ports"
)

type PublicarPlanificacionHandler struct {
	repo ports.PlanificacionRepository
}

func NewPublicarPlanificacionHandler(repo ports.PlanificacionRepository) *PublicarPlanificacionHandler {
	return &PublicarPlanificacionHandler{repo: repo}
}

func (h *PublicarPlanificacionHandler) Handle(ctx context.Context, id string) error {
	p, err := h.repo.FindByID(ctx, id)
	if err != nil {
		return fmt.Errorf("planificacion not found")
	}
	if err := p.Publicar(); err != nil {
		return err
	}
	return h.repo.Update(ctx, p)
}
