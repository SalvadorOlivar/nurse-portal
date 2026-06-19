package services

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/domain/planificacion"
	"github.com/tuusuario/nursery-portal/internal/domain/turno"
	"github.com/tuusuario/nursery-portal/internal/ports"

	cmdplanif "github.com/tuusuario/nursery-portal/internal/application/commands/planificacion"
	cmdturno "github.com/tuusuario/nursery-portal/internal/application/commands/turno"
	qryplanif "github.com/tuusuario/nursery-portal/internal/application/queries/planificacion"
)

type PlanificacionService struct {
	createHandler          *cmdplanif.CreatePlanificacionHandler
	updateHandler          *cmdplanif.UpdatePlanificacionHandler
	deleteHandler          *cmdplanif.DeletePlanificacionHandler
	publicarHandler        *cmdplanif.PublicarPlanificacionHandler
	cerrarHandler          *cmdplanif.CerrarPlanificacionHandler
	listHandler            *qryplanif.ListPlanificacionesHandler
	getByIDHandler         *qryplanif.GetPlanificacionHandler
	createTurnoHandler     *cmdturno.CreateTurnoHandler
	deleteTurnoHandler     *cmdturno.DeleteTurnoHandler
	getSectoresHandler     *qryplanif.GetSectoresHandler
	getDotacionHandler     *qryplanif.GetDotacionHandler
	updateSectoresHandler  *cmdplanif.UpdateSectoresHandler
	updateDotacionHandler  *cmdplanif.UpdateDotacionHandler
}

func NewPlanificacionService(
	planifRepo ports.PlanificacionRepository,
	turnoRepo ports.TurnoRepository,
	dotacionRepo ports.DotacionRepository,
) *PlanificacionService {
	return &PlanificacionService{
		createHandler:          cmdplanif.NewCreatePlanificacionHandler(planifRepo, dotacionRepo),
		updateHandler:          cmdplanif.NewUpdatePlanificacionHandler(planifRepo),
		deleteHandler:          cmdplanif.NewDeletePlanificacionHandler(planifRepo, turnoRepo, dotacionRepo),
		publicarHandler:        cmdplanif.NewPublicarPlanificacionHandler(planifRepo),
		cerrarHandler:          cmdplanif.NewCerrarPlanificacionHandler(planifRepo),
		listHandler:            qryplanif.NewListPlanificacionesHandler(planifRepo),
		getByIDHandler:         qryplanif.NewGetPlanificacionHandler(planifRepo, turnoRepo),
		createTurnoHandler:     cmdturno.NewCreateTurnoHandler(turnoRepo),
		deleteTurnoHandler:     cmdturno.NewDeleteTurnoHandler(turnoRepo),
		getSectoresHandler:     qryplanif.NewGetSectoresHandler(dotacionRepo),
		getDotacionHandler:     qryplanif.NewGetDotacionHandler(dotacionRepo),
		updateSectoresHandler:  cmdplanif.NewUpdateSectoresHandler(planifRepo, dotacionRepo),
		updateDotacionHandler:  cmdplanif.NewUpdateDotacionHandler(planifRepo, dotacionRepo),
	}
}

func (s *PlanificacionService) Create(ctx context.Context, cmd cmdplanif.CreatePlanificacionCommand) (*planificacion.Planificacion, error) {
	return s.createHandler.Handle(ctx, cmd)
}

func (s *PlanificacionService) Update(ctx context.Context, cmd cmdplanif.UpdatePlanificacionCommand) error {
	return s.updateHandler.Handle(ctx, cmd)
}

func (s *PlanificacionService) Delete(ctx context.Context, id string) error {
	return s.deleteHandler.Handle(ctx, id)
}

func (s *PlanificacionService) Publicar(ctx context.Context, id string) error {
	return s.publicarHandler.Handle(ctx, id)
}

func (s *PlanificacionService) Cerrar(ctx context.Context, id string) error {
	return s.cerrarHandler.Handle(ctx, id)
}

func (s *PlanificacionService) List(ctx context.Context) ([]*planificacion.Planificacion, error) {
	return s.listHandler.Handle(ctx, qryplanif.ListPlanificacionesQuery{})
}

func (s *PlanificacionService) GetByID(ctx context.Context, id string) (*qryplanif.PlanificacionConTurnos, error) {
	return s.getByIDHandler.Handle(ctx, qryplanif.GetPlanificacionQuery{ID: id})
}

func (s *PlanificacionService) CreateTurno(ctx context.Context, cmd cmdturno.CreateTurnoCommand) (*turno.Turno, error) {
	return s.createTurnoHandler.Handle(ctx, cmd)
}

func (s *PlanificacionService) DeleteTurno(ctx context.Context, id string) error {
	return s.deleteTurnoHandler.Handle(ctx, id)
}

func (s *PlanificacionService) GetStaffingRequirements(ctx context.Context, planificacionID string) ([]planificacion.DotacionItem, error) {
	return s.getDotacionHandler.Handle(ctx, qryplanif.GetDotacionQuery{PlanificacionID: planificacionID})
}

func (s *PlanificacionService) GetSectores(ctx context.Context, planificacionID string) ([]*planificacion.SectorPlanificacion, error) {
	return s.getSectoresHandler.Handle(ctx, qryplanif.GetSectoresQuery{PlanificacionID: planificacionID})
}

func (s *PlanificacionService) UpdateSectores(ctx context.Context, cmd cmdplanif.UpdateSectoresCommand) error {
	return s.updateSectoresHandler.Handle(ctx, cmd)
}

func (s *PlanificacionService) UpdateDotacion(ctx context.Context, cmd cmdplanif.UpdateDotacionCommand) error {
	return s.updateDotacionHandler.Handle(ctx, cmd)
}

