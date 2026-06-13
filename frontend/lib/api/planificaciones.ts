import { api } from './client'
import type { Planificacion, PlanificacionDetail, CreatePlanificacionPayload, CreateTurnoPayload, Turno, DotacionItem } from '@/types/planificacion'

export const planificacionesApi = {
  list: () => api.get<{ data: Planificacion[] }>('/planificaciones'),

  getById: (id: string) => api.get<PlanificacionDetail>(`/planificaciones/${id}`),

  create: (payload: CreatePlanificacionPayload) =>
    api.post<Planificacion>('/planificaciones', payload),

  update: (id: string, nombre: string) =>
    api.put<void>(`/planificaciones/${id}`, { nombre }),

  delete: (id: string) => api.delete<void>(`/planificaciones/${id}`),

  publicar: (id: string) => api.post<void>(`/planificaciones/${id}/publicar`, {}),

  cerrar: (id: string) => api.post<void>(`/planificaciones/${id}/cerrar`, {}),

  generar: (id: string) => api.post<void>(`/planificaciones/${id}/generar`, {}),

  createTurno: (planificacionId: string, payload: CreateTurnoPayload) =>
    api.post<Turno>(`/planificaciones/${planificacionId}/turnos`, payload),

  deleteTurno: (planificacionId: string, turnoId: string) =>
    api.delete<void>(`/planificaciones/${planificacionId}/turnos/${turnoId}`),

  getDotacion: (id: string) =>
    api.get<{ data: DotacionItem[] }>(`/planificaciones/${id}/requirements`),
}
