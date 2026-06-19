package services

import (
	"context"
	"crypto/rand"
	"crypto/sha256"
	"encoding/base64"
	"encoding/hex"
	"errors"
	"fmt"
	"strings"
	"time"
	"unicode"

	"github.com/tuusuario/nursery-portal/internal/domain/auth"
	"github.com/tuusuario/nursery-portal/internal/domain/employee"
	"github.com/tuusuario/nursery-portal/internal/ports"
	"golang.org/x/crypto/bcrypt"
	"golang.org/x/text/unicode/norm"
)

const SessionTTL = 7 * 24 * time.Hour

var (
	ErrInvalidCredentials = errors.New("invalid credentials")
	ErrPasswordAlreadySet = errors.New("password already set")
)

type AuthService struct {
	repo ports.AuthRepository
}

type AuthResult struct {
	User             *auth.User
	Token            string
	ExpiresAt        time.Time
	RequiresPassword bool
}

func NewAuthService(repo ports.AuthRepository) *AuthService {
	return &AuthService{repo: repo}
}

func (s *AuthService) Login(ctx context.Context, username, password string) (*AuthResult, error) {
	user, err := s.repo.FindUserByUsername(ctx, NormalizeUsername(username))
	if err != nil {
		return nil, ErrInvalidCredentials
	}

	if user.NeedsPassword() {
		return &AuthResult{User: user, RequiresPassword: true}, nil
	}

	if password == "" {
		return &AuthResult{User: user}, nil
	}
	if bcrypt.CompareHashAndPassword([]byte(*user.PasswordHash), []byte(password)) != nil {
		return nil, ErrInvalidCredentials
	}

	token, expiresAt, err := s.createSession(ctx, user.ID)
	if err != nil {
		return nil, err
	}

	return &AuthResult{User: user, Token: token, ExpiresAt: expiresAt}, nil
}

func (s *AuthService) SetPassword(ctx context.Context, username, password string) (*AuthResult, error) {
	user, err := s.repo.FindUserByUsername(ctx, NormalizeUsername(username))
	if err != nil {
		return nil, ErrInvalidCredentials
	}
	if !user.NeedsPassword() {
		return nil, ErrPasswordAlreadySet
	}
	if len(password) < 8 {
		return nil, fmt.Errorf("password must be at least 8 characters")
	}

	hash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return nil, err
	}
	hashText := string(hash)
	if err := s.repo.SetPasswordHash(ctx, user.ID, hashText); err != nil {
		return nil, err
	}
	user.PasswordHash = &hashText

	token, expiresAt, err := s.createSession(ctx, user.ID)
	if err != nil {
		return nil, err
	}

	return &AuthResult{User: user, Token: token, ExpiresAt: expiresAt}, nil
}

func (s *AuthService) GetUserBySessionToken(ctx context.Context, token string) (*auth.User, error) {
	if token == "" {
		return nil, ErrInvalidCredentials
	}
	return s.repo.FindUserBySessionHash(ctx, hashToken(token), time.Now().UTC())
}

func (s *AuthService) Logout(ctx context.Context, token string) error {
	if token == "" {
		return nil
	}
	return s.repo.DeleteSession(ctx, hashToken(token))
}

func (s *AuthService) EnsureAdmin(ctx context.Context, username, password string) error {
	username = NormalizeUsername(username)
	if username == "" || password == "" {
		return nil
	}

	hash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	return s.repo.EnsureAdmin(ctx, username, string(hash))
}

func (s *AuthService) CreateEmployeeAccount(ctx context.Context, emp *employee.Employee) error {
	username := UsernameForEmployee(emp.Nombre, emp.Apellido)
	role := auth.RoleEmployee
	if emp.Tipo == employee.Supervisor {
		role = auth.RoleSupervisor
	}
	return s.repo.CreateEmployeeUser(ctx, username, role, emp.ID)
}

func (s *AuthService) UpdateEmployeeAccount(ctx context.Context, emp *employee.Employee) error {
	username := UsernameForEmployee(emp.Nombre, emp.Apellido)
	role := auth.RoleEmployee
	if emp.Tipo == employee.Supervisor {
		role = auth.RoleSupervisor
	}
	return s.repo.UpdateEmployeeUser(ctx, emp.ID, username, role)
}

func (s *AuthService) createSession(ctx context.Context, userID string) (string, time.Time, error) {
	token, err := randomToken()
	if err != nil {
		return "", time.Time{}, err
	}
	expiresAt := time.Now().UTC().Add(SessionTTL)
	if err := s.repo.CreateSession(ctx, userID, hashToken(token), expiresAt); err != nil {
		return "", time.Time{}, err
	}
	return token, expiresAt, nil
}

func randomToken() (string, error) {
	bytes := make([]byte, 32)
	if _, err := rand.Read(bytes); err != nil {
		return "", err
	}
	return base64.RawURLEncoding.EncodeToString(bytes), nil
}

func hashToken(token string) string {
	sum := sha256.Sum256([]byte(token))
	return hex.EncodeToString(sum[:])
}

func UsernameForEmployee(nombre, apellido string) string {
	return NormalizeUsername(nombre + "." + apellido)
}

func NormalizeUsername(value string) string {
	value = strings.ToLower(strings.TrimSpace(value))
	value = stripDiacritics(value)
	var b strings.Builder
	lastDot := false
	for _, r := range value {
		switch {
		case unicode.IsLetter(r) || unicode.IsDigit(r):
			b.WriteRune(r)
			lastDot = false
		case r == '.' || unicode.IsSpace(r) || r == '-' || r == '_':
			if !lastDot && b.Len() > 0 {
				b.WriteRune('.')
				lastDot = true
			}
		}
	}
	return strings.Trim(b.String(), ".")
}

func stripDiacritics(value string) string {
	decomposed := norm.NFD.String(value)
	var b strings.Builder
	for _, r := range decomposed {
		if unicode.Is(unicode.Mn, r) {
			continue
		}
		b.WriteRune(r)
	}
	return b.String()
}
