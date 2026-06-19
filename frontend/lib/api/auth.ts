import { api } from './client'
import type { AuthUser, LoginResponse } from '@/types/auth'

export const authApi = {
  login: (payload: { username: string; password?: string }) =>
    api.post<LoginResponse>('/auth/login', payload),

  setPassword: (payload: { username: string; password: string }) =>
    api.post<{ user: AuthUser }>('/auth/set-password', payload),

  me: () => api.get<{ user: AuthUser }>('/auth/me'),

  logout: () => api.post<void>('/auth/logout', {}),
}
