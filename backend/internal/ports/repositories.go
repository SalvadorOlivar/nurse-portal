package ports

import (
	"context"
	"time"

	"github.com/tuusuario/nursery-portal/internal/domain/auth"
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

type DotacionRepository interface {
	GetSectores(ctx context.Context, planificacionID string) ([]*planificacion.SectorPlanificacion, error)
	SaveSectores(ctx context.Context, planificacionID string, nombres []string) error
	GetDotacion(ctx context.Context, planificacionID string) ([]*planificacion.DotacionPlanificacion, error)
	SaveDotacion(ctx context.Context, items []*planificacion.DotacionPlanificacion) error
	DeleteByPlanificacion(ctx context.Context, planificacionID string) error
}

type AuthRepository interface {
	FindUserByUsername(ctx context.Context, username string) (*auth.User, error)
	FindUserBySessionHash(ctx context.Context, tokenHash string, now time.Time) (*auth.User, error)
	SetPasswordHash(ctx context.Context, userID, passwordHash string) error
	CreateSession(ctx context.Context, userID, tokenHash string, expiresAt time.Time) error
	DeleteSession(ctx context.Context, tokenHash string) error
	EnsureAdmin(ctx context.Context, username, passwordHash string) error
	CreateEmployeeUser(ctx context.Context, username string, role auth.Role, employeeID string, passwordHash string) error
	UpdateEmployeeUser(ctx context.Context, employeeID, username string, role auth.Role) error
}
