package turno

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/domain/turno"
	"github.com/tuusuario/nursery-portal/internal/ports"
)

type CreateTurnoCommand struct {
	PlanificacionID string
	EmpleadoID      string
	Dia             int
	Tipo            string
}

type CreateTurnoHandler struct {
	repo ports.TurnoRepository
}

func NewCreateTurnoHandler(repo ports.TurnoRepository) *CreateTurnoHandler {
	return &CreateTurnoHandler{repo: repo}
}

func (h *CreateTurnoHandler) Handle(ctx context.Context, cmd CreateTurnoCommand) (*turno.Turno, error) {
	t, err := turno.NewTurno(turno.NewTurnoParams{
		PlanificacionID: cmd.PlanificacionID,
		EmpleadoID:      cmd.EmpleadoID,
		Dia:             cmd.Dia,
		Tipo:            turno.TipoTurno(cmd.Tipo),
	})
	if err != nil {
		return nil, err
	}
	if err := h.repo.Create(ctx, t); err != nil {
		return nil, err
	}
	return t, nil
}
