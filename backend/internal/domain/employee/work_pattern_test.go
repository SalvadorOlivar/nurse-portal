package employee_test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/tuusuario/nursery-portal/internal/domain/employee"
)

func TestNewWorkPattern_Success(t *testing.T) {
	wp, err := employee.NewWorkPattern(4, 1)
	assert.NoError(t, err)
	assert.Equal(t, 4, wp.WorkDays)
	assert.Equal(t, 1, wp.RestDays)
}

func TestNewWorkPattern_Validation(t *testing.T) {
	_, err := employee.NewWorkPattern(0, 1)
	assert.EqualError(t, err, "work days must be at least 1")

	_, err = employee.NewWorkPattern(4, 0)
	assert.EqualError(t, err, "rest days must be at least 1")
}

func TestDefaultWorkPattern(t *testing.T) {
	wp := employee.DefaultWorkPattern()
	assert.Equal(t, 4, wp.WorkDays)
	assert.Equal(t, 1, wp.RestDays)
}
