import { api } from './client'
import type { Employee, CreateEmployeePayload, UpdateEmployeePayload } from '@/types/employee'

export const employeesApi = {
  list: () => api.get<{ data: Employee[] }>('/employees'),

  getById: (id: string) => api.get<Employee>(`/employees/${id}`),

  create: (payload: CreateEmployeePayload) =>
    api.post<Employee>('/employees', payload),

  update: (id: string, payload: UpdateEmployeePayload) =>
    api.put<Employee>(`/employees/${id}`, payload),

  deactivate: (id: string) => api.delete<void>(`/employees/${id}`),
}
