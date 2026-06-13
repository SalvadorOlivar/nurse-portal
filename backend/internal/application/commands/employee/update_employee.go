package employee

import (
	"context"
	"fmt"

	"github.com/tuusuario/nursery-portal/internal/domain/employee"
	"github.com/tuusuario/nursery-portal/internal/ports"
)

type UpdateEmployeeCommand struct {
	ID           string
	Nombre       string
	Apellido     string
	Tipo         string
	Sector       string
	HorasMinimas int
	HorasMaximas int
	WorkDays     *int
	RestDays     *int
}

type UpdateEmployeeHandler struct {
	repo ports.EmployeeRepository
}

func NewUpdateEmployeeHandler(repo ports.EmployeeRepository) *UpdateEmployeeHandler {
	return &UpdateEmployeeHandler{repo: repo}
}

func (h *UpdateEmployeeHandler) Handle(ctx context.Context, cmd UpdateEmployeeCommand) (*employee.Employee, error) {
	emp, err := h.repo.FindByID(ctx, cmd.ID)
	if err != nil {
		return nil, fmt.Errorf("employee not found: %w", err)
	}

	tipo, err := employee.ParseType(cmd.Tipo)
	if err != nil {
		return nil, err
	}

	var wp *employee.WorkPattern
	if cmd.WorkDays != nil && cmd.RestDays != nil {
		pattern, err := employee.NewWorkPattern(*cmd.WorkDays, *cmd.RestDays)
		if err != nil {
			return nil, err
		}
		wp = &pattern
	}

	if err := emp.Update(employee.UpdateEmployeeParams{
		Nombre:       cmd.Nombre,
		Apellido:     cmd.Apellido,
		Tipo:         tipo,
		Sector:       cmd.Sector,
		HorasMinimas: cmd.HorasMinimas,
		HorasMaximas: cmd.HorasMaximas,
		WorkPattern:  wp,
	}); err != nil {
		return nil, err
	}

	if err := h.repo.Update(ctx, emp); err != nil {
		return nil, err
	}

	return emp, nil
}
