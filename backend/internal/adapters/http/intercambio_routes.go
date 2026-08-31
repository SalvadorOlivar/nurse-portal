package http

import (
	"github.com/go-chi/chi/v5"
	"github.com/tuusuario/nurse-portal/internal/domain/auth"
)

type IntercambioRoutes struct {
	handler        *IntercambioHandler
	authMiddleware *AuthMiddleware
}

func NewIntercambioRoutes(handler *IntercambioHandler, authMiddleware *AuthMiddleware) *IntercambioRoutes {
	return &IntercambioRoutes{
		handler:        handler,
		authMiddleware: authMiddleware,
	}
}

func (routes *IntercambioRoutes ) RegisterRoutes(r chi.Router){
	r.Route("/swap-requests", func(r chi.Router) {
		r.Use(routes.authMiddleware.RequireAuth)
		r.Post("/", routes.handler.CreateSwapRequest)
		r.Get("/", routes.handler.ListSwapRequests)
		r.Route("/{id}", func(r chi.Router) {
			r.Get("/", routes.handler.GetSwapRequest)
			r.Post("/accept", routes.handler.AcceptSwapRequest)
			r.Post("/reject", routes.handler.RejectSwapRequest)
			r.With(routes.authMiddleware.RequireRoles(auth.RoleAdmin, auth.RoleSupervisor)).Post("/approve", routes.handler.ApproveSwapRequest)
			r.Post("/cancel", routes.handler.CancelSwapRequest)
			r.Get("/history", routes.handler.GetSwapHistory)
		})
	})
}