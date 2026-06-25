'use client'

import Link from 'next/link'
import { CalendarPlus, CheckCircle2 } from 'lucide-react'
import { EmptyState, PageHeader, StatusBadge } from '@/components/hospital/hospital-ui'
import { useMe } from '@/features/auth/hooks/use-auth'
import { usePlanificaciones } from '@/features/planificaciones/hooks/use-planificaciones'

export function PlanificacionList() {
  const { data: plansData, isLoading, isError } = usePlanificaciones()
  const { data: meData } = useMe()

  const plans = plansData?.data ?? []
  const canEdit = meData?.user.role === 'ADMIN' || meData?.user.role === 'SUPERVISOR'

  if (isLoading) {
    return <div className="np-empty">Cargando planificaciones...</div>
  }

  if (isError) {
    return <div className="np-empty text-[var(--danger)]">Error al cargar planificaciones. Verifica que el servidor este corriendo.</div>
  }

  return (
    <div className="np-page">
      <PageHeader
        title="Planificaciones"
        subtitle="Gestiona las planificaciones semanales del personal."
        actions={
          <>
            <StatusBadge tone={plans.some((plan) => plan.estado === 'PUBLICADO') ? 'success' : 'warn'}>
              <CheckCircle2 className="size-3.5" />
              {plans.some((plan) => plan.estado === 'PUBLICADO') ? 'Semana publicada' : 'Sin publicacion'}
            </StatusBadge>
            {canEdit && (
              <Link href="/planificaciones/new" className="np-btn np-btn-primary">
                <CalendarPlus className="size-4" />
                <span className="np-action-text">Nueva planificacion</span>
              </Link>
            )}
          </>
        }
      />

      <section className="np-card overflow-hidden">
        <div className="np-card-body">
          {plans.length === 0 ? (
            <EmptyState>No hay planificaciones configuradas.</EmptyState>
          ) : (
            <div className="np-table-wrap">
              <table className="np-table">
                <thead>
                  <tr>
                    <th>Nombre</th>
                    <th>Periodo</th>
                    <th>Dias</th>
                    <th>Estado</th>
                    <th className="text-right">Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  {plans.map((plan) => (
                    <tr key={plan.id}>
                      <td className="font-[510]">{plan.nombre}</td>
                      <td>
                        Semana {plan.semana} de {plan.anio}
                      </td>
                      <td>{plan.dias}</td>
                      <td>
                        <StatusBadge tone={plan.estado === 'PUBLICADO' ? 'success' : plan.estado === 'CERRADO' ? 'accent' : 'warn'}>
                          {plan.estado === 'PUBLICADO' ? 'Publicado' : plan.estado === 'CERRADO' ? 'Cerrado' : 'Borrador'}
                        </StatusBadge>
                      </td>
                      <td>
                        <div className="flex justify-end gap-2">
                          <Link href={`/planificaciones/${plan.id}`} className="np-btn np-btn-sm">
                            Ver planilla
                          </Link>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </section>
    </div>
  )
}
