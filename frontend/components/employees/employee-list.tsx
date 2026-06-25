'use client'

import Link from 'next/link'
import { FormEvent, useMemo, useState } from 'react'
import { Eye, Pencil, Plus, Search, X } from 'lucide-react'
import { toast } from 'sonner'
import { EmptyState, PageHeader, StatsGrid, StatusBadge, fullName, initials, isDateInRange, todayIso } from '@/components/hospital/hospital-ui'
import { useLeaveRequests } from '@/features/ausencia/hooks/use-ausencia'
import { useMe } from '@/features/auth/hooks/use-auth'
import { useCreateEmployee, useEmployees } from '@/features/employees/hooks/use-employees'
import type { EmployeeType } from '@/types/employee'

const typeLabels: Record<EmployeeType, string> = {
  SUPERVISOR: 'Supervisor/a',
  NURSE: 'Enfermero/a',
  NURSE_ASSISTANT: 'Auxiliar',
  AUXILIAR_SERVICIO: 'Auxiliar de servicio',
}

export function EmployeeList() {
  const { data, isLoading, isError } = useEmployees()
  const { data: leavesData } = useLeaveRequests()
  const { data: meData } = useMe()
  const canEdit = meData?.user.role === 'ADMIN'
  const [query, setQuery] = useState('')
  const [sector, setSector] = useState('Todos')
  const [modalOpen, setModalOpen] = useState(false)

  const employees = useMemo(() => data?.data ?? [], [data?.data])
  const activeLeaves = leavesData?.data?.filter((leave) => leave.estado === 'APROBADO' && isDateInRange(todayIso(), leave.fecha_inicio, leave.fecha_fin)) ?? []
  const sectors = useMemo(() => ['Todos', ...Array.from(new Set(employees.map((employee) => employee.sector).filter(Boolean))).sort()], [employees])
  const filteredEmployees = employees.filter((employee) => {
    const matchesName = `${employee.nombre} ${employee.apellido}`.toLowerCase().includes(query.toLowerCase())
    const matchesSector = sector === 'Todos' || employee.sector === sector
    return matchesName && matchesSector
  })

  if (isLoading) {
    return <div className="np-empty">Cargando empleados...</div>
  }

  if (isError) {
    return <div className="np-empty text-[var(--danger)]">Error al cargar empleados. Verifica que el servidor este corriendo.</div>
  }

  return (
    <div className="np-page">
      <PageHeader
        title="Empleados"
        subtitle="Registro operativo del equipo de enfermeria y auxiliares por sector."
        actions={
          canEdit && (
            <button type="button" className="np-btn np-btn-primary" onClick={() => setModalOpen(true)}>
              <Plus className="size-4" />
              <span className="np-action-text">Nuevo empleado</span>
            </button>
          )
        }
      />

      <StatsGrid
        items={[
          { label: 'Total empleados', value: employees.length, highlight: true },
          { label: 'Enfermeros', value: employees.filter((employee) => employee.tipo === 'NURSE').length },
          { label: 'Auxiliares', value: employees.filter((employee) => employee.tipo === 'NURSE_ASSISTANT' || employee.tipo === 'AUXILIAR_SERVICIO').length },
          { label: 'En formacion', value: 0 },
        ]}
      />

      <section className="np-card">
        <div className="np-card-header">
          <h2 className="np-card-title">Listado de empleados</h2>
          <div className="flex flex-wrap items-center gap-2">
            <label className="relative w-[260px] max-w-full">
              <Search className="pointer-events-none absolute left-3 top-1/2 size-4 -translate-y-1/2 text-[var(--muted-foreground)]" />
              <input
                className="np-input pl-9"
                value={query}
                onChange={(event) => setQuery(event.target.value)}
                placeholder="Buscar por nombre"
                type="search"
              />
            </label>
            <select className="np-select w-[190px]" value={sector} onChange={(event) => setSector(event.target.value)} aria-label="Filtrar por sector">
              {sectors.map((item) => (
                <option key={item} value={item}>
                  {item}
                </option>
              ))}
            </select>
          </div>
        </div>
        <div className="np-card-body">
          {filteredEmployees.length === 0 ? (
            <EmptyState>No hay empleados para los filtros seleccionados.</EmptyState>
          ) : (
            <div className="np-table-wrap">
              <table className="np-table">
                <thead>
                  <tr>
                    <th>Nombre</th>
                    <th>Sector</th>
                    <th>Turno preferente</th>
                    <th>Telefono</th>
                    <th>Estado</th>
                    <th className="text-right">Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  {filteredEmployees.map((employee) => {
                    const leaveActive = activeLeaves.some((leave) => leave.employee_id === employee.id)
                    const status = !employee.activo ? 'Baja' : leaveActive ? 'Licencia' : 'Activo'

                    return (
                      <tr key={employee.id}>
                        <td>
                          <div className="flex items-center gap-3">
                            <span className="grid size-[34px] place-items-center rounded-full bg-[var(--accent-light)] text-[0.78rem] font-semibold text-[var(--accent-dark)]">
                              {initials(employee.nombre, employee.apellido)}
                            </span>
                            <span className="font-[510]">{fullName(employee)}</span>
                          </div>
                        </td>
                        <td>{employee.sector || 'Sin sector'}</td>
                        <td>{employee.work_days}x{employee.rest_days}</td>
                        <td>No registrado</td>
                        <td>
                          <StatusBadge tone={status === 'Activo' ? 'success' : status === 'Licencia' ? 'warn' : 'danger'}>{status}</StatusBadge>
                        </td>
                        <td>
                          <div className="flex justify-end gap-2">
                            <Link href={`/employees/${employee.id}`} className="np-btn np-btn-sm" aria-label={`${canEdit ? 'Editar' : 'Ver'} ${fullName(employee)}`}>
                              {canEdit ? <Pencil className="size-4" /> : <Eye className="size-4" />}
                              <span className="np-action-text">{canEdit ? 'Editar' : 'Ver'}</span>
                            </Link>
                          </div>
                        </td>
                      </tr>
                    )
                  })}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </section>

      <EmployeeModal open={modalOpen} onClose={() => setModalOpen(false)} />
    </div>
  )
}

function EmployeeModal({ open, onClose }: { open: boolean; onClose: () => void }) {
  const createMutation = useCreateEmployee()
  const [form, setForm] = useState({
    nombre: '',
    apellido: '',
    tipo: 'NURSE' as EmployeeType,
    sector: '',
    horas_minimas: 30,
    horas_maximas: 44,
    work_days: 5,
    rest_days: 2,
  })

  async function handleSubmit(event: FormEvent) {
    event.preventDefault()
    try {
      await createMutation.mutateAsync(form)
      toast.success('Empleado creado')
      onClose()
    } catch {
      toast.error('Error al crear empleado')
    }
  }

  return (
    <div className={open ? 'np-modal-backdrop visible' : 'np-modal-backdrop'} role="dialog" aria-modal="true" aria-labelledby="new-employee-title">
      <form className="np-modal" onSubmit={handleSubmit}>
        <div className="np-modal-header">
          <h2 id="new-employee-title" className="np-card-title">Nuevo empleado</h2>
          <button type="button" className="np-btn np-btn-sm" onClick={onClose} aria-label="Cerrar modal">
            <X className="size-4" />
          </button>
        </div>
        <div className="np-modal-body grid gap-4 sm:grid-cols-2">
          <label>
            <span className="np-label">Nombre</span>
            <input className="np-input" required value={form.nombre} onChange={(event) => setForm({ ...form, nombre: event.target.value })} />
          </label>
          <label>
            <span className="np-label">Apellido</span>
            <input className="np-input" required value={form.apellido} onChange={(event) => setForm({ ...form, apellido: event.target.value })} />
          </label>
          <label>
            <span className="np-label">Tipo</span>
            <select className="np-select" value={form.tipo} onChange={(event) => setForm({ ...form, tipo: event.target.value as EmployeeType })}>
              {Object.entries(typeLabels).map(([value, label]) => (
                <option key={value} value={value}>{label}</option>
              ))}
            </select>
          </label>
          <label>
            <span className="np-label">Sector</span>
            <input className="np-input" required value={form.sector} onChange={(event) => setForm({ ...form, sector: event.target.value })} />
          </label>
          <label>
            <span className="np-label">Horas minimas</span>
            <input className="np-input" min={0} type="number" value={form.horas_minimas} onChange={(event) => setForm({ ...form, horas_minimas: Number(event.target.value) })} />
          </label>
          <label>
            <span className="np-label">Horas maximas</span>
            <input className="np-input" min={0} type="number" value={form.horas_maximas} onChange={(event) => setForm({ ...form, horas_maximas: Number(event.target.value) })} />
          </label>
        </div>
        <div className="np-modal-footer">
          <button type="button" className="np-btn" onClick={onClose}>Cancelar</button>
          <button type="submit" className="np-btn np-btn-primary" disabled={createMutation.isPending}>
            {createMutation.isPending ? 'Guardando...' : 'Guardar empleado'}
          </button>
        </div>
      </form>
    </div>
  )
}
