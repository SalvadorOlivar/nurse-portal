package employee_test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/tuusuario/nursery-portal/internal/domain/employee"
)

func TestParseType_Success(t *testing.T) {
	tests := []struct {
		input string
		want  employee.Type
	}{
		{"NURSE", employee.Nurse},
		{"NURSE_ASSISTANT", employee.NurseAssistant},
	}
	for _, tt := range tests {
		t.Run(tt.input, func(t *testing.T) {
			got, err := employee.ParseType(tt.input)
			assert.NoError(t, err)
			assert.Equal(t, tt.want, got)
		})
	}
}

func TestParseType_Invalid(t *testing.T) {
	_, err := employee.ParseType("DOCTOR")
	assert.EqualError(t, err, "invalid employee type: DOCTOR")
}

func TestType_IsValid(t *testing.T) {
	assert.True(t, employee.Nurse.IsValid())
	assert.True(t, employee.NurseAssistant.IsValid())
	assert.False(t, employee.Type("OTHER").IsValid())
}
