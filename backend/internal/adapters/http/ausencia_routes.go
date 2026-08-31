package http

import (
	"github.com/go-chi/chi/v5"
	"github.com/tuusuario/nurse-portal/internal/domain/auth"
)

type AusenciasRoutes struct {
	handler        *AusenciaHandler
	authMiddleware *AuthMiddleware
}

func NewAusenciasRoutes(handler *AusenciaHandler, authMiddleware *AuthMiddleware) *AusenciasRoutes {
	return &AusenciasRoutes{
		handler:        handler,
		authMiddleware: authMiddleware,
	}
}

func (routes *AusenciasRoutes) RegisterRoutes(r chi.Router){
	r.Route("/leave-requests", func(r chi.Router) {
		r.Use(routes.authMiddleware.RequireAuth)
		r.Post("/", routes.handler.CreateLeaveRequest)
		r.Get("/", routes.handler.ListLeaveRequests)
		r.Route("/{id}", func(r chi.Router) {
			r.Get("/", routes.handler.GetLeaveRequest)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Post("/approve", routes.handler.ApproveLeaveRequest)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Post("/reject", routes.handler.RejectLeaveRequest)
		})
	})

	r.Route("/compensatory-days", func(r chi.Router) {
		r.Use(routes.authMiddleware.RequireAuth)
		r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Post("/", routes.handler.CreateCompensatoryDay)
		r.Route("/{id}", func(r chi.Router) {
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Post("/use", routes.handler.UseCompensatoryDay)
		})
	})

	r.Route("/employees/{employeeId}/compensatory-days", func(r chi.Router) {
		r.Use(routes.authMiddleware.RequireAuth)
		r.Get("/", routes.handler.ListCompensatoryDays)
	})
}