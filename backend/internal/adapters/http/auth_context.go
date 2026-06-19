package http

import (
	"context"

	"github.com/tuusuario/nursery-portal/internal/domain/auth"
)

type authUserContextKey struct{}

func contextWithAuthUser(ctx context.Context, user *auth.User) context.Context {
	return context.WithValue(ctx, authUserContextKey{}, user)
}

func authUserFromContext(ctx context.Context) (*auth.User, bool) {
	user, ok := ctx.Value(authUserContextKey{}).(*auth.User)
	return user, ok && user != nil
}
