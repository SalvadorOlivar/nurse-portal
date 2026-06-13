import { PlanificacionForm } from '@/components/planificaciones/planificacion-form'

export default function NewPlanificacionPage() {
  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold">Nueva planificación</h1>
      <PlanificacionForm />
    </div>
  )
}
