package postgres

import (
	"context"
	"errors"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/tuusuario/nursery-portal/internal/domain/employee"
)

type EmployeeRepository struct {
	pool *pgxpool.Pool
}

func NewEmployeeRepository(pool *pgxpool.Pool) *EmployeeRepository {
	return &EmployeeRepository{pool: pool}
}

func (r *EmployeeRepository) Create(ctx context.Context, e *employee.Employee) error {
	query := `
		INSERT INTO employees (id, nombre, apellido, tipo, horas_minimas, horas_maximas, work_days, rest_days, activo, created_at, updated_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
	`
	_, err := r.pool.Exec(ctx, query,
		e.ID, e.Nombre, e.Apellido, string(e.Tipo),
		e.HorasMinimas, e.HorasMaximas,
		e.PatronTrabajo.WorkDays, e.PatronTrabajo.RestDays,
		e.Activo, e.CreatedAt, e.UpdatedAt,
	)
	return err
}

func (r *EmployeeRepository) Update(ctx context.Context, e *employee.Employee) error {
	query := `
		UPDATE employees
		SET nombre = $1, apellido = $2, tipo = $3, horas_minimas = $4, horas_maximas = $5,
		    work_days = $6, rest_days = $7, activo = $8, updated_at = $9
		WHERE id = $10
	`
	_, err := r.pool.Exec(ctx, query,
		e.Nombre, e.Apellido, string(e.Tipo),
		e.HorasMinimas, e.HorasMaximas,
		e.PatronTrabajo.WorkDays, e.PatronTrabajo.RestDays,
		e.Activo, e.UpdatedAt, e.ID,
	)
	return err
}

func (r *EmployeeRepository) FindByID(ctx context.Context, id string) (*employee.Employee, error) {
	query := `
		SELECT id, nombre, apellido, tipo, horas_minimas, horas_maximas, work_days, rest_days, activo, created_at, updated_at
		FROM employees
		WHERE id = $1
	`
	row := r.pool.QueryRow(ctx, query, id)

	e, err := scanEmployee(row)
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, errors.New("employee not found")
		}
		return nil, err
	}
	return e, nil
}

func (r *EmployeeRepository) FindAll(ctx context.Context) ([]*employee.Employee, error) {
	query := `
		SELECT id, nombre, apellido, tipo, horas_minimas, horas_maximas, work_days, rest_days, activo, created_at, updated_at
		FROM employees
		ORDER BY apellido, nombre
	`
	rows, err := r.pool.Query(ctx, query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var employees []*employee.Employee
	for rows.Next() {
		e, err := scanEmployee(rows)
		if err != nil {
			return nil, err
		}
		employees = append(employees, e)
	}
	return employees, rows.Err()
}

func (r *EmployeeRepository) Delete(ctx context.Context, id string) error {
	query := `DELETE FROM employees WHERE id = $1`
	_, err := r.pool.Exec(ctx, query, id)
	return err
}

type scanner interface {
	Scan(dest ...any) error
}

func scanEmployee(s scanner) (*employee.Employee, error) {
	var (
		id, nombre, apellido, tipo string
		horasMinimas, horasMaximas int
		workDays, restDays         int
		activo                     bool
		createdAt, updatedAt       time.Time
	)
	err := s.Scan(&id, &nombre, &apellido, &tipo, &horasMinimas, &horasMaximas, &workDays, &restDays, &activo, &createdAt, &updatedAt)
	if err != nil {
		return nil, err
	}

	t, _ := employee.ParseType(tipo)
	wp, _ := employee.NewWorkPattern(workDays, restDays)

	return &employee.Employee{
		ID:            id,
		Nombre:        nombre,
		Apellido:      apellido,
		Tipo:          t,
		HorasMinimas:  horasMinimas,
		HorasMaximas:  horasMaximas,
		PatronTrabajo: wp,
		Activo:        activo,
		CreatedAt:     createdAt,
		UpdatedAt:     updatedAt,
	}, nil
}
