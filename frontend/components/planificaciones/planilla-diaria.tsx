'use client'

import { useMemo, useState, useCallback } from 'react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { usePlanificacion, useStaffingRequirements, useCreateTurno, useDeleteTurno } from '@/features/planificaciones/hooks/use-planificaciones'
import { useEmployees } from '@/features/employees/hooks/use-employees'
import type { Turno, TipoTurno } from '@/types/planificacion'
import type { Employee } from '@/types/employee'

const tipoLabels: Record<string, string> = {
  SUPERVISOR: 'Supervisor/a',
  NURSE: 'Licenciada/o en Enfermería',
  NURSE_ASSISTANT: 'Enfermera/o',
  AUXILIAR_SERVICIO: 'Auxiliar de Servicio',
}

const turnoLabels: Record<string, string> = {
  MANANA: 'Mañana',
  TARDE: 'Tarde',
  VESPERTINO: 'Vespertino',
  NOCHE: 'Noche',
}

const turnoColors: Record<string, string> = {
  MANANA: 'bg-blue-50 border-blue-200',
  TARDE: 'bg-yellow-50 border-yellow-200',
  VESPERTINO: 'bg-orange-50 border-orange-200',
  NOCHE: 'bg-indigo-50 border-indigo-200',
}

const turnoBadgeColors: Record<string, string> = {
  MANANA: 'bg-blue-200 text-blue-900',
  TARDE: 'bg-yellow-200 text-yellow-900',
  VESPERTINO: 'bg-orange-200 text-orange-900',
  NOCHE: 'bg-indigo-300 text-indigo-950',
}

const tipoOrden = ['SUPERVISOR', 'NURSE', 'NURSE_ASSISTANT', 'AUXILIAR_SERVICIO']
const turnosOrden: TipoTurno[] = ['MANANA', 'TARDE', 'VESPERTINO', 'NOCHE']

const nextTipo: Record<string, TipoTurno | null> = {
  MANANA: 'TARDE',
  TARDE: 'VESPERTINO',
  VESPERTINO: 'NOCHE',
  NOCHE: null,
}

interface PlanillaDiariaProps {
  planificacionId: string
  readonly: boolean
}

export function PlanillaDiaria({ planificacionId, readonly }: PlanillaDiariaProps) {
  const { data: planifData } = usePlanificacion(planificacionId)
  const { data: empData } = useEmployees()
  const { data: reqData } = useStaffingRequirements(planificacionId)
  const createTurnoMutation = useCreateTurno()
  const deleteTurnoMutation = useDeleteTurno()

  const [dia, setDia] = useState(1)

  const employees = empData?.data ?? []
  const activeEmployees = employees.filter((e) => e.activo)
  const turnos = planifData?.turnos ?? []
  const requirements = reqData?.data ?? []

  const turnosDelDia = useMemo(() => {
    return turnos.filter((t) => t.dia === dia)
  }, [turnos, dia])

  const employeesByTipo = useMemo(() => {
    const map: Record<string, Employee[]> = {}
    for (const tipo of tipoOrden) {
      map[tipo] = []
    }
    for (const emp of activeEmployees) {
      if (map[emp.tipo]) {
        map[emp.tipo].push(emp)
      }
    }
    return map
  }, [activeEmployees])

  const employeesByTipoSector = useMemo(() => {
    const map: Record<string, Record<string, Employee[]>> = {}
    for (const tipo of tipoOrden) {
      map[tipo] = {}
    }
    for (const emp of activeEmployees) {
      if (!map[emp.tipo]) continue
      const sec = emp.sector || ''
      if (!map[emp.tipo][sec]) map[emp.tipo][sec] = []
      map[emp.tipo][sec].push(emp)
    }
    return map
  }, [activeEmployees])

  const turnosPorTipoYTurno = useMemo(() => {
    const map: Record<string, Record<string, Turno[]>> = {}
    for (const tipo of tipoOrden) {
      map[tipo] = {}
      for (const turno of turnosOrden) {
        map[tipo][turno] = []
      }
    }
    for (const t of turnosDelDia) {
      const emp = activeEmployees.find((e) => e.id === t.empleado_id)
      if (emp && map[emp.tipo]) {
        map[emp.tipo][t.tipo].push(t)
      }
    }
    return map
  }, [turnosDelDia, activeEmployees])

  const turnosPorTipoSectorYTurno = useMemo(() => {
    const map: Record<string, Record<string, Record<string, Turno[]>>> = {}
    for (const t of turnosDelDia) {
      const emp = activeEmployees.find((e) => e.id === t.empleado_id)
      if (!emp || !tipoOrden.includes(emp.tipo)) continue
      const sec = emp.sector || ''
      if (!map[emp.tipo]) map[emp.tipo] = {}
      if (!map[emp.tipo][sec]) {
        map[emp.tipo][sec] = {}
        for (const turno of turnosOrden) {
          map[emp.tipo][sec][turno] = []
        }
      }
      map[emp.tipo][sec][t.tipo].push(t)
    }
    return map
  }, [turnosDelDia, activeEmployees])

  const requerimientos = useMemo(() => {
    const map: Record<string, Record<string, Record<string, number>>> = {}
    for (const req of requirements) {
      if (!map[req.tipo_empleado]) map[req.tipo_empleado] = {}
      const sec = req.sector || ''
      if (!map[req.tipo_empleado][sec]) {
        map[req.tipo_empleado][sec] = {}
        for (const turno of turnosOrden) {
          map[req.tipo_empleado][sec][turno] = 0
        }
      }
      map[req.tipo_empleado][sec][req.turno] = (map[req.tipo_empleado][sec][req.turno] || 0) + req.cantidad_minima
    }
    return map
  }, [requirements])

  const sectoresPorTipo = useMemo(() => {
    const map: Record<string, string[]> = {}
    for (const [tipo, sectores] of Object.entries(requerimientos)) {
      map[tipo] = Object.keys(sectores).filter(s => s !== '')
    }
    return map
  }, [requerimientos])

  const allSectores = useMemo(() => {
    const set = new Set<string>()
    for (const sectores of Object.values(sectoresPorTipo)) {
      for (const s of sectores) set.add(s)
    }
    return [...set]
  }, [sectoresPorTipo])

  const tiposPorSector = ['NURSE', 'NURSE_ASSISTANT']

  const planif = planifData
  const dias = planif?.dias ?? 30

  const handleEmployeeClick = useCallback(async (empleadoId: string, turnoActual: Turno | undefined) => {
    if (readonly) return

    if (turnoActual) {
      const next = nextTipo[turnoActual.tipo]
      if (next === null) {
        await deleteTurnoMutation.mutateAsync({
          planificacionId,
          turnoId: turnoActual.id,
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
  }, [dia, planificacionId, readonly, createTurnoMutation, deleteTurnoMutation])

  const isLoading = createTurnoMutation.isPending || deleteTurnoMutation.isPending

  return (
    <div className="space-y-4">
      <div className="flex items-center gap-3">
        <span className="text-sm font-medium">Día:</span>
        <div className="flex items-center gap-1">
          <Button
            variant="outline"
            size="sm"
            onClick={() => setDia((d) => Math.max(1, d - 1))}
            disabled={dia <= 1}
          >
            &larr;
          </Button>
          <Input
            type="number"
            min={1}
            max={dias}
            value={dia}
            onChange={(e) => {
              const v = Number(e.target.value)
              if (v >= 1 && v <= dias) setDia(v)
            }}
            className="w-16 h-8 text-center"
          />
          <Button
            variant="outline"
            size="sm"
            onClick={() => setDia((d) => Math.min(dias, d + 1))}
            disabled={dia >= dias}
          >
            &rarr;
          </Button>
        </div>
        <span className="text-xs text-muted-foreground">de {dias} días</span>
      </div>

      <div className="overflow-x-auto pb-4">
        <table className="w-full text-sm border-collapse">
          <thead>
            <tr>
              <th className="text-left px-3 py-2 font-medium text-muted-foreground border-b w-48">
                Cargo
              </th>
              {turnosOrden.map((turno) => (
                <th
                  key={turno}
                  className={`px-3 py-2 font-medium text-center border-b ${turnoColors[turno]}`}
                >
                  {turnoLabels[turno]}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {(() => {
              const supervisorTipo = 'SUPERVISOR'
              const supervisorTurnos = turnosPorTipoYTurno[supervisorTipo] ?? {}
              const supervisorReq = requerimientos?.[supervisorTipo]?.[''] ?? {}

              return (
                <tr key={supervisorTipo}>
                  <td className="px-3 py-2 font-medium border-b align-top">
                    {tipoLabels[supervisorTipo] ?? supervisorTipo}
                    <div className="text-[10px] text-muted-foreground font-normal">
                      {(employeesByTipo[supervisorTipo] ?? []).length} empleados
                    </div>
                  </td>
                  {turnosOrden.map((turno) => {
                    const emps = supervisorTurnos[turno] ?? []
                    const reqCount = supervisorReq[turno] ?? 0
                    const cumple = reqCount === 0 || emps.length >= reqCount
                    const falta = reqCount > 0 ? Math.max(0, reqCount - emps.length) : 0

                    return (
                      <td
                        key={turno}
                        className={`px-3 py-2 border-b align-top ${turnoColors[turno]} ${
                          !cumple && reqCount > 0 ? 'bg-red-100 border-red-300' : ''
                        }`}
                      >
                        <div className="flex flex-col gap-1 min-h-[60px]">
                          {emps.map((t) => {
                            const emp = activeEmployees.find((e) => e.id === t.empleado_id)
                            return (
                              <button
                                key={t.id}
                                type="button"
                                disabled={isLoading || readonly}
                                onClick={() => handleEmployeeClick(t.empleado_id, t)}
                                title={
                                  readonly
                                    ? `${emp?.apellido}, ${emp?.nombre}`
                                    : `${emp?.apellido}, ${emp?.nombre} - Click para cambiar`
                                }
                                className={`text-[11px] px-1.5 py-0.5 rounded ${
                                  turnoBadgeColors[t.tipo]
                                } ${
                                  readonly ? 'cursor-default' : 'cursor-pointer hover:opacity-80'
                                } transition-opacity text-left truncate max-w-[130px]`}
                              >
                                {emp?.apellido}, {emp?.nombre}
                              </button>
                            )
                          })}
                          {!readonly && falta > 0 && (
                            <span className="text-[10px] text-red-600 font-medium">
                              faltan {falta}
                            </span>
                          )}
                          {reqCount > 0 && (
                            <span className={`text-[10px] mt-auto ${
                              cumple ? 'text-green-600' : 'text-red-600'
                            }`}>
                              {emps.length}/{reqCount}
                            </span>
                          )}
                        </div>
                      </td>
                    )
                  })}
                </tr>
              )
            })()}
            {allSectores.map((sec) => (
              <>
                <tr key={`sec-${sec}`}>
                  <td className="px-3 py-2 font-medium border-b border-t-2 bg-muted/20" colSpan={5}>
                    Sector {sec}
                  </td>
                </tr>
                {tiposPorSector.map((tipo) => {
                  const empsSector = employeesByTipoSector[tipo]?.[sec] ?? []
                  const sectorReq = requerimientos?.[tipo]?.[sec] ?? {}
                  const sectorTurnos = turnosPorTipoSectorYTurno[tipo]?.[sec] ?? {}

                  return (
                    <tr key={`${sec}-${tipo}`}>
                      <td className="px-3 py-2 text-sm border-b align-top pl-6">
                        {tipoLabels[tipo] ?? tipo}
                        <div className="text-[10px] text-muted-foreground font-normal">
                          {empsSector.length} empleados
                        </div>
                      </td>
                      {turnosOrden.map((turno) => {
                        const empsTurno = sectorTurnos[turno] ?? []
                        const reqCount = sectorReq[turno] ?? 0
                        const cumple = reqCount === 0 || empsTurno.length >= reqCount
                        const falta = reqCount > 0 ? Math.max(0, reqCount - empsTurno.length) : 0

                        return (
                          <td
                            key={turno}
                            className={`px-3 py-2 border-b align-top ${turnoColors[turno]} ${
                              !cumple && reqCount > 0 ? 'bg-red-100 border-red-300' : ''
                            }`}
                          >
                            <div className="flex flex-col gap-1 min-h-[40px]">
                              {empsTurno.map((t) => {
                                const emp = activeEmployees.find((e) => e.id === t.empleado_id)
                                return (
                                  <button
                                    key={t.id}
                                    type="button"
                                    disabled={isLoading || readonly}
                                    onClick={() => handleEmployeeClick(t.empleado_id, t)}
                                    title={
                                      readonly
                                        ? `${emp?.apellido}, ${emp?.nombre}`
                                        : `${emp?.apellido}, ${emp?.nombre} - Click para cambiar`
                                    }
                                    className={`text-[11px] px-1.5 py-0.5 rounded ${
                                      turnoBadgeColors[t.tipo]
                                    } ${
                                      readonly ? 'cursor-default' : 'cursor-pointer hover:opacity-80'
                                    } transition-opacity text-left truncate max-w-[130px]`}
                                  >
                                    {emp?.apellido}, {emp?.nombre}
                                  </button>
                                )
                              })}
                              {!readonly && falta > 0 && (
                                <span className="text-[10px] text-red-600 font-medium">
                                  faltan {falta}
                                </span>
                              )}
                              {reqCount > 0 && (
                                <span className={`text-[10px] mt-auto ${
                                  cumple ? 'text-green-600' : 'text-red-600'
                                }`}>
                                  {empsTurno.length}/{reqCount}
                                </span>
                              )}
                            </div>
                          </td>
                        )
                      })}
                    </tr>
                  )
                })}
              </>
            ))}
            {(() => {
              const auxTipo = 'AUXILIAR_SERVICIO'
              const auxTurnos = turnosPorTipoYTurno[auxTipo] ?? {}
              const auxReq = requerimientos?.[auxTipo]?.[''] ?? {}

              return (
                <tr key={auxTipo}>
                  <td className="px-3 py-2 font-medium border-b align-top">
                    {tipoLabels[auxTipo] ?? auxTipo}
                    <div className="text-[10px] text-muted-foreground font-normal">
                      {(employeesByTipo[auxTipo] ?? []).length} empleados
                    </div>
                  </td>
                  {turnosOrden.map((turno) => {
                    const emps = auxTurnos[turno] ?? []
                    const reqCount = auxReq[turno] ?? 0
                    const cumple = reqCount === 0 || emps.length >= reqCount
                    const falta = reqCount > 0 ? Math.max(0, reqCount - emps.length) : 0

                    return (
                      <td
                        key={turno}
                        className={`px-3 py-2 border-b align-top ${turnoColors[turno]} ${
                          !cumple && reqCount > 0 ? 'bg-red-100 border-red-300' : ''
                        }`}
                      >
                        <div className="flex flex-col gap-1 min-h-[60px]">
                          {emps.map((t) => {
                            const emp = activeEmployees.find((e) => e.id === t.empleado_id)
                            return (
                              <button
                                key={t.id}
                                type="button"
                                disabled={isLoading || readonly}
                                onClick={() => handleEmployeeClick(t.empleado_id, t)}
                                title={
                                  readonly
                                    ? `${emp?.apellido}, ${emp?.nombre}`
                                    : `${emp?.apellido}, ${emp?.nombre} - Click para cambiar`
                                }
                                className={`text-[11px] px-1.5 py-0.5 rounded ${
                                  turnoBadgeColors[t.tipo]
                                } ${
                                  readonly ? 'cursor-default' : 'cursor-pointer hover:opacity-80'
                                } transition-opacity text-left truncate max-w-[130px]`}
                              >
                                {emp?.apellido}, {emp?.nombre}
                              </button>
                            )
                          })}
                          {!readonly && falta > 0 && (
                            <span className="text-[10px] text-red-600 font-medium">
                              faltan {falta}
                            </span>
                          )}
                          {reqCount > 0 && (
                            <span className={`text-[10px] mt-auto ${
                              cumple ? 'text-green-600' : 'text-red-600'
                            }`}>
                              {emps.length}/{reqCount}
                            </span>
                          )}
                        </div>
                      </td>
                    )
                  })}
                </tr>
              )
            })()}
          </tbody>
        </table>
      </div>

      {!readonly && (
        <div className="flex items-center gap-4 text-xs text-muted-foreground">
          <div className="flex items-center gap-1">
            <span className="w-3 h-3 rounded-sm inline-block bg-red-100 border border-red-300" />
            <span>No cumple mínimo requerido</span>
          </div>
          <span>Click en un empleado para cambiar su turno (M &rarr; T &rarr; V &rarr; N &rarr; eliminar)</span>
        </div>
      )}
    </div>
  )
}
