package employee_test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"github.com/tuusuario/nurse-portal/internal/domain/employee"
)

func TestNewEmployee_Success(t *testing.T) {
	wp, _ := employee.NewWorkPattern(4, 1)
	e, err := employee.NewEmployee(employee.NewEmployeeParams{
		Nombre:       "María",
		Apellido:     "González",
		Tipo:         employee.Nurse,
		HorasMinimas: 120,
		HorasMaximas: 200,
		WorkPattern:  &wp,
	})
	require.NoError(t, err)
	assert.NotEmpty(t, e.ID)
	assert.Equal(t, "María", e.Nombre)
	assert.Equal(t, "González", e.Apellido)
	assert.Equal(t, employee.Nurse, e.Tipo)
	assert.Equal(t, 120, e.HorasMinimas)
	assert.Equal(t, 200, e.HorasMaximas)
	assert.Equal(t, 4, e.PatronTrabajo.WorkDays)
	assert.Equal(t, 1, e.PatronTrabajo.RestDays)
	assert.True(t, e.Activo)
	assert.False(t, e.CreatedAt.IsZero())
	assert.False(t, e.UpdatedAt.IsZero())
}

func TestNewEmployee_DefaultWorkPattern(t *testing.T) {
	e, err := employee.NewEmployee(employee.NewEmployeeParams{
		Nombre:       "Ana",
		Apellido:     "López",
		Tipo:         employee.NurseAssistant,
		HorasMinimas: 100,
		HorasMaximas: 180,
	})
	require.NoError(t, err)
	assert.Equal(t, 4, e.PatronTrabajo.WorkDays)
	assert.Equal(t, 1, e.PatronTrabajo.RestDays)
}

func TestNewEmployee_ValidationErrors(t *testing.T) {
	tests := []struct {
		name    string
		params  employee.NewEmployeeParams
		wantErr string
	}{
		{
			name:    "empty nombre",
			params:  employee.NewEmployeeParams{Apellido: "Test", Tipo: employee.Nurse, HorasMinimas: 100, HorasMaximas: 200},
			wantErr: "nombre is required",
		},
		{
			name:    "empty apellido",
			params:  employee.NewEmployeeParams{Nombre: "Test", Tipo: employee.Nurse, HorasMinimas: 100, HorasMaximas: 200},
			wantErr: "apellido is required",
		},
		{
			name:    "invalid type",
			params:  employee.NewEmployeeParams{Nombre: "Test", Apellido: "Test", Tipo: "INVALID", HorasMinimas: 100, HorasMaximas: 200},
			wantErr: "invalid employee type: INVALID",
		},
		{
			name:    "horas minimas zero",
			params:  employee.NewEmployeeParams{Nombre: "Test", Apellido: "Test", Tipo: employee.Nurse, HorasMinimas: 0, HorasMaximas: 200},
			wantErr: "horas minimas must be greater than 0",
		},
		{
			name:    "horas maximas less than minimas",
			params:  employee.NewEmployeeParams{Nombre: "Test", Apellido: "Test", Tipo: employee.Nurse, HorasMinimas: 200, HorasMaximas: 100},
			wantErr: "horas maximas must be >= horas minimas",
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			_, err := employee.NewEmployee(tt.params)
			assert.EqualError(t, err, tt.wantErr)
		})
	}
}

func TestEmployee_Update(t *testing.T) {
	e := createTestEmployee(t)

	err := e.Update(employee.UpdateEmployeeParams{
		Nombre:       "María Updated",
		Apellido:     "González Updated",
		Tipo:         employee.NurseAssistant,
		HorasMinimas: 130,
		HorasMaximas: 210,
	})
	require.NoError(t, err)
	assert.Equal(t, "María Updated", e.Nombre)
	assert.Equal(t, "González Updated", e.Apellido)
	assert.Equal(t, employee.NurseAssistant, e.Tipo)
	assert.Equal(t, 130, e.HorasMinimas)
	assert.Equal(t, 210, e.HorasMaximas)
}

func TestEmployee_Update_WithWorkPattern(t *testing.T) {
	e := createTestEmployee(t)
	wp, _ := employee.NewWorkPattern(5, 2)

	err := e.Update(employee.UpdateEmployeeParams{
		Nombre:       e.Nombre,
		Apellido:     e.Apellido,
		Tipo:         e.Tipo,
		HorasMinimas: e.HorasMinimas,
		HorasMaximas: e.HorasMaximas,
		WorkPattern:  &wp,
	})
	require.NoError(t, err)
	assert.Equal(t, 5, e.PatronTrabajo.WorkDays)
	assert.Equal(t, 2, e.PatronTrabajo.RestDays)
}

func TestEmployee_Update_Validation(t *testing.T) {
	e := createTestEmployee(t)
	err := e.Update(employee.UpdateEmployeeParams{
		Nombre: "",
	})
	assert.EqualError(t, err, "nombre is required")
}

func TestEmployee_Deactivate(t *testing.T) {
	e := createTestEmployee(t)
	e.Deactivate()
	assert.False(t, e.Activo)
}

func TestEmployee_Activate(t *testing.T) {
	e := createTestEmployee(t)
	e.Deactivate()
	assert.False(t, e.Activo)
	e.Activate()
	assert.True(t, e.Activo)
}

func createTestEmployee(t *testing.T) *employee.Employee {
	t.Helper()
	e, err := employee.NewEmployee(employee.NewEmployeeParams{
		Nombre:       "María",
		Apellido:     "González",
		Tipo:         employee.Nurse,
		HorasMinimas: 120,
		HorasMaximas: 200,
	})
	require.NoError(t, err)
	return e
}
