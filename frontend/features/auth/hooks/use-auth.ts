'use client'

import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { authApi } from '@/lib/api/auth'

export const AUTH_KEY = ['auth', 'me'] as const

export function useMe() {
  return useQuery({
    queryKey: AUTH_KEY,
    queryFn: () => authApi.me(),
    retry: false,
  })
}

export function useLogin() {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: (payload: { username: string; password?: string }) => authApi.login(payload),
    onSuccess: (data) => {
      if (data.user) {
        queryClient.setQueryData(AUTH_KEY, { user: data.user })
      }
    },
  })
}

export function useSetPassword() {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: (payload: { username: string; password: string }) => authApi.setPassword(payload),
    onSuccess: (data) => {
      queryClient.setQueryData(AUTH_KEY, data)
    },
  })
}

export function useLogout() {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: () => authApi.logout(),
    onSettled: () => {
      queryClient.clear()
    },
  })
}
