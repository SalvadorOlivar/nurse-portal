package postgres

import (
	"context"
	"errors"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/tuusuario/nursery-portal/internal/domain/planificacion"
)

type PlanificacionRepository struct {
	pool *pgxpool.Pool
}

func NewPlanificacionRepository(pool *pgxpool.Pool) *PlanificacionRepository {
	return &PlanificacionRepository{pool: pool}
}

func (r *PlanificacionRepository) Create(ctx context.Context, p *planificacion.Planificacion) error {
	query := `
		INSERT INTO planificaciones (id, mes, anio, nombre, estado, created_at, updated_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7)
	`
	_, err := r.pool.Exec(ctx, query,
		p.ID, p.Mes, p.Anio, p.Nombre, string(p.Estado),
		p.CreatedAt, p.UpdatedAt,
	)
	return err
}

func (r *PlanificacionRepository) Update(ctx context.Context, p *planificacion.Planificacion) error {
	query := `
		UPDATE planificaciones
		SET nombre = $1, estado = $2, updated_at = $3
		WHERE id = $4
	`
	_, err := r.pool.Exec(ctx, query, p.Nombre, string(p.Estado), p.UpdatedAt, p.ID)
	return err
}

func (r *PlanificacionRepository) FindByID(ctx context.Context, id string) (*planificacion.Planificacion, error) {
	query := `
		SELECT id, mes, anio, nombre, estado, created_at, updated_at
		FROM planificaciones
		WHERE id = $1
	`
	row := r.pool.QueryRow(ctx, query, id)
	p, err := scanPlanificacion(row)
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, errors.New("planificacion not found")
		}
		return nil, err
	}
	return p, nil
}

func (r *PlanificacionRepository) FindAll(ctx context.Context) ([]*planificacion.Planificacion, error) {
	query := `
		SELECT id, mes, anio, nombre, estado, created_at, updated_at
		FROM planificaciones
		ORDER BY anio DESC, mes DESC
	`
	rows, err := r.pool.Query(ctx, query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var plans []*planificacion.Planificacion
	for rows.Next() {
		p, err := scanPlanificacion(rows)
		if err != nil {
			return nil, err
		}
		plans = append(plans, p)
	}
	return plans, rows.Err()
}

func (r *PlanificacionRepository) Delete(ctx context.Context, id string) error {
	query := `DELETE FROM planificaciones WHERE id = $1`
	_, err := r.pool.Exec(ctx, query, id)
	return err
}

func scanPlanificacion(s scanner) (*planificacion.Planificacion, error) {
	var (
		id, nombre, estado string
		mes, anio          int
		createdAt, updatedAt time.Time
	)
	err := s.Scan(&id, &mes, &anio, &nombre, &estado, &createdAt, &updatedAt)
	if err != nil {
		return nil, err
	}
	return &planificacion.Planificacion{
		ID:        id,
		Mes:       mes,
		Anio:      anio,
		Nombre:    nombre,
		Estado:    planificacion.Estado(estado),
		CreatedAt: createdAt,
		UpdatedAt: updatedAt,
	}, nil
}
