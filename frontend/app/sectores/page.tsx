'use client'

import { Building2, Edit3 } from 'lucide-react'
import { Card, EmptyState, PageHeader, StatsGrid, StatusBadge } from '@/components/hospital/hospital-ui'
import { useEmployees } from '@/features/employees/hooks/use-employees'

export default function SectoresPage() {
  const { data, isLoading, isError } = useEmployees()
  const employees = data?.data ?? []
  const sectorNames = Array.from(new Set(employees.map((employee) => employee.sector).filter(Boolean))).sort()
  const sectors = sectorNames.map((name) => {
    const assigned = employees.filter((employee) => employee.sector === name && employee.activo)
    const nurses = assigned.filter((employee) => employee.tipo === 'NURSE').length
    const auxiliaries = assigned.filter((employee) => employee.tipo === 'NURSE_ASSISTANT' || employee.tipo === 'AUXILIAR_SERVICIO').length
    const status = assigned.length >= 6 ? 'Completo' : assigned.length > 0 ? 'Parcial' : 'Critico'
    return { name, assigned, nurses, auxiliaries, status }
  })

  if (isLoading) {
    return <div className="np-empty">Cargando sectores...</div>
  }

  if (isError) {
    return <div className="np-empty text-[var(--danger)]">Error al cargar sectores.</div>
  }

  return (
    <div className="np-page">
      <PageHeader
        title="Sectores del hospital"
        subtitle="Configuracion operativa de sectores y personal asignado."
        actions={
          <button type="button" className="np-btn">
            <Building2 className="size-4" />
            <span className="np-action-text">Gestionar sectores</span>
          </button>
        }
      />

      <StatsGrid
        items={[
          { label: 'Total sectores', value: sectors.length, highlight: true },
          { label: 'Camas totales', value: 'Sin dato' },
          { label: 'Personal asignado', value: employees.filter((employee) => employee.activo).length },
          { label: 'Ratio enfermero/paciente', value: 'N/D' },
        ]}
      />

      {sectors.length === 0 ? (
        <Card>
          <EmptyState>No hay sectores registrados en empleados activos.</EmptyState>
        </Card>
      ) : (
        <div className="grid gap-4 lg:grid-cols-2 2xl:grid-cols-3">
          {sectors.map((sector) => (
            <article key={sector.name} className="np-card">
              <div className="np-card-header">
                <div>
                  <h2 className="np-card-title">{sector.name}</h2>
                  <p className="np-page-kicker">No clasificado</p>
                </div>
                <StatusBadge tone={sector.status === 'Completo' ? 'success' : sector.status === 'Parcial' ? 'warn' : 'danger'}>
                  {sector.status}
                </StatusBadge>
              </div>
              <div className="np-card-body space-y-5">
                <div className="grid grid-cols-2 gap-4">
                  <Metric label="Camas" value="Sin dato" />
                  <Metric label="Ocupacion" value="Sin dato" />
                  <Metric label="Enfermeros" value={sector.nurses} />
                  <Metric label="Auxiliares" value={sector.auxiliaries} />
                </div>
                <div className="rounded-[var(--radius-sm)] border border-[var(--border)] bg-[var(--bg)] p-3">
                  <div className="text-[0.72rem] font-semibold uppercase tracking-[0.06em] text-[var(--muted-foreground)]">Personal asignado</div>
                  <div className="mt-1 text-lg font-[590]">{sector.assigned.length}</div>
                </div>
                <button type="button" className="np-btn np-btn-sm">
                  <Edit3 className="size-4" />
                  <span className="np-action-text">Editar sector</span>
                </button>
              </div>
            </article>
          ))}
        </div>
      )}
    </div>
  )
}

function Metric({ label, value }: { label: string; value: string | number }) {
  return (
    <div>
      <div className="text-[0.72rem] font-semibold uppercase tracking-[0.06em] text-[var(--muted-foreground)]">{label}</div>
      <div className="mt-1 font-[590] tabular-nums">{value}</div>
    </div>
  )
}
