package auth

import "time"

type Role string

const (
	RoleAdmin      Role = "ADMIN"
	RoleSupervisor Role = "SUPERVISOR"
	RoleEmployee   Role = "EMPLOYEE"
)

func (r Role) IsValid() bool {
	switch r {
	case RoleAdmin, RoleSupervisor, RoleEmployee:
		return true
	default:
		return false
	}
}

type User struct {
	ID                 string
	Username           string
	PasswordHash       *string
	Role               Role
	EmployeeID         *string
	MustChangePassword bool
	CreatedAt          time.Time
	UpdatedAt          time.Time
}

func (u *User) NeedsPassword() bool {
	return u.PasswordHash == nil || *u.PasswordHash == ""
}
