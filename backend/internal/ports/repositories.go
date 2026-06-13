package ports

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/domain/employee"
)

type EmployeeRepository interface {
	Create(ctx context.Context, e *employee.Employee) error
	Update(ctx context.Context, e *employee.Employee) error
	FindByID(ctx context.Context, id string) (*employee.Employee, error)
	FindAll(ctx context.Context) ([]*employee.Employee, error)
	Delete(ctx context.Context, id string) error
}
