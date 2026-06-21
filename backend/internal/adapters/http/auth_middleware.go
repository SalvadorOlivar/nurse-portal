package http

import (
	"net/http"

	"github.com/tuusuario/nurse-portal/internal/application/services"
	"github.com/tuusuario/nurse-portal/internal/domain/auth"
)

type AuthMiddleware struct {
	svc *services.AuthService
}

func NewAuthMiddleware(svc *services.AuthService) *AuthMiddleware {
	return &AuthMiddleware{svc: svc}
}

func (m *AuthMiddleware) RequireAuth(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		cookie, err := r.Cookie(sessionCookieName)
		if err != nil {
			writeError(w, http.StatusUnauthorized, "unauthorized")
			return
		}

		user, err := m.svc.GetUserBySessionToken(r.Context(), cookie.Value)
		if err != nil {
			clearSessionCookie(w)
			writeError(w, http.StatusUnauthorized, "unauthorized")
			return
		}

		next.ServeHTTP(w, r.WithContext(contextWithAuthUser(r.Context(), user)))
	})
}

func (m *AuthMiddleware) RequireRoles(roles ...auth.Role) func(http.Handler) http.Handler {
	allowed := make(map[auth.Role]bool, len(roles))
	for _, role := range roles {
		allowed[role] = true
	}

	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			user, ok := authUserFromContext(r.Context())
			if !ok {
				writeError(w, http.StatusUnauthorized, "unauthorized")
				return
			}
			if !allowed[user.Role] {
				writeError(w, http.StatusForbidden, "forbidden")
				return
			}
			next.ServeHTTP(w, r)
		})
	}
}
