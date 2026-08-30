package main

import (
	"context"
	"log/slog"
	"os"
	"time"

	_ "github.com/jackc/pgx/v5/stdlib"
	"github.com/joho/godotenv"
	db "github.com/tuusuario/nurse-portal/internal/adapters/database/postgres"
	nursehttp "github.com/tuusuario/nurse-portal/internal/adapters/http"
	repo "github.com/tuusuario/nurse-portal/internal/adapters/repository/postgres"
	"github.com/tuusuario/nurse-portal/internal/application/services"
	"github.com/tuusuario/nurse-portal/internal/server"
)

func main() {
	logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))
	slog.SetDefault(logger)

	err := godotenv.Load(".env")
	if err != nil {
		slog.Error("failed to load .env", "error", err)
	    os.Exit(1)
	}

	dbURL := os.Getenv("DATABASE_URL")
	port := os.Getenv("PORT")

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	pool, err := db.NewConnection(ctx, dbURL)
	if err != nil {
		slog.Error("failed to create new connection to database", "error", err)
	}

	err = db.RunMigrations(ctx, dbURL)
	if err != nil {
		slog.Error("failed to run migrations", "error", err)
		os.Exit(1)
	}
    
	slog.Info("migrations applied successfully")

	authRepo := repo.NewAuthRepository(pool)
	authSvc := services.NewAuthService(authRepo)
	authHandler := nursehttp.NewAuthHandler(authSvc)
	authMiddleware := nursehttp.NewAuthMiddleware(authSvc)

	employeeRepo := repo.NewEmployeeRepository(pool)
	employeeSvc := services.NewEmployeeService(employeeRepo, authSvc)
	employeeHandler := nursehttp.NewEmployeeHandler(employeeSvc)

	planifRepo := repo.NewPlanificacionRepository(pool)
	turnoRepo := repo.NewTurnoRepository(pool)
	dotacionRepo := repo.NewDotacionRepository(pool)
	leaveRepo := repo.NewLeaveRequestRepository(pool)
	compRepo := repo.NewCompensatoryDayRepository(pool)
	planifSvc := services.NewPlanificacionService(planifRepo, turnoRepo, dotacionRepo, dotacionRepo, employeeRepo, leaveRepo, compRepo)
	planifHandler := nursehttp.NewPlanificacionHandler(planifSvc, employeeSvc)

	ausenciaSvc := services.NewAusenciaService(leaveRepo, compRepo)
	ausenciaHandler := nursehttp.NewAusenciaHandler(ausenciaSvc)

	intercambioRepo := repo.NewIntercambioRepository(pool)
	intercambioSvc := services.NewIntercambioService(intercambioRepo, turnoRepo, planifRepo, leaveRepo)
	intercambioHandler := nursehttp.NewIntercambioHandler(intercambioSvc)

	router := nursehttp.NewRouter(authHandler, authMiddleware, employeeHandler, planifHandler, ausenciaHandler, intercambioHandler)

	server.Start(router, port)
}