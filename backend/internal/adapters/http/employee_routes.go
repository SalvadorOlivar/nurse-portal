package http

import (
	"github.com/go-chi/chi/v5"
	"github.com/tuusuario/nurse-portal/internal/domain/auth"
)

type EmployeeRoutes struct {
	handler        *EmployeeHandler
	authMiddleware *AuthMiddleware
}

func NewEmployeeRoutes(handler *EmployeeHandler, authMiddleware *AuthMiddleware) *EmployeeRoutes {
	return &EmployeeRoutes{
		handler:        handler,
		authMiddleware: authMiddleware,
	}
}

func (routes *EmployeeRoutes) RegisterRoutes(r chi.Router) {
	r.Route("/employees", func(r chi.Router) {
		r.Use(routes.authMiddleware.RequireAuth)

		r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin)).Post("/", routes.handler.Create)
		r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor, auth.RoleEmployee)).Get("/", routes.handler.List)

		r.Route("/{id}", func(r chi.Router){
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor, auth.RoleEmployee)).Get("/", routes.handler.GetByID)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin)).Put("/", routes.handler.Update)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin)).Delete("/", routes.handler.Deactivate)
		})

	})
}