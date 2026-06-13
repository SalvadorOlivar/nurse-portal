import { PlanificacionCalendario } from '@/components/planificaciones/planificacion-calendario'

export default async function PlanificacionDetailPage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params

  return <PlanificacionCalendario planificacionId={id} />
}
