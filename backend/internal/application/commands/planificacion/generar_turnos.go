package planificacion

import (
	"context"
	"log/slog"

	"github.com/tuusuario/nursery-portal/internal/domain/employee"
	"github.com/tuusuario/nursery-portal/internal/domain/planificacion"
	"github.com/tuusuario/nursery-portal/internal/domain/turno"
	"github.com/tuusuario/nursery-portal/internal/ports"
)

type GenerarTurnosHandler struct {
	planifRepo ports.PlanificacionRepository
	empRepo    ports.EmployeeRepository
	turnoRepo  ports.TurnoRepository
}

func NewGenerarTurnosHandler(planifRepo ports.PlanificacionRepository, empRepo ports.EmployeeRepository, turnoRepo ports.TurnoRepository) *GenerarTurnosHandler {
	return &GenerarTurnosHandler{
		planifRepo: planifRepo,
		empRepo:    empRepo,
		turnoRepo:  turnoRepo,
	}
}

func (h *GenerarTurnosHandler) Handle(ctx context.Context, planificacionID string) error {
	p, err := h.planifRepo.FindByID(ctx, planificacionID)
	if err != nil {
		return err
	}

	if p.Estado != planificacion.EstadoBorrador {
		return err
	}

	empleados, err := h.empRepo.FindAll(ctx)
	if err != nil {
		return err
	}

	// Remove existing turnos for this planificacion
	if err := h.turnoRepo.DeleteByPlanificacion(ctx, planificacionID); err != nil {
		return err
	}

	var allTurnos []*turno.Turno
	dias := p.DiasDelMes()

	for _, emp := range empleados {
		if !emp.Activo {
			continue
		}
		turnos := generateForEmployee(p, emp, dias)
		allTurnos = append(allTurnos, turnos...)
	}

	if len(allTurnos) == 0 {
		slog.Info("no turnos generated", "planificacion_id", planificacionID)
		return nil
	}

	return h.turnoRepo.CreateBatch(ctx, allTurnos)
}

func generateForEmployee(p *planificacion.Planificacion, emp *employee.Employee, dias int) []*turno.Turno {
	var turnos []*turno.Turno
	cycle := emp.PatronTrabajo.WorkDays + emp.PatronTrabajo.RestDays
	if cycle == 0 {
		return turnos
	}

	for dia := 1; dia <= dias; dia++ {
		posInCycle := (dia - 1) % cycle
		if posInCycle < emp.PatronTrabajo.WorkDays {
			t, err := turno.NewTurno(turno.NewTurnoParams{
				PlanificacionID: p.ID,
				EmpleadoID:      emp.ID,
				Dia:             dia,
				Tipo:            turno.Maniana,
			})
			if err != nil {
				slog.Warn("failed to create turno", "error", err)
				continue
			}
			turnos = append(turnos, t)
		}
	}
	return turnos
}
