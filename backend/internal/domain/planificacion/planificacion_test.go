package planificacion

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestNewPlanificacion(t *testing.T) {
	p, err := NewPlanificacion(NewPlanificacionParams{
		Mes:    6,
		Anio:   2026,
		Nombre: "Planificación Junio 2026",
	})
	require.NoError(t, err)
	assert.Equal(t, 6, p.Mes)
	assert.Equal(t, 2026, p.Anio)
	assert.Equal(t, "Planificación Junio 2026", p.Nombre)
	assert.Equal(t, EstadoBorrador, p.Estado)
	assert.NotEmpty(t, p.ID)
	assert.Equal(t, 30, p.DiasDelMes())
}

func TestNewPlanificacion_InvalidMes(t *testing.T) {
	_, err := NewPlanificacion(NewPlanificacionParams{Mes: 13, Anio: 2026, Nombre: "test"})
	assert.Error(t, err)
}

func TestPlanificacion_Publicar(t *testing.T) {
	p, _ := NewPlanificacion(NewPlanificacionParams{Mes: 6, Anio: 2026, Nombre: "test"})
	err := p.Publicar()
	assert.NoError(t, err)
	assert.Equal(t, EstadoPublicado, p.Estado)
}

func TestPlanificacion_Publicar_Twice(t *testing.T) {
	p, _ := NewPlanificacion(NewPlanificacionParams{Mes: 6, Anio: 2026, Nombre: "test"})
	_ = p.Publicar()
	err := p.Publicar()
	assert.Error(t, err)
}

func TestPlanificacion_Cerrar(t *testing.T) {
	p, _ := NewPlanificacion(NewPlanificacionParams{Mes: 6, Anio: 2026, Nombre: "test"})
	_ = p.Publicar()
	err := p.Cerrar()
	assert.NoError(t, err)
	assert.Equal(t, EstadoCerrado, p.Estado)
}

func TestDiasDelMes(t *testing.T) {
	assert.Equal(t, 31, daysInMonth(1, 2026))
	assert.Equal(t, 28, daysInMonth(2, 2025))
	assert.Equal(t, 29, daysInMonth(2, 2024))
	assert.Equal(t, 30, daysInMonth(4, 2026))
}
