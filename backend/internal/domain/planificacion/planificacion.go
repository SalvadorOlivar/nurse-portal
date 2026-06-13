package planificacion

import (
	"fmt"
	"time"

	"github.com/google/uuid"
)

type Estado string

const (
	EstadoBorrador  Estado = "BORRADOR"
	EstadoPublicado Estado = "PUBLICADO"
	EstadoCerrado   Estado = "CERRADO"
)

func (e Estado) IsValid() bool {
	switch e {
	case EstadoBorrador, EstadoPublicado, EstadoCerrado:
		return true
	}
	return false
}

type Planificacion struct {
	ID        string
	Mes       int
	Anio      int
	Nombre    string
	Estado    Estado
	CreatedAt time.Time
	UpdatedAt time.Time
}

type NewPlanificacionParams struct {
	Mes    int
	Anio   int
	Nombre string
}

func NewPlanificacion(params NewPlanificacionParams) (*Planificacion, error) {
	if params.Mes < 1 || params.Mes > 12 {
		return nil, fmt.Errorf("mes must be between 1 and 12")
	}
	if params.Anio < 2020 || params.Anio > 2100 {
		return nil, fmt.Errorf("anio must be between 2020 and 2100")
	}
	if params.Nombre == "" {
		return nil, fmt.Errorf("nombre is required")
	}

	now := time.Now().UTC()
	return &Planificacion{
		ID:        uuid.New().String(),
		Mes:       params.Mes,
		Anio:      params.Anio,
		Nombre:    params.Nombre,
		Estado:    EstadoBorrador,
		CreatedAt: now,
		UpdatedAt: now,
	}, nil
}

func (p *Planificacion) Publicar() error {
	if p.Estado != EstadoBorrador {
		return fmt.Errorf("only plans in BORRADOR can be published")
	}
	p.Estado = EstadoPublicado
	p.UpdatedAt = time.Now().UTC()
	return nil
}

func (p *Planificacion) Cerrar() error {
	if p.Estado != EstadoPublicado {
		return fmt.Errorf("only plans in PUBLICADO can be closed")
	}
	p.Estado = EstadoCerrado
	p.UpdatedAt = time.Now().UTC()
	return nil
}

func (p *Planificacion) DiasDelMes() int {
	return daysInMonth(p.Mes, p.Anio)
}

func daysInMonth(mes, anio int) int {
	switch mes {
	case 1, 3, 5, 7, 8, 10, 12:
		return 31
	case 4, 6, 9, 11:
		return 30
	case 2:
		if isLeapYear(anio) {
			return 29
		}
		return 28
	}
	return 30
}

func isLeapYear(anio int) bool {
	return anio%4 == 0 && (anio%100 != 0 || anio%400 == 0)
}
