package employee

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/domain/employee"
	"github.com/tuusuario/nursery-portal/internal/ports"
)

type ListEmployeesQuery struct{}

type ListEmployeesHandler struct {
	repo ports.EmployeeRepository
}

func NewListEmployeesHandler(repo ports.EmployeeRepository) *ListEmployeesHandler {
	return &ListEmployeesHandler{repo: repo}
}

func (h *ListEmployeesHandler) Handle(ctx context.Context, _ ListEmployeesQuery) ([]*employee.Employee, error) {
	return h.repo.FindAll(ctx)
}
