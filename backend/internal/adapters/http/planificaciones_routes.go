package http

import (
	"github.com/go-chi/chi/v5"
	"github.com/tuusuario/nurse-portal/internal/domain/auth"
)

type PlanificacionRoutes struct {
	handler        *PlanificacionHandler
	authMiddleware *AuthMiddleware
}

func NewPlanificacionRoutes(handler *PlanificacionHandler, authMiddleware *AuthMiddleware) *PlanificacionRoutes {
	return &PlanificacionRoutes{
		handler:        handler,
		authMiddleware: authMiddleware,
	}
}

func (routes *PlanificacionRoutes) RegisterRoutes(r chi.Router){
	r.Route("/planificaciones", func(r chi.Router) {
		r.Use(routes.authMiddleware.RequireAuth)
		r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Post("/", routes.handler.Create)
		r.Get("/", routes.handler.List)
		r.Route("/{id}", func(r chi.Router) {
			r.Get("/", routes.handler.GetByID)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Put("/", routes.handler.Update)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Delete("/", routes.handler.Delete)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Post("/publicar", routes.handler.Publicar)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Post("/cerrar", routes.handler.Cerrar)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Post("/turnos", routes.handler.CreateTurno)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Delete("/turnos/{turnoId}", routes.handler.DeleteTurno)
			r.Get("/requirements", routes.handler.GetStaffingRequirements)
		r.Get("/leaves", routes.handler.GetPlanLeaves)
			r.Get("/sectores", routes.handler.GetSectores)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Put("/sectores", routes.handler.UpdateSectores)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Put("/dotacion", routes.handler.UpdateDotacion)
		})
	})
}