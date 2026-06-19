package http

import (
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/cors"
)

func NewRouter(employeeHandler *EmployeeHandler, planificacionHandler *PlanificacionHandler) *chi.Mux {
	r := chi.NewRouter()

	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)
	r.Use(middleware.RequestID)
	r.Use(cors.Handler(cors.Options{
		AllowedOrigins:   []string{"http://localhost:3000"},
		AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type"},
		AllowCredentials: true,
		MaxAge:           300,
	}))

	r.Route("/api/v1", func(r chi.Router) {
		r.Route("/employees", func(r chi.Router) {
			r.Post("/", employeeHandler.Create)
			r.Get("/", employeeHandler.List)
			r.Route("/{id}", func(r chi.Router) {
				r.Get("/", employeeHandler.GetByID)
				r.Put("/", employeeHandler.Update)
				r.Delete("/", employeeHandler.Deactivate)
			})
		})

		r.Route("/planificaciones", func(r chi.Router) {
			r.Post("/", planificacionHandler.Create)
			r.Get("/", planificacionHandler.List)
			r.Route("/{id}", func(r chi.Router) {
				r.Get("/", planificacionHandler.GetByID)
				r.Put("/", planificacionHandler.Update)
				r.Delete("/", planificacionHandler.Delete)
				r.Post("/publicar", planificacionHandler.Publicar)
				r.Post("/cerrar", planificacionHandler.Cerrar)
				r.Post("/turnos", planificacionHandler.CreateTurno)
				r.Delete("/turnos/{turnoId}", planificacionHandler.DeleteTurno)
				r.Get("/requirements", planificacionHandler.GetStaffingRequirements)
				r.Get("/sectores", planificacionHandler.GetSectores)
				r.Put("/sectores", planificacionHandler.UpdateSectores)
				r.Put("/dotacion", planificacionHandler.UpdateDotacion)
			})
		})
	})

	return r
}
