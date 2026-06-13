package ports

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/domain/employee"
	"github.com/tuusuario/nursery-portal/internal/domain/planificacion"
	"github.com/tuusuario/nursery-portal/internal/domain/turno"
)

type EmployeeRepository interface {
	Create(ctx context.Context, e *employee.Employee) error
	Update(ctx context.Context, e *employee.Employee) error
	FindByID(ctx context.Context, id string) (*employee.Employee, error)
	FindAll(ctx context.Context) ([]*employee.Employee, error)
	Delete(ctx context.Context, id string) error
}

type PlanificacionRepository interface {
	Create(ctx context.Context, p *planificacion.Planificacion) error
	Update(ctx context.Context, p *planificacion.Planificacion) error
	FindByID(ctx context.Context, id string) (*planificacion.Planificacion, error)
	FindAll(ctx context.Context) ([]*planificacion.Planificacion, error)
	Delete(ctx context.Context, id string) error
}

type TurnoRepository interface {
	Create(ctx context.Context, t *turno.Turno) error
	CreateBatch(ctx context.Context, turnos []*turno.Turno) error
	FindByPlanificacion(ctx context.Context, planificacionID string) ([]*turno.Turno, error)
	FindByPlanificacionAndEmpleado(ctx context.Context, planificacionID, empleadoID string) ([]*turno.Turno, error)
	Delete(ctx context.Context, id string) error
	DeleteByPlanificacion(ctx context.Context, planificacionID string) error
}
