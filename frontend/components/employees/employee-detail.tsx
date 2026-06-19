'use client'

import { useEmployee, useDeactivateEmployee } from '@/features/employees/hooks/use-employees'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { toast } from 'sonner'
import { EmployeeForm } from './employee-form'
import { useMe } from '@/features/auth/hooks/use-auth'

const tipoLabels: Record<string, string> = {
  SUPERVISOR: 'Supervisor/a',
  NURSE: 'Licenciada/o en Enfermería',
  NURSE_ASSISTANT: 'Enfermera/o',
  AUXILIAR_SERVICIO: 'Auxiliar de Servicio',
}

export function EmployeeDetail({ id }: { id: string }) {
  const router = useRouter()
  const { data: employee, isLoading, isError } = useEmployee(id)
  const { data: meData } = useMe()
  const deactivateMutation = useDeactivateEmployee()
  const canEdit = meData?.user.role === 'ADMIN'

  if (isLoading) {
    return <div className="text-center py-8 text-muted-foreground">Cargando...</div>
  }

  if (isError || !employee) {
    return (
      <div className="text-center py-8">
        <p className="text-destructive mb-4">Empleado no encontrado</p>
        <Button onClick={() => router.push('/employees')}>Volver</Button>
      </div>
    )
  }

  async function handleDeactivate() {
    try {
      await deactivateMutation.mutateAsync(id)
      toast.success('Empleado desactivado correctamente')
      router.refresh()
    } catch {
      toast.error('Error al desactivar empleado')
    }
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">
          {employee.apellido}, {employee.nombre}
        </h1>
        <div className="flex gap-2">
          <Button variant="outline" onClick={() => router.push('/employees')}>
            Volver
          </Button>
          {canEdit && employee.activo && (
            <Button
              variant="outline"
              className="text-destructive"
              onClick={handleDeactivate}
              disabled={deactivateMutation.isPending}
            >
              Desactivar
            </Button>
          )}
        </div>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Información general</CardTitle>
        </CardHeader>
        <CardContent>
          <dl className="grid grid-cols-2 gap-4 text-sm">
            <div>
              <dt className="text-muted-foreground">Tipo</dt>
              <dd className="font-medium">{tipoLabels[employee.tipo]}</dd>
            </div>
            <div>
              <dt className="text-muted-foreground">Estado</dt>
              <dd>
                {employee.activo ? (
                  <Badge variant="default" className="bg-green-600">Activo</Badge>
                ) : (
                  <Badge variant="secondary">Inactivo</Badge>
                )}
              </dd>
            </div>
            <div>
              <dt className="text-muted-foreground">Horas mínimas</dt>
              <dd className="font-medium">{employee.horas_minimas}h / mes</dd>
            </div>
            <div>
              <dt className="text-muted-foreground">Horas máximas</dt>
              <dd className="font-medium">{employee.horas_maximas}h / mes</dd>
            </div>
            <div>
              <dt className="text-muted-foreground">Patrón de trabajo</dt>
              <dd className="font-medium">{employee.work_days}x{employee.rest_days}</dd>
            </div>
          </dl>
        </CardContent>
      </Card>

      {canEdit && (
        <Card>
          <CardHeader>
            <CardTitle>Editar empleado</CardTitle>
          </CardHeader>
          <CardContent>
            <EmployeeForm employee={employee} />
          </CardContent>
        </Card>
      )}
    </div>
  )
}
