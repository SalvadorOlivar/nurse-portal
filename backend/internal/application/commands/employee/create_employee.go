package employee

import (
	"context"

	"github.com/tuusuario/nurse-portal/internal/domain/employee"
	"github.com/tuusuario/nurse-portal/internal/ports"
)

type CreateEmployeeCommand struct {
	Nombre       string
	Apellido     string
	Tipo         string
	HorasMinimas int
	HorasMaximas int
	WorkDays     *int
	RestDays     *int
}

type CreateEmployeeHandler struct {
	repo ports.EmployeeRepository
}

func NewCreateEmployeeHandler(repo ports.EmployeeRepository) *CreateEmployeeHandler {
	return &CreateEmployeeHandler{repo: repo}
}

func (h *CreateEmployeeHandler) Handle(ctx context.Context, cmd CreateEmployeeCommand) (*employee.Employee, error) {
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

	emp, err := employee.NewEmployee(employee.NewEmployeeParams{
		Nombre:       cmd.Nombre,
		Apellido:     cmd.Apellido,
		Tipo:         tipo,
		HorasMinimas: cmd.HorasMinimas,
		HorasMaximas: cmd.HorasMaximas,
		WorkPattern:  wp,
	})
	if err != nil {
		return nil, err
	}

	if err := h.repo.Create(ctx, emp); err != nil {
		return nil, err
	}

	return emp, nil
}
