package postgres

import (
	"context"

	"github.com/pressly/goose/v3"
)

func RunMigrations(ctx context.Context, dbURL string) error {
	db, err := goose.OpenDBWithDriver("postgres", dbURL)
	if err != nil {
		return err
	}
	defer db.Close()

	return goose.UpContext(ctx, db, "migrations")
}
