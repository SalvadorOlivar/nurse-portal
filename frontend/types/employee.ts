export type EmployeeType = 'NURSE' | 'NURSE_ASSISTANT' | 'SUPERVISOR' | 'AUXILIAR_SERVICIO'

export interface Employee {
  id: string
  nombre: string
  apellido: string
  tipo: EmployeeType
  horas_minimas: number
  horas_maximas: number
  work_days: number
  rest_days: number
  activo: boolean
  created_at: string
  updated_at: string
}

export interface CreateEmployeePayload {
  nombre: string
  apellido: string
  tipo: EmployeeType
  horas_minimas: number
  horas_maximas: number
  work_days?: number
  rest_days?: number
}

export type UpdateEmployeePayload = CreateEmployeePayload
