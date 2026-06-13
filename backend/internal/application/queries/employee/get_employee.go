package employee

import (
	"context"
	"fmt"

	"github.com/tuusuario/nursery-portal/internal/domain/employee"
	"github.com/tuusuario/nursery-portal/internal/ports"
)

type GetEmployeeByIDQuery struct {
	ID string
}

type GetEmployeeByIDHandler struct {
	repo ports.EmployeeRepository
}

func NewGetEmployeeByIDHandler(repo ports.EmployeeRepository) *GetEmployeeByIDHandler {
	return &GetEmployeeByIDHandler{repo: repo}
}

func (h *GetEmployeeByIDHandler) Handle(ctx context.Context, q GetEmployeeByIDQuery) (*employee.Employee, error) {
	emp, err := h.repo.FindByID(ctx, q.ID)
	if err != nil {
		return nil, fmt.Errorf("employee not found: %w", err)
	}
	return emp, nil
}
