'use client'

import { useMe } from '@/features/auth/hooks/use-auth'
import { useEmployee } from '@/features/employees/hooks/use-employees'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import Link from 'next/link'
import { Button } from '@/components/ui/button'

const tipoLabels: Record<string, string> = {
  SUPERVISOR: 'Supervisor/a',
  NURSE: 'Licenciada/o en Enfermería',
  NURSE_ASSISTANT: 'Enfermera/o',
  AUXILIAR_SERVICIO: 'Auxiliar de Servicio',
}

export default function ProfilePage() {
  const { data: meData, isLoading: meLoading } = useMe()
  const employeeId = meData?.user?.employee_id
  const { data: employee, isLoading: empLoading, isError: empError } = useEmployee(employeeId ?? '')

  if (meLoading) {
    return (
      <div className="text-center py-8 text-muted-foreground">Cargando...</div>
    )
  }

  const user = meData?.user

  if (!user) {
    return (
      <div className="text-center py-8">
        <p className="text-destructive mb-4">Sesión no encontrada</p>
        <Link href="/login">
          <Button variant="outline">Volver al inicio</Button>
        </Link>
      </div>
    )
  }

  if (!employeeId) {
    return (
      <div className="space-y-6">
        <h1 className="text-2xl font-bold">Mi perfil</h1>
        <Card>
          <CardHeader>
            <CardTitle>Información de usuario</CardTitle>
          </CardHeader>
          <CardContent>
            <dl className="grid grid-cols-2 gap-4 text-sm">
              <div>
                <dt className="text-muted-foreground">Usuario</dt>
                <dd className="font-medium">{user.username}</dd>
              </div>
              <div>
                <dt className="text-muted-foreground">Rol</dt>
                <dd className="font-medium">{user.role}</dd>
              </div>
            </dl>
          </CardContent>
        </Card>
        <p className="text-sm text-muted-foreground">
          No hay datos de empleado vinculados a esta cuenta.
        </p>
      </div>
    )
  }

  if (empLoading) {
    return (
      <div className="text-center py-8 text-muted-foreground">Cargando datos del empleado...</div>
    )
  }

  if (empError || !employee) {
    return (
      <div className="space-y-6">
        <h1 className="text-2xl font-bold">Mi perfil</h1>
        <Card>
          <CardHeader>
            <CardTitle>Información de usuario</CardTitle>
          </CardHeader>
          <CardContent>
            <dl className="grid grid-cols-2 gap-4 text-sm">
              <div>
                <dt className="text-muted-foreground">Usuario</dt>
                <dd className="font-medium">{user.username}</dd>
              </div>
              <div>
                <dt className="text-muted-foreground">Rol</dt>
                <dd className="font-medium">{user.role}</dd>
              </div>
            </dl>
          </CardContent>
        </Card>
        <div className="rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
          No se encontraron datos de empleado vinculados a este usuario.
          Contacte al administrador si el problema persiste.
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold">
        {employee.apellido}, {employee.nombre}
      </h1>

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
    </div>
  )
}
