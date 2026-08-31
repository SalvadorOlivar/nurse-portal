package http

import "github.com/go-chi/chi/v5"

type AuthRoutes struct {
	handler        *AuthHandler
	authMiddleware *AuthMiddleware
}

func NewAuthRoutes(handler *AuthHandler, authMiddleware *AuthMiddleware) *AuthRoutes {
	return &AuthRoutes{
		handler:        handler,
		authMiddleware: authMiddleware,
	}
}

func (routes *AuthRoutes) RegisterRoutes(r chi.Router){
	r.Route("/auth", func(r chi.Router) {
		r.Post("/login", routes.handler.Login)
		r.Post("/set-password", routes.handler.SetPassword)
		r.Group(func(r chi.Router) {
			r.Use(routes.authMiddleware.RequireAuth)
			r.Get("/me", routes.handler.Me)
			r.Post("/logout", routes.handler.Logout)
		})
	})
}