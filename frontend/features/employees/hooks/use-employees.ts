'use client'

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { employeesApi } from '@/lib/api/employees'
import type { CreateEmployeePayload, UpdateEmployeePayload } from '@/types/employee'

const EMPLOYEES_KEY = ['employees'] as const

export function useEmployees() {
  return useQuery({
    queryKey: EMPLOYEES_KEY,
    queryFn: () => employeesApi.list(),
  })
}

export function useEmployee(id: string) {
  return useQuery({
    queryKey: [...EMPLOYEES_KEY, id],
    queryFn: () => employeesApi.getById(id),
    enabled: !!id,
  })
}

export function useCreateEmployee() {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: (payload: CreateEmployeePayload) => employeesApi.create(payload),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: EMPLOYEES_KEY })
    },
  })
}

export function useUpdateEmployee(id: string) {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: (payload: UpdateEmployeePayload) => employeesApi.update(id, payload),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: EMPLOYEES_KEY })
    },
  })
}

export function useDeactivateEmployee() {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: (id: string) => employeesApi.deactivate(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: EMPLOYEES_KEY })
    },
  })
}
