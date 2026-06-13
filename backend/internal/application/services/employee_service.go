package services

import (
	"context"

	domain "github.com/tuusuario/nursery-portal/internal/domain/employee"
	"github.com/tuusuario/nursery-portal/internal/ports"

	cmd "github.com/tuusuario/nursery-portal/internal/application/commands/employee"
	qry "github.com/tuusuario/nursery-portal/internal/application/queries/employee"
)

type EmployeeService struct {
	createHandler    *cmd.CreateEmployeeHandler
	updateHandler    *cmd.UpdateEmployeeHandler
	deactivateHandler *cmd.DeactivateEmployeeHandler
	listHandler      *qry.ListEmployeesHandler
	getByIDHandler   *qry.GetEmployeeByIDHandler
}

func NewEmployeeService(repo ports.EmployeeRepository) *EmployeeService {
	return &EmployeeService{
		createHandler:    cmd.NewCreateEmployeeHandler(repo),
		updateHandler:    cmd.NewUpdateEmployeeHandler(repo),
		deactivateHandler: cmd.NewDeactivateEmployeeHandler(repo),
		listHandler:      qry.NewListEmployeesHandler(repo),
		getByIDHandler:   qry.NewGetEmployeeByIDHandler(repo),
	}
}

func (s *EmployeeService) Create(ctx context.Context, params cmd.CreateEmployeeCommand) (*domain.Employee, error) {
	return s.createHandler.Handle(ctx, params)
}

func (s *EmployeeService) Update(ctx context.Context, params cmd.UpdateEmployeeCommand) (*domain.Employee, error) {
	return s.updateHandler.Handle(ctx, params)
}

func (s *EmployeeService) Deactivate(ctx context.Context, id string) error {
	return s.deactivateHandler.Handle(ctx, cmd.DeactivateEmployeeCommand{ID: id})
}

func (s *EmployeeService) List(ctx context.Context) ([]*domain.Employee, error) {
	return s.listHandler.Handle(ctx, qry.ListEmployeesQuery{})
}

func (s *EmployeeService) GetByID(ctx context.Context, id string) (*domain.Employee, error) {
	return s.getByIDHandler.Handle(ctx, qry.GetEmployeeByIDQuery{ID: id})
}
