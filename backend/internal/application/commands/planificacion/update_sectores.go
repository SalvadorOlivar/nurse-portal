package planificacion

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/ports"
)

type UpdateSectoresCommand struct {
	PlanificacionID string
	Sectores        []string
}

type UpdateSectoresHandler struct {
	planifRepo ports.PlanificacionRepository
	dotacionRepo ports.DotacionRepository
}

func NewUpdateSectoresHandler(planifRepo ports.PlanificacionRepository, dotacionRepo ports.DotacionRepository) *UpdateSectoresHandler {
	return &UpdateSectoresHandler{
		planifRepo:   planifRepo,
		dotacionRepo: dotacionRepo,
	}
}

func (h *UpdateSectoresHandler) Handle(ctx context.Context, cmd UpdateSectoresCommand) error {
	if _, err := h.planifRepo.FindByID(ctx, cmd.PlanificacionID); err != nil {
		return err
	}
	return h.dotacionRepo.SaveSectores(ctx, cmd.PlanificacionID, cmd.Sectores)
}
