export type EstadoPlanificacion = 'BORRADOR' | 'PUBLICADO' | 'CERRADO'

export type TipoTurno = 'MANANA' | 'TARDE' | 'VESPERTINO' | 'NOCHE'

export interface Planificacion {
  id: string
  mes: number
  anio: number
  nombre: string
  estado: EstadoPlanificacion
  dias: number
  created_at: string
  updated_at: string
}

export interface Turno {
  id: string
  planificacion_id: string
  empleado_id: string
  dia: number
  tipo: TipoTurno
  sector: string
  created_at: string
  updated_at: string
}

export interface PlanificacionDetail extends Planificacion {
  turnos: Turno[]
}

export interface CreatePlanificacionPayload {
  mes: number
  anio: number
  nombre: string
}

export interface CreateTurnoPayload {
  empleado_id: string
  dia: number
  tipo: TipoTurno
  sector: string
}

export interface DotacionItem {
  tipo_empleado: string
  turno: string
  cantidad_minima: number
  sector: string
}

export interface SectorItem {
  id: string
  nombre: string
}

export interface UpdateSectoresPayload {
  sectores: string[]
}

export interface DotacionUpdateInput {
  sector: string
  tipo_empleado: string
  turno: string
  cantidad_minima: number
}

export interface UpdateDotacionPayload {
  items: DotacionUpdateInput[]
}
