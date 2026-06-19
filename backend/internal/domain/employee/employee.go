package employee

import (
	"fmt"
	"time"

	"github.com/google/uuid"
)

type Employee struct {
	ID            string
	Nombre        string
	Apellido      string
	Tipo          Type
	Sector        string
	HorasMinimas  int
	HorasMaximas  int
	PatronTrabajo WorkPattern
	Activo        bool
	CreatedAt     time.Time
	UpdatedAt     time.Time
}

type NewEmployeeParams struct {
	Nombre       string
	Apellido     string
	Tipo         Type
	Sector       string
	HorasMinimas int
	HorasMaximas int
	WorkPattern  *WorkPattern
}

func NewEmployee(params NewEmployeeParams) (*Employee, error) {
	if params.Nombre == "" {
		return nil, fmt.Errorf("nombre is required")
	}
	if params.Apellido == "" {
		return nil, fmt.Errorf("apellido is required")
	}
	if !params.Tipo.IsValid() {
		return nil, fmt.Errorf("invalid employee type: %s", params.Tipo)
	}
	if params.HorasMinimas <= 0 {
		return nil, fmt.Errorf("horas minimas must be greater than 0")
	}
	if params.HorasMaximas < params.HorasMinimas {
		return nil, fmt.Errorf("horas maximas must be >= horas minimas")
	}
	wp := DefaultWorkPattern()
	if params.WorkPattern != nil {
		wp = *params.WorkPattern
	}

	now := time.Now().UTC()
	return &Employee{
		ID:            uuid.New().String(),
		Nombre:        params.Nombre,
		Apellido:      params.Apellido,
		Tipo:          params.Tipo,
		Sector:        params.Sector,
		HorasMinimas:  params.HorasMinimas,
		HorasMaximas:  params.HorasMaximas,
		PatronTrabajo: wp,
		Activo:        true,
		CreatedAt:     now,
		UpdatedAt:     now,
	}, nil
}

type UpdateEmployeeParams struct {
	Nombre       string
	Apellido     string
	Tipo         Type
	Sector       string
	HorasMinimas int
	HorasMaximas int
	WorkPattern  *WorkPattern
}

func (e *Employee) Update(params UpdateEmployeeParams) error {
	if params.Nombre == "" {
		return fmt.Errorf("nombre is required")
	}
	if params.Apellido == "" {
		return fmt.Errorf("apellido is required")
	}
	if !params.Tipo.IsValid() {
		return fmt.Errorf("invalid employee type: %s", params.Tipo)
	}
	if params.HorasMinimas <= 0 {
		return fmt.Errorf("horas minimas must be greater than 0")
	}
	if params.HorasMaximas < params.HorasMinimas {
		return fmt.Errorf("horas maximas must be >= horas minimas")
	}

	e.Nombre = params.Nombre
	e.Apellido = params.Apellido
	e.Tipo = params.Tipo
	e.Sector = params.Sector
	e.HorasMinimas = params.HorasMinimas
	e.HorasMaximas = params.HorasMaximas
	if params.WorkPattern != nil {
		e.PatronTrabajo = *params.WorkPattern
	}
	e.UpdatedAt = time.Now().UTC()
	return nil
}

func (e *Employee) Deactivate() {
	e.Activo = false
	e.UpdatedAt = time.Now().UTC()
}

func (e *Employee) Activate() {
	e.Activo = true
	e.UpdatedAt = time.Now().UTC()
}
