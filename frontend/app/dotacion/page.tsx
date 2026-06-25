'use client'

import { useMemo, useState } from 'react'
import { ClipboardList } from 'lucide-react'
import { Card, EmptyState, PageHeader, StatsGrid, StatusBadge } from '@/components/hospital/hospital-ui'
import { useEmployees } from '@/features/employees/hooks/use-employees'
import { usePlanificacion, usePlanificaciones, useStaffingRequirements } from '@/features/planificaciones/hooks/use-planificaciones'
import type { TipoTurno } from '@/types/planificacion'

const shifts: { key: TipoTurno; label: string }[] = [
  { key: 'MANANA', label: 'M' },
  { key: 'TARDE', label: 'T' },
  { key: 'NOCHE', label: 'N' },
]

export default function DotacionPage() {
  const { data: employeesData, isLoading: employeesLoading } = useEmployees()
  const { data: plansData, isLoading: plansLoading } = usePlanificaciones()
  const [selectedPlanId, setSelectedPlanId] = useState('')
  const [selectedSector, setSelectedSector] = useState('Todos')
  const plans = useMemo(() => plansData?.data ?? [], [plansData?.data])
  const employees = useMemo(() => employeesData?.data ?? [], [employeesData?.data])
  const activePlanId = selectedPlanId || plans[0]?.id || ''

  const { data: detail } = usePlanificacion(activePlanId)
  const { data: requirementsData } = useStaffingRequirements(activePlanId)
  const requirements = useMemo(() => requirementsData?.data ?? [], [requirementsData?.data])
  const sectorNames = useMemo(() => {
    const names = new Set<string>()
    for (const employee of employees) if (employee.sector) names.add(employee.sector)
    for (const req of requirements) if (req.sector) names.add(req.sector)
    for (const turno of detail?.turnos ?? []) if (turno.sector) names.add(turno.sector)
    return Array.from(names).sort()
  }, [detail?.turnos, employees, requirements])

  const rows = sectorNames
    .filter((sector) => selectedSector === 'Todos' || selectedSector === sector)
    .map((sector) => {
      const values = shifts.reduce<Record<string, { optimal: number; real: number }>>((acc, shift) => {
        const optimal = requirements
          .filter((req) => req.sector === sector && req.turno === shift.key)
          .reduce((sum, req) => sum + req.cantidad_minima, 0)
        const real = (detail?.turnos ?? []).filter((turno) => turno.sector === sector && turno.tipo === shift.key).length
        acc[shift.key] = { optimal, real }
        return acc
      }, {})
      const difference = Object.values(values).reduce((sum, value) => sum + (value.real - value.optimal), 0)
      return { sector, values, difference }
    })

  const uncovered = rows.reduce((sum, row) => sum + Object.values(row.values).reduce((rowSum, value) => rowSum + Math.max(value.optimal - value.real, 0), 0), 0)

  if (employeesLoading || plansLoading) {
    return <div className="np-empty">Cargando dotacion...</div>
  }

  return (
    <div className="np-page">
      <PageHeader
        title="Dotacion de personal"
        subtitle="Comparacion de dotacion optima contra cobertura real por turno."
        actions={
          <StatusBadge tone={uncovered > 0 ? 'warn' : 'success'}>
            <ClipboardList className="size-3.5" />
            {uncovered > 0 ? 'Cobertura por revisar' : 'Cobertura completa'}
          </StatusBadge>
        }
      />

      <StatsGrid
        items={[
          { label: 'Plantilla total', value: employees.length, highlight: true },
          { label: 'Jornada completa', value: employees.filter((employee) => employee.horas_maximas >= 40).length },
          { label: 'Media jornada', value: employees.filter((employee) => employee.horas_maximas > 0 && employee.horas_maximas < 40).length },
          { label: 'Por cubrir', value: uncovered },
        ]}
      />

      <Card title="Seleccion de planificacion">
        <div className="grid gap-4 md:grid-cols-2">
          <label>
            <span className="np-label">Planificacion</span>
            <select className="np-select" value={activePlanId} onChange={(event) => setSelectedPlanId(event.target.value)}>
              {plans.map((plan) => (
                <option key={plan.id} value={plan.id}>
                  {plan.nombre} - Semana {plan.semana}
                </option>
              ))}
            </select>
          </label>
          <label>
            <span className="np-label">Sector</span>
            <select className="np-select" value={selectedSector} onChange={(event) => setSelectedSector(event.target.value)}>
              <option>Todos</option>
              {sectorNames.map((sector) => (
                <option key={sector} value={sector}>{sector}</option>
              ))}
            </select>
          </label>
        </div>
      </Card>

      <Card title="Optima vs real por turno">
        {rows.length === 0 ? (
          <EmptyState>No hay dotacion configurada para la planificacion seleccionada.</EmptyState>
        ) : (
          <div className="np-table-wrap">
            <table className="np-table">
              <thead>
                <tr>
                  <th>Sector</th>
                  <th>Turno M optimo</th>
                  <th>Turno M real</th>
                  <th>Turno T optimo</th>
                  <th>Turno T real</th>
                  <th>Turno N optimo</th>
                  <th>Turno N real</th>
                  <th>Diferencia</th>
                </tr>
              </thead>
              <tbody>
                {rows.map((row) => (
                  <tr key={row.sector}>
                    <td className="font-[510]">{row.sector}</td>
                    {shifts.flatMap((shift) => [
                      <td key={`${shift.key}-optimal`}>{row.values[shift.key].optimal}</td>,
                      <td key={`${shift.key}-real`}>{row.values[shift.key].real}</td>,
                    ])}
                    <td className={row.difference < 0 ? 'font-[590] text-[var(--danger)]' : 'font-[590] text-[var(--success)]'}>
                      {row.difference > 0 ? '+' : ''}{row.difference}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </Card>

      <Card title="Personal por sector">
        <StaffingChart rows={rows.map((row) => ({
          sector: row.sector,
          optimal: Object.values(row.values).reduce((sum, value) => sum + value.optimal, 0),
          real: Object.values(row.values).reduce((sum, value) => sum + value.real, 0),
        }))} />
      </Card>
    </div>
  )
}

function StaffingChart({ rows }: { rows: { sector: string; optimal: number; real: number }[] }) {
  if (rows.length === 0) {
    return <EmptyState>Sin datos para graficar.</EmptyState>
  }

  const width = 720
  const rowHeight = 52
  const height = rows.length * rowHeight + 30
  const max = Math.max(...rows.flatMap((row) => [row.optimal, row.real]), 1)

  return (
    <div className="np-table-wrap">
      <svg viewBox={`0 0 ${width} ${height}`} role="img" aria-label="Grafico de barras de dotacion por sector" className="min-w-[680px]">
        {rows.map((row, index) => {
          const y = index * rowHeight + 22
          const optimalWidth = (row.optimal / max) * 420
          const realWidth = (row.real / max) * 420
          return (
            <g key={row.sector}>
              <text x="0" y={y + 10} fill="var(--fg)" fontSize="12" fontWeight="510">{row.sector}</text>
              <rect x="170" y={y} width={optimalWidth} height="10" rx="5" fill="var(--border)" />
              <rect x="170" y={y + 16} width={realWidth} height="10" rx="5" fill="var(--accent)" />
              <text x="610" y={y + 10} fill="var(--muted-foreground)" fontSize="11">Opt {row.optimal}</text>
              <text x="610" y={y + 26} fill="var(--muted-foreground)" fontSize="11">Real {row.real}</text>
            </g>
          )
        })}
      </svg>
    </div>
  )
}
