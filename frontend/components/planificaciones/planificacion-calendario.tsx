'use client'

import { useMemo, useCallback, useState } from 'react'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import {
  usePlanificacion,
  useGenerarTurnos,
  usePublicarPlanificacion,
  useCerrarPlanificacion,
  useCreateTurno,
  useDeleteTurno,
} from '@/features/planificaciones/hooks/use-planificaciones'
import { useEmployees } from '@/features/employees/hooks/use-employees'

import { PlanillaDiaria } from './planilla-diaria'
import { toast } from 'sonner'
import type { PlanificacionDetail, Turno, TipoTurno } from '@/types/planificacion'

const turnoColors: Record<TipoTurno, string> = {
  MANANA: 'bg-blue-200 hover:bg-blue-300 text-blue-900',
  TARDE: 'bg-yellow-200 hover:bg-yellow-300 text-yellow-900',
  VESPERTINO: 'bg-orange-200 hover:bg-orange-300 text-orange-900',
  NOCHE: 'bg-indigo-300 hover:bg-indigo-400 text-indigo-950',
}

const turnoLabels: Record<TipoTurno, string> = {
  MANANA: 'M',
  TARDE: 'T',
  VESPERTINO: 'V',
  NOCHE: 'N',
}

const turnoFullLabels: Record<TipoTurno, string> = {
  MANANA: 'Mañana',
  TARDE: 'Tarde',
  VESPERTINO: 'Vespertino',
  NOCHE: 'Noche',
}

const nextTipo: Record<string, TipoTurno | null> = {
  MANANA: 'TARDE',
  TARDE: 'VESPERTINO',
  VESPERTINO: 'NOCHE',
  NOCHE: null,
}

const estadoColors: Record<string, 'default' | 'secondary' | 'outline'> = {
  BORRADOR: 'secondary',
  PUBLICADO: 'default',
  CERRADO: 'outline',
}

interface CalendarioProps {
  planificacionId: string
}

function DiasDelMes({ dias }: { dias: number }) {
  return (
    <div className="flex gap-[2px]">
      {Array.from({ length: Math.min(dias, 31) }, (_, i) => (
        <div
          key={i}
          className="w-7 h-7 flex items-center justify-center text-[10px] font-medium text-muted-foreground"
        >
          {i + 1}
        </div>
      ))}
    </div>
  )
}

function TurnoCell({
  dia,
  turno,
  empleadoId,
  planificacionId,
  readonly,
}: {
  dia: number
  turno: Turno | undefined
  empleadoId: string
  planificacionId: string
  readonly: boolean
}) {
  const createTurnoMutation = useCreateTurno()
  const deleteTurnoMutation = useDeleteTurno()

  const handleClick = useCallback(async () => {
    if (readonly) return

    if (turno) {
      const next = nextTipo[turno.tipo]
      if (next === null) {
        await deleteTurnoMutation.mutateAsync({
          planificacionId,
          turnoId: turno.id,
        })
      } else {
        await createTurnoMutation.mutateAsync({
          planificacionId,
          payload: { empleado_id: empleadoId, dia, tipo: next },
        })
      }
    } else {
      await createTurnoMutation.mutateAsync({
        planificacionId,
        payload: { empleado_id: empleadoId, dia, tipo: 'MANANA' },
      })
    }
  }, [dia, turno, empleadoId, planificacionId, readonly, createTurnoMutation, deleteTurnoMutation])

  const isLoading = createTurnoMutation.isPending || deleteTurnoMutation.isPending

  return (
    <button
      type="button"
      onClick={handleClick}
      disabled={isLoading || readonly}
      title={turno ? `${turnoFullLabels[turno.tipo]} - Click para cambiar` : 'Sin turno - Click para asignar'}
      className={`
        w-7 h-7 flex items-center justify-center text-[10px] font-medium rounded-sm border border-transparent
        transition-all text-xs
        ${turno ? turnoColors[turno.tipo] : 'bg-muted/30 hover:bg-muted/60 text-muted-foreground/50'}
        ${readonly ? 'cursor-default' : 'cursor-pointer hover:ring-1 hover:ring-ring'}
        ${isLoading ? 'opacity-50' : ''}
      `}
    >
      {turno ? turnoLabels[turno.tipo] : '-'}
    </button>
  )
}

export function PlanificacionCalendario({ planificacionId }: CalendarioProps) {
  const { data: planifData, isLoading: planifLoading, isError: planifError } = usePlanificacion(planificacionId)
  const { data: empData, isLoading: empLoading } = useEmployees()
  const generarMutation = useGenerarTurnos()
  const publicarMutation = usePublicarPlanificacion()
  const cerrarMutation = useCerrarPlanificacion()

	const [vista, setVista] = useState<'empleado' | 'planilla'>('empleado')

  const turnos = planifData?.turnos
  const turnosAgrupados = useMemo(() => {
    if (!turnos) return {}
    const map: Record<string, Record<number, Turno>> = {}
    for (const t of turnos) {
      if (!map[t.empleado_id]) map[t.empleado_id] = {}
      map[t.empleado_id][t.dia] = t
    }
    return map
  }, [turnos])

  if (planifLoading || empLoading) {
    return <div className="text-center py-8 text-muted-foreground">Cargando planificación...</div>
  }

  if (planifError || !planifData) {
    return <div className="text-center py-8 text-destructive">Error al cargar planificación</div>
  }

  const planificacion: PlanificacionDetail = planifData
  const employees = empData?.data ?? []
  const activeEmployees = employees.filter((e) => e.activo)
  const dias = planificacion.dias
  const readonly = planificacion.estado !== 'BORRADOR'

  async function handleGenerar() {
    try {
      await generarMutation.mutateAsync(planificacionId)
      toast.success('Turnos generados automáticamente')
    } catch {
      toast.error('Error al generar turnos')
    }
  }

  async function handlePublicar() {
    try {
      await publicarMutation.mutateAsync(planificacionId)
      toast.success('Planificación publicada')
    } catch {
      toast.error('Error al publicar planificación')
    }
  }

  async function handleCerrar() {
    try {
      await cerrarMutation.mutateAsync(planificacionId)
      toast.success('Planificación cerrada')
    } catch {
      toast.error('Error al cerrar planificación')
    }
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div className="space-y-1">
          <h2 className="text-xl font-semibold">{planificacion.nombre}</h2>
          <div className="flex items-center gap-2">
            <Badge variant={estadoColors[planificacion.estado] ?? 'secondary'}>
              {planificacion.estado === 'BORRADOR' ? 'Borrador' :
               planificacion.estado === 'PUBLICADO' ? 'Publicado' : 'Cerrado'}
            </Badge>
            <span className="text-sm text-muted-foreground">
              {activeEmployees.length} empleados activos · {dias} días
            </span>
          </div>
        </div>

        <div className="flex gap-2">
          {planificacion.estado === 'BORRADOR' && (
            <>
              <Button
                variant="outline"
                onClick={handleGenerar}
                disabled={generarMutation.isPending}
              >
                {generarMutation.isPending ? 'Generando...' : 'Generar automático'}
              </Button>

              <Button onClick={handlePublicar} disabled={publicarMutation.isPending}>
                Publicar
              </Button>
            </>
          )}
          {planificacion.estado === 'PUBLICADO' && (
            <Button variant="outline" onClick={handleCerrar} disabled={cerrarMutation.isPending}>
              Cerrar planificación
            </Button>
          )}
        </div>
      </div>

		<div className="flex gap-1 border-b">
        <button
          type="button"
          onClick={() => setVista('empleado')}
          className={`px-4 py-2 text-sm font-medium border-b-2 transition-colors ${
            vista === 'empleado'
              ? 'border-primary text-primary'
              : 'border-transparent text-muted-foreground hover:text-foreground'
          }`}
        >
          Vista por empleado
        </button>
        <button
          type="button"
          onClick={() => setVista('planilla')}
          className={`px-4 py-2 text-sm font-medium border-b-2 transition-colors ${
            vista === 'planilla'
              ? 'border-primary text-primary'
              : 'border-transparent text-muted-foreground hover:text-foreground'
          }`}
        >
          Vista planilla
        </button>
      </div>

      {vista === 'empleado' ? (
        <>
          <div className="overflow-x-auto pb-4">
            <div className="inline-block min-w-full">
              <div className="flex flex-col gap-[1px]">
                <div className="flex gap-[2px]">
                  <div className="w-40 shrink-0 px-2 py-1" />
                  <DiasDelMes dias={dias} />
                </div>

                {activeEmployees.map((emp) => {
                  const empleadoTurnos = turnosAgrupados[emp.id] ?? {}
                  return (
                    <div key={emp.id} className="flex gap-[2px] items-center">
                      <div className="w-40 shrink-0 px-2 py-1 text-sm truncate font-medium">
                        {emp.apellido}, {emp.nombre}
                      </div>
                      <div className="flex gap-[2px]">
                        {Array.from({ length: dias }, (_, i) => {
                          const dia = i + 1
                          return (
                            <TurnoCell
                              key={dia}
                              dia={dia}
                              turno={empleadoTurnos[dia]}
                              empleadoId={emp.id}
                              planificacionId={planificacionId}
                              readonly={readonly}
                            />
                          )
                        })}
                      </div>
                    </div>
                  )
                })}
              </div>
            </div>
          </div>

          <div className="flex items-center gap-4 text-sm text-muted-foreground">
            <span className="font-medium">Leyenda:</span>
            {(['MANANA', 'TARDE', 'VESPERTINO', 'NOCHE'] as const).map((tipo) => (
              <div key={tipo} className="flex items-center gap-1">
                <span className={`w-4 h-4 rounded-sm inline-block ${turnoColors[tipo].split(' ')[0]}`} />
                <span>{turnoFullLabels[tipo]}</span>
              </div>
            ))}
            <div className="flex items-center gap-1">
              <span className="w-4 h-4 rounded-sm inline-block bg-muted/30" />
              <span>Descanso</span>
            </div>
            {!readonly && (
              <span className="text-xs ml-auto">Click en cada celda para asignar/cambiar turno</span>
            )}
          </div>
        </>
      ) : (
        <PlanillaDiaria planificacionId={planificacionId} readonly={readonly} />
      )}
    </div>
  )
}
