package planificacion

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/domain/planificacion"
	"github.com/tuusuario/nursery-portal/internal/ports"
)

type GetSectoresQuery struct {
	PlanificacionID string
}

type GetSectoresHandler struct {
	dotacionRepo ports.DotacionRepository
}

func NewGetSectoresHandler(dotacionRepo ports.DotacionRepository) *GetSectoresHandler {
	return &GetSectoresHandler{dotacionRepo: dotacionRepo}
}

func (h *GetSectoresHandler) Handle(ctx context.Context, query GetSectoresQuery) ([]*planificacion.SectorPlanificacion, error) {
	return h.dotacionRepo.GetSectores(ctx, query.PlanificacionID)
}
