package employee

import (
	"context"
	"fmt"

	"github.com/tuusuario/nurse-portal/internal/ports"
)

type DeactivateEmployeeCommand struct {
	ID string
}

type DeactivateEmployeeHandler struct {
	repo ports.EmployeeRepository
}

func NewDeactivateEmployeeHandler(repo ports.EmployeeRepository) *DeactivateEmployeeHandler {
	return &DeactivateEmployeeHandler{repo: repo}
}

func (h *DeactivateEmployeeHandler) Handle(ctx context.Context, cmd DeactivateEmployeeCommand) error {
	emp, err := h.repo.FindByID(ctx, cmd.ID)
	if err != nil {
		return fmt.Errorf("employee not found: %w", err)
	}

	emp.Deactivate()

	return h.repo.Update(ctx, emp)
}
