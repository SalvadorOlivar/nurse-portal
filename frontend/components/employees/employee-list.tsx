'use client'

import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import { Badge } from '@/components/ui/badge'
import { useEmployees, useDeactivateEmployee } from '@/features/employees/hooks/use-employees'
import { toast } from 'sonner'
import type { Employee } from '@/types/employee'

const tipoLabels: Record<string, string> = {
  SUPERVISOR: 'Supervisor/a',
  NURSE: 'Licenciada/o en Enfermería',
  NURSE_ASSISTANT: 'Enfermera/o',
  AUXILIAR_SERVICIO: 'Auxiliar de Servicio',
}

function EmployeeRow({ employee }: { employee: Employee }) {
  const deactivateMutation = useDeactivateEmployee()

  async function handleDeactivate() {
    try {
      await deactivateMutation.mutateAsync(employee.id)
      toast.success('Empleado desactivado correctamente')
    } catch {
      toast.error('Error al desactivar empleado')
    }
  }

  return (
    <TableRow key={employee.id}>
      <TableCell className="font-medium">
        {employee.apellido}, {employee.nombre}
      </TableCell>
      <TableCell>{tipoLabels[employee.tipo] ?? employee.tipo}</TableCell>
      <TableCell>{employee.horas_minimas}h / {employee.horas_maximas}h</TableCell>
      <TableCell>{employee.work_days}x{employee.rest_days}</TableCell>
      <TableCell>
        {employee.activo ? (
          <Badge variant="default" className="bg-green-600">Activo</Badge>
        ) : (
          <Badge variant="secondary">Inactivo</Badge>
        )}
      </TableCell>
      <TableCell className="text-right">
        <div className="flex justify-end gap-2">
          <Link href={`/employees/${employee.id}`}>
            <Button variant="outline" size="sm">Editar</Button>
          </Link>
          {employee.activo && (
            <Button
              variant="outline"
              size="sm"
              className="text-destructive"
              onClick={handleDeactivate}
              disabled={deactivateMutation.isPending}
            >
              Desactivar
            </Button>
          )}
        </div>
      </TableCell>
    </TableRow>
  )
}

export function EmployeeList() {
  const { data, isLoading, isError } = useEmployees()

  if (isLoading) {
    return <div className="text-center py-8 text-muted-foreground">Cargando empleados...</div>
  }

  if (isError) {
    return (
      <div className="text-center py-8 text-destructive">
        Error al cargar empleados. Verifica que el servidor esté corriendo.
      </div>
    )
  }

  const employees = data?.data ?? []

  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between">
        <CardTitle>Empleados</CardTitle>
        <Link href="/employees/new">
          <Button>Nuevo empleado</Button>
        </Link>
      </CardHeader>
      <CardContent>
        {employees.length === 0 ? (
          <div className="text-center py-8 text-muted-foreground">
            No hay empleados registrados. Crea el primero.
          </div>
        ) : (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Nombre</TableHead>
                <TableHead>Tipo</TableHead>
                <TableHead>Horas</TableHead>
                <TableHead>Patrón</TableHead>
                <TableHead>Estado</TableHead>
                <TableHead className="text-right">Acciones</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {employees.map((employee) => (
                <EmployeeRow key={employee.id} employee={employee} />
              ))}
            </TableBody>
          </Table>
        )}
      </CardContent>
    </Card>
  )
}
