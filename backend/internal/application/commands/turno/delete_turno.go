package turno

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/ports"
)

type DeleteTurnoHandler struct {
	repo ports.TurnoRepository
}

func NewDeleteTurnoHandler(repo ports.TurnoRepository) *DeleteTurnoHandler {
	return &DeleteTurnoHandler{repo: repo}
}

func (h *DeleteTurnoHandler) Handle(ctx context.Context, id string) error {
	return h.repo.Delete(ctx, id)
}
