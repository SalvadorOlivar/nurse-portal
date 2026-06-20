export type AuthRole = 'ADMIN' | 'SUPERVISOR' | 'EMPLOYEE'

export interface AuthUser {
  id: string
  username: string
  role: AuthRole
  employee_id?: string
}

export interface LoginResponse {
  requires_password?: boolean
  password_required?: boolean
  must_change_password?: boolean
  username?: string
  user?: AuthUser
}
