'use client'

import { FormEvent, useState } from 'react'
import { CalendarPlus, FileText, HeartPulse, Plane, UserRound, X } from 'lucide-react'
import { toast } from 'sonner'
import { Card, EmptyState, PageHeader, StatsGrid, StatusBadge, daysBetween, fullName, initials, isDateInRange, todayIso } from '@/components/hospital/hospital-ui'
import { useEmployees } from '@/features/employees/hooks/use-employees'
import { useApproveLeaveRequest, useCreateLeaveRequest, useLeaveRequests, useRejectLeaveRequest } from '@/features/ausencia/hooks/use-ausencia'
import { useMe } from '@/features/auth/hooks/use-auth'
import type { LeaveStatus, LeaveType } from '@/types/ausencia'

const typeLabels: Record<LeaveType, string> = {
  VACACIONES: 'Vacaciones',
  ENFERMEDAD: 'Medica',
  PERSONAL: 'Personal',
  DIA_FAVOR: 'Dia a favor',
}

const statusLabels: Record<LeaveStatus, string> = {
  APROBADO: 'Aprobada',
  PENDIENTE: 'Pendiente',
  RECHAZADO: 'Rechazada',
}

function typeIcon(type: LeaveType) {
  if (type === 'VACACIONES') return Plane
  if (type === 'ENFERMEDAD') return HeartPulse
  if (type === 'PERSONAL') return UserRound
  return FileText
}

function statusTone(status: LeaveStatus) {
  if (status === 'APROBADO') return 'success' as const
  if (status === 'RECHAZADO') return 'danger' as const
  return 'warn' as const
}

export function LeaveRequestList() {
  const { data: meData } = useMe()
  const { data, isLoading, isError } = useLeaveRequests()
  const { data: employeesData } = useEmployees()
  const approveMutation = useApproveLeaveRequest()
  const rejectMutation = useRejectLeaveRequest()
  const canApprove = meData?.user.role === 'ADMIN' || meData?.user.role === 'SUPERVISOR'
  const [modalOpen, setModalOpen] = useState(false)
  const [typeFilter, setTypeFilter] = useState('Todas')
  const [statusFilter, setStatusFilter] = useState('Todos')
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')

  const requests = data?.data ?? []
  const employees = employeesData?.data ?? []
  const today = todayIso()
  const currentMonth = today.slice(0, 7)
  const filteredRequests = requests.filter((request) => {
    const matchesType = typeFilter === 'Todas' || request.tipo === typeFilter
    const matchesStatus = statusFilter === 'Todos' || request.estado === statusFilter
    const matchesFrom = !from || request.fecha_fin >= from
    const matchesTo = !to || request.fecha_inicio <= to
    return matchesType && matchesStatus && matchesFrom && matchesTo
  })

  async function handleApprove(id: string) {
    try {
      await approveMutation.mutateAsync(id)
      toast.success('Licencia aprobada')
    } catch {
      toast.error('Error al aprobar licencia')
    }
  }

  async function handleReject(id: string) {
    try {
      await rejectMutation.mutateAsync(id)
      toast.success('Licencia rechazada')
    } catch {
      toast.error('Error al rechazar licencia')
    }
  }

  if (isLoading) {
    return <div className="np-empty">Cargando licencias...</div>
  }

  if (isError) {
    return <div className="np-empty text-[var(--danger)]">Error al cargar licencias.</div>
  }

  return (
    <div className="np-page">
      <PageHeader
        title="Licencias y ausencias"
        subtitle="Control de ausencias aprobadas, pendientes y planificadas."
        actions={
          <button type="button" className="np-btn np-btn-primary" onClick={() => setModalOpen(true)}>
            <CalendarPlus className="size-4" />
            <span className="np-action-text">Solicitar licencia</span>
          </button>
        }
      />

      <StatsGrid
        items={[
          { label: 'Licencias activas', value: requests.filter((request) => request.estado === 'APROBADO' && isDateInRange(today, request.fecha_inicio, request.fecha_fin)).length, highlight: true },
          { label: 'Pendientes', value: requests.filter((request) => request.estado === 'PENDIENTE').length },
          { label: 'Planificadas hoy', value: requests.filter((request) => request.fecha_inicio === today).length },
          { label: 'Totales mes', value: requests.filter((request) => request.fecha_inicio.slice(0, 7) === currentMonth).length },
        ]}
      />

      <Card title="Filtros">
        <div className="grid gap-4 md:grid-cols-4">
          <label>
            <span className="np-label">Tipo de licencia</span>
            <select className="np-select" value={typeFilter} onChange={(event) => setTypeFilter(event.target.value)}>
              <option>Todas</option>
              <option value="ENFERMEDAD">Medica</option>
              <option value="PERSONAL">Personal</option>
              <option value="VACACIONES">Vacaciones</option>
            </select>
          </label>
          <label>
            <span className="np-label">Estado</span>
            <select className="np-select" value={statusFilter} onChange={(event) => setStatusFilter(event.target.value)}>
              <option>Todos</option>
              <option value="APROBADO">Aprobada</option>
              <option value="PENDIENTE">Pendiente</option>
              <option value="RECHAZADO">Rechazada</option>
            </select>
          </label>
          <label>
            <span className="np-label">Fecha desde</span>
            <input className="np-input" type="date" value={from} onChange={(event) => setFrom(event.target.value)} />
          </label>
          <label>
            <span className="np-label">Fecha hasta</span>
            <input className="np-input" type="date" value={to} onChange={(event) => setTo(event.target.value)} />
          </label>
        </div>
      </Card>

      {filteredRequests.length === 0 ? (
        <Card>
          <EmptyState>No hay licencias para los filtros seleccionados.</EmptyState>
        </Card>
      ) : (
        <div className="grid gap-4 xl:grid-cols-2">
          {filteredRequests.map((request) => {
            const employee = employees.find((item) => item.id === request.employee_id)
            const Icon = typeIcon(request.tipo)
            return (
              <article key={request.id} className="np-card">
                <div className="np-card-body space-y-4">
                  <div className="flex items-start justify-between gap-4">
                    <div className="flex items-center gap-3">
                      <span className="grid size-[38px] place-items-center rounded-full bg-[var(--accent-light)] text-sm font-semibold text-[var(--accent-dark)]">
                        {initials(employee?.nombre, employee?.apellido)}
                      </span>
                      <div>
                        <h3 className="font-[590]">{fullName(employee)}</h3>
                        <div className="mt-1 flex items-center gap-2 text-[0.8rem] text-[var(--muted-foreground)]">
                          <Icon className="size-4" />
                          {typeLabels[request.tipo]}
                        </div>
                      </div>
                    </div>
                    <StatusBadge tone={statusTone(request.estado)}>{statusLabels[request.estado]}</StatusBadge>
                  </div>

                  <div className="grid gap-3 sm:grid-cols-3">
                    <Info label="Inicio - fin" value={`${request.fecha_inicio} - ${request.fecha_fin}`} />
                    <Info label="Dias totales" value={daysBetween(request.fecha_inicio, request.fecha_fin)} />
                    <Info label="Estado" value={statusLabels[request.estado]} />
                  </div>

                  <p className="rounded-[var(--radius-sm)] border border-[var(--border)] bg-[var(--bg)] p-3 text-sm text-[var(--muted-foreground)]">
                    {request.motivo || 'Sin nota registrada.'}
                  </p>

                  {canApprove && request.estado === 'PENDIENTE' && (
                    <div className="flex justify-end gap-2">
                      <button type="button" className="np-btn np-btn-sm" onClick={() => handleApprove(request.id)} disabled={approveMutation.isPending}>
                        Aprobar
                      </button>
                      <button type="button" className="np-btn np-btn-sm" onClick={() => handleReject(request.id)} disabled={rejectMutation.isPending}>
                        Rechazar
                      </button>
                    </div>
                  )}
                </div>
              </article>
            )
          })}
        </div>
      )}

      <LeaveModal open={modalOpen} onClose={() => setModalOpen(false)} employees={employees} />
    </div>
  )
}

function Info({ label, value }: { label: string; value: string | number }) {
  return (
    <div>
      <div className="text-[0.72rem] font-semibold uppercase tracking-[0.06em] text-[var(--muted-foreground)]">{label}</div>
      <div className="mt-1 text-sm font-[510]">{value}</div>
    </div>
  )
}

function LeaveModal({
  open,
  onClose,
  employees,
}: {
  open: boolean
  onClose: () => void
  employees: { id: string; nombre: string; apellido: string }[]
}) {
  const createMutation = useCreateLeaveRequest()
  const [form, setForm] = useState({
    employee_id: '',
    tipo: 'ENFERMEDAD' as LeaveType,
    fecha_inicio: todayIso(),
    fecha_fin: todayIso(),
    motivo: '',
  })

  async function handleSubmit(event: FormEvent) {
    event.preventDefault()
    try {
      await createMutation.mutateAsync({ ...form, employee_id: selectedEmployee })
      toast.success('Licencia solicitada')
      onClose()
    } catch {
      toast.error('Error al solicitar licencia')
    }
  }

  const selectedEmployee = form.employee_id || employees[0]?.id || ''

  return (
    <div className={open ? 'np-modal-backdrop visible' : 'np-modal-backdrop'} role="dialog" aria-modal="true" aria-labelledby="new-leave-title">
      <form className="np-modal" onSubmit={handleSubmit}>
        <div className="np-modal-header">
          <h2 id="new-leave-title" className="np-card-title">Solicitar licencia</h2>
          <button type="button" className="np-btn np-btn-sm" onClick={onClose} aria-label="Cerrar modal">
            <X className="size-4" />
          </button>
        </div>
        <div className="np-modal-body grid gap-4 sm:grid-cols-2">
          <label className="sm:col-span-2">
            <span className="np-label">Empleado</span>
            <select className="np-select" value={selectedEmployee} onChange={(event) => setForm({ ...form, employee_id: event.target.value })} required>
              {employees.map((employee) => (
                <option key={employee.id} value={employee.id}>{fullName(employee)}</option>
              ))}
            </select>
          </label>
          <label>
            <span className="np-label">Tipo</span>
            <select className="np-select" value={form.tipo} onChange={(event) => setForm({ ...form, tipo: event.target.value as LeaveType })}>
              {Object.entries(typeLabels).map(([value, label]) => (
                <option key={value} value={value}>{label}</option>
              ))}
            </select>
          </label>
          <label>
            <span className="np-label">Inicio</span>
            <input className="np-input" type="date" value={form.fecha_inicio} onChange={(event) => setForm({ ...form, fecha_inicio: event.target.value })} />
          </label>
          <label>
            <span className="np-label">Fin</span>
            <input className="np-input" type="date" value={form.fecha_fin} onChange={(event) => setForm({ ...form, fecha_fin: event.target.value })} />
          </label>
          <label className="sm:col-span-2">
            <span className="np-label">Motivo</span>
            <textarea className="np-textarea min-h-24" value={form.motivo} onChange={(event) => setForm({ ...form, motivo: event.target.value })} required />
          </label>
        </div>
        <div className="np-modal-footer">
          <button type="button" className="np-btn" onClick={onClose}>Cancelar</button>
          <button type="submit" className="np-btn np-btn-primary" disabled={createMutation.isPending || !selectedEmployee}>
            {createMutation.isPending ? 'Enviando...' : 'Enviar solicitud'}
          </button>
        </div>
      </form>
    </div>
  )
}
