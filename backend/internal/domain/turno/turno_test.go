package turno

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestNewTurno(t *testing.T) {
	tr, err := NewTurno(NewTurnoParams{
		PlanificacionID: "plan-1",
		EmpleadoID:      "emp-1",
		Dia:             15,
		Tipo:            Maniana,
	})
	require.NoError(t, err)
	assert.Equal(t, "plan-1", tr.PlanificacionID)
	assert.Equal(t, "emp-1", tr.EmpleadoID)
	assert.Equal(t, 15, tr.Dia)
	assert.Equal(t, Maniana, tr.Tipo)
	assert.NotEmpty(t, tr.ID)
}

func TestNewTurno_InvalidDia(t *testing.T) {
	_, err := NewTurno(NewTurnoParams{
		PlanificacionID: "plan-1",
		EmpleadoID:      "emp-1",
		Dia:             0,
		Tipo:            Maniana,
	})
	assert.Error(t, err)
}

func TestNewTurno_InvalidTipo(t *testing.T) {
	_, err := NewTurno(NewTurnoParams{
		PlanificacionID: "plan-1",
		EmpleadoID:      "emp-1",
		Dia:             1,
		Tipo:            "INVALIDO",
	})
	assert.Error(t, err)
}
