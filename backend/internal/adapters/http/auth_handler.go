package http

import (
	"encoding/json"
	"errors"
	"log/slog"
	"net/http"
	"time"

	"github.com/tuusuario/nurse-portal/internal/application/services"
	"github.com/tuusuario/nurse-portal/internal/domain/auth"
)

const sessionCookieName = "nurse_session"

type AuthHandler struct {
	svc *services.AuthService
}

func NewAuthHandler(svc *services.AuthService) *AuthHandler {
	return &AuthHandler{svc: svc}
}

func (h *AuthHandler) Login(w http.ResponseWriter, r *http.Request) {
	var req struct {
		Username string `json:"username"`
		Password string `json:"password"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		writeError(w, http.StatusBadRequest, "invalid request body")
		return
	}

	slog.Debug("login attempt", "username", req.Username, "has_password", req.Password != "")

	result, err := h.svc.Login(r.Context(), req.Username, req.Password)
	if err != nil {
		slog.Warn("login failed", "username", req.Username, "error", err)
		writeError(w, http.StatusUnauthorized, "usuario o contrasena invalidos")
		return
	}

	if result.RequiresPassword {
		slog.Info("login requires password setup", "username", result.User.Username)
		writeJSON(w, http.StatusOK, map[string]any{
			"requires_password": true,
			"username":          result.User.Username,
		})
		return
	}

	if result.MustChangePassword {
		slog.Info("login requires password change", "username", result.User.Username)
		writeJSON(w, http.StatusOK, map[string]any{
			"must_change_password": true,
			"username":             result.User.Username,
		})
		return
	}

	if result.Token == "" {
		slog.Warn("login no token returned", "username", result.User.Username, "has_password", req.Password != "")
		writeJSON(w, http.StatusOK, map[string]any{
			"requires_password": false,
			"password_required": true,
			"username":          result.User.Username,
		})
		return
	}

	slog.Info("login successful", "username", result.User.Username, "role", result.User.Role)
	setSessionCookie(w, result.Token, result.ExpiresAt)
	writeJSON(w, http.StatusOK, map[string]any{
		"requires_password": false,
		"user":              toAuthUserResponse(result.User),
	})
}

func (h *AuthHandler) SetPassword(w http.ResponseWriter, r *http.Request) {
	var req struct {
		Username string `json:"username"`
		Password string `json:"password"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		writeError(w, http.StatusBadRequest, "invalid request body")
		return
	}

	result, err := h.svc.SetPassword(r.Context(), req.Username, req.Password)
	if err != nil {
		status := http.StatusBadRequest
		if errors.Is(err, services.ErrInvalidCredentials) {
			status = http.StatusUnauthorized
		}
		writeError(w, status, err.Error())
		return
	}

	setSessionCookie(w, result.Token, result.ExpiresAt)
	writeJSON(w, http.StatusOK, map[string]any{
		"user": toAuthUserResponse(result.User),
	})
}

func (h *AuthHandler) Me(w http.ResponseWriter, r *http.Request) {
	user, ok := authUserFromContext(r.Context())
	if !ok {
		writeError(w, http.StatusUnauthorized, "unauthorized")
		return
	}
	writeJSON(w, http.StatusOK, map[string]any{"user": toAuthUserResponse(user)})
}

func (h *AuthHandler) Logout(w http.ResponseWriter, r *http.Request) {
	cookie, err := r.Cookie(sessionCookieName)
	if err == nil {
		_ = h.svc.Logout(r.Context(), cookie.Value)
	}
	clearSessionCookie(w)
	w.WriteHeader(http.StatusNoContent)
}

type authUserResponse struct {
	ID         string  `json:"id"`
	Username   string  `json:"username"`
	Role       string  `json:"role"`
	EmployeeID *string `json:"employee_id,omitempty"`
}

func toAuthUserResponse(user *auth.User) authUserResponse {
	return authUserResponse{
		ID:         user.ID,
		Username:   user.Username,
		Role:       string(user.Role),
		EmployeeID: user.EmployeeID,
	}
}

func setSessionCookie(w http.ResponseWriter, token string, expiresAt time.Time) {
	http.SetCookie(w, &http.Cookie{
		Name:     sessionCookieName,
		Value:    token,
		Path:     "/",
		Expires:  expiresAt,
		MaxAge:   int(time.Until(expiresAt).Seconds()),
		HttpOnly: true,
		SameSite: http.SameSiteLaxMode,
	})
}

func clearSessionCookie(w http.ResponseWriter) {
	http.SetCookie(w, &http.Cookie{
		Name:     sessionCookieName,
		Value:    "",
		Path:     "/",
		MaxAge:   -1,
		HttpOnly: true,
		SameSite: http.SameSiteLaxMode,
	})
}
