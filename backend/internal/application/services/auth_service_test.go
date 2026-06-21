package services

import (
	"context"
	"errors"
	"testing"
	"time"

	"github.com/stretchr/testify/require"
	"github.com/tuusuario/nurse-portal/internal/domain/auth"
	"golang.org/x/crypto/bcrypt"
)

type fakeAuthRepo struct {
	users      map[string]*auth.User
	sessions   map[string]string
	setPassErr error
}

func newFakeAuthRepo() *fakeAuthRepo {
	return &fakeAuthRepo{
		users:    map[string]*auth.User{},
		sessions: map[string]string{},
	}
}

func (r *fakeAuthRepo) FindUserByUsername(_ context.Context, username string) (*auth.User, error) {
	user, ok := r.users[username]
	if !ok {
		return nil, errors.New("not found")
	}
	return user, nil
}

func (r *fakeAuthRepo) FindUserBySessionHash(_ context.Context, tokenHash string, _ time.Time) (*auth.User, error) {
	userID, ok := r.sessions[tokenHash]
	if !ok {
		return nil, errors.New("not found")
	}
	for _, user := range r.users {
		if user.ID == userID {
			return user, nil
		}
	}
	return nil, errors.New("not found")
}

func (r *fakeAuthRepo) SetPasswordHash(_ context.Context, userID, passwordHash string) error {
	if r.setPassErr != nil {
		return r.setPassErr
	}
	for _, user := range r.users {
		if user.ID == userID {
			if user.PasswordHash != nil && !user.MustChangePassword {
				return errors.New("password already set")
			}
			user.PasswordHash = &passwordHash
			user.MustChangePassword = false
			return nil
		}
	}
	return errors.New("not found")
}

func (r *fakeAuthRepo) CreateSession(_ context.Context, userID, tokenHash string, _ time.Time) error {
	r.sessions[tokenHash] = userID
	return nil
}

func (r *fakeAuthRepo) DeleteSession(_ context.Context, tokenHash string) error {
	delete(r.sessions, tokenHash)
	return nil
}

func (r *fakeAuthRepo) EnsureAdmin(_ context.Context, username, passwordHash string) error {
	r.users[username] = &auth.User{ID: "admin-id", Username: username, PasswordHash: &passwordHash, Role: auth.RoleAdmin}
	return nil
}

func (r *fakeAuthRepo) CreateEmployeeUser(_ context.Context, username string, role auth.Role, employeeID string, passwordHash string) error {
	r.users[username] = &auth.User{ID: "employee-user-id", Username: username, Role: role, EmployeeID: &employeeID, PasswordHash: &passwordHash, MustChangePassword: true}
	return nil
}

func (r *fakeAuthRepo) UpdateEmployeeUser(_ context.Context, employeeID, username string, role auth.Role) error {
	for _, user := range r.users {
		if user.EmployeeID != nil && *user.EmployeeID == employeeID {
			delete(r.users, user.Username)
			user.Username = username
			user.Role = role
			r.users[username] = user
			return nil
		}
	}
	emptyHash := ""
	return r.CreateEmployeeUser(context.Background(), username, role, employeeID, emptyHash)
}

func TestLoginRequiresPasswordForFirstAccessEmployee(t *testing.T) {
	repo := newFakeAuthRepo()
	repo.users["ana.perez"] = &auth.User{ID: "u1", Username: "ana.perez", Role: auth.RoleEmployee}
	svc := NewAuthService(repo)

	result, err := svc.Login(context.Background(), "Ana.Perez", "")

	require.NoError(t, err)
	require.True(t, result.RequiresPassword)
	require.Empty(t, result.Token)
}

func TestSetPasswordCreatesSession(t *testing.T) {
	repo := newFakeAuthRepo()
	repo.users["ana.perez"] = &auth.User{ID: "u1", Username: "ana.perez", Role: auth.RoleEmployee}
	svc := NewAuthService(repo)

	result, err := svc.SetPassword(context.Background(), "ana.perez", "password123")

	require.NoError(t, err)
	require.NotEmpty(t, result.Token)
	require.False(t, result.User.NeedsPassword())
	require.Len(t, repo.sessions, 1)
}

func TestSetPasswordRejectsExistingPassword(t *testing.T) {
	hash, err := bcrypt.GenerateFromPassword([]byte("password123"), bcrypt.DefaultCost)
	require.NoError(t, err)
	hashText := string(hash)
	repo := newFakeAuthRepo()
	repo.users["ana.perez"] = &auth.User{ID: "u1", Username: "ana.perez", PasswordHash: &hashText, Role: auth.RoleEmployee}
	svc := NewAuthService(repo)

	_, err = svc.SetPassword(context.Background(), "ana.perez", "newpassword123")

	require.ErrorIs(t, err, ErrPasswordAlreadySet)
}

func TestLoginReturnsMustChangePassword(t *testing.T) {
	hash, err := bcrypt.GenerateFromPassword([]byte("initial123"), bcrypt.DefaultCost)
	require.NoError(t, err)
	hashText := string(hash)
	repo := newFakeAuthRepo()
	repo.users["juan.perez"] = &auth.User{ID: "u1", Username: "juan.perez", PasswordHash: &hashText, Role: auth.RoleEmployee, MustChangePassword: true}
	svc := NewAuthService(repo)

	result, err := svc.Login(context.Background(), "juan.perez", "")

	require.NoError(t, err)
	require.True(t, result.MustChangePassword)
	require.Empty(t, result.Token)
}

func TestSetPasswordWhenMustChangePassword(t *testing.T) {
	hash, err := bcrypt.GenerateFromPassword([]byte("initial123"), bcrypt.DefaultCost)
	require.NoError(t, err)
	hashText := string(hash)
	repo := newFakeAuthRepo()
	repo.users["juan.perez"] = &auth.User{ID: "u1", Username: "juan.perez", PasswordHash: &hashText, Role: auth.RoleEmployee, MustChangePassword: true}
	svc := NewAuthService(repo)

	result, err := svc.SetPassword(context.Background(), "juan.perez", "newpassword123")

	require.NoError(t, err)
	require.NotEmpty(t, result.Token)
	require.False(t, result.User.MustChangePassword)
	require.False(t, result.User.NeedsPassword())
	require.Len(t, repo.sessions, 1)
}

func TestLoginWithPasswordCreatesSession(t *testing.T) {
	hash, err := bcrypt.GenerateFromPassword([]byte("password123"), bcrypt.DefaultCost)
	require.NoError(t, err)
	hashText := string(hash)
	repo := newFakeAuthRepo()
	repo.users["admin"] = &auth.User{ID: "u1", Username: "admin", PasswordHash: &hashText, Role: auth.RoleAdmin}
	svc := NewAuthService(repo)

	result, err := svc.Login(context.Background(), "admin", "password123")

	require.NoError(t, err)
	require.NotEmpty(t, result.Token)
	require.Len(t, repo.sessions, 1)
}

func TestNormalizeUsername(t *testing.T) {
	require.Equal(t, "jose.nunez", UsernameForEmployee(" Jose ", " Nunez "))
	require.Equal(t, "maria.garcia", UsernameForEmployee("Maria", "Garcia"))
}
