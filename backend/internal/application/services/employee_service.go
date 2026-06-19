package services

import (
	"context"

	domain "github.com/tuusuario/nursery-portal/internal/domain/employee"
	"github.com/tuusuario/nursery-portal/internal/ports"

	cmd "github.com/tuusuario/nursery-portal/internal/application/commands/employee"
	qry "github.com/tuusuario/nursery-portal/internal/application/queries/employee"
)

type EmployeeService struct {
	repo              ports.EmployeeRepository
	authSvc           *AuthService
	createHandler     *cmd.CreateEmployeeHandler
	updateHandler     *cmd.UpdateEmployeeHandler
	deactivateHandler *cmd.DeactivateEmployeeHandler
	listHandler       *qry.ListEmployeesHandler
	getByIDHandler    *qry.GetEmployeeByIDHandler
}

func NewEmployeeService(repo ports.EmployeeRepository, authSvc *AuthService) *EmployeeService {
	return &EmployeeService{
		repo:              repo,
		authSvc:           authSvc,
		createHandler:     cmd.NewCreateEmployeeHandler(repo),
		updateHandler:     cmd.NewUpdateEmployeeHandler(repo),
		deactivateHandler: cmd.NewDeactivateEmployeeHandler(repo),
		listHandler:       qry.NewListEmployeesHandler(repo),
		getByIDHandler:    qry.NewGetEmployeeByIDHandler(repo),
	}
}

func (s *EmployeeService) Create(ctx context.Context, params cmd.CreateEmployeeCommand) (*domain.Employee, error) {
	emp, err := s.createHandler.Handle(ctx, params)
	if err != nil {
		return nil, err
	}
	if s.authSvc == nil {
		return emp, nil
	}
	if err := s.authSvc.CreateEmployeeAccount(ctx, emp); err != nil {
		_ = s.repo.Delete(ctx, emp.ID)
		return nil, err
	}
	return emp, nil
}

func (s *EmployeeService) Update(ctx context.Context, params cmd.UpdateEmployeeCommand) (*domain.Employee, error) {
	emp, err := s.updateHandler.Handle(ctx, params)
	if err != nil {
		return nil, err
	}
	if s.authSvc != nil {
		if err := s.authSvc.UpdateEmployeeAccount(ctx, emp); err != nil {
			return nil, err
		}
	}
	return emp, nil
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
