'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { toast } from 'sonner'
import type { Employee, CreateEmployeePayload, EmployeeType } from '@/types/employee'
import { useCreateEmployee, useUpdateEmployee } from '@/features/employees/hooks/use-employees'

interface EmployeeFormProps {
  employee?: Employee
}

export function EmployeeForm({ employee }: EmployeeFormProps) {
  const router = useRouter()
  const createMutation = useCreateEmployee()
  const updateMutation = useUpdateEmployee(employee?.id ?? '')
  const isEditing = !!employee

  const [nombre, setNombre] = useState(employee?.nombre ?? '')
  const [apellido, setApellido] = useState(employee?.apellido ?? '')
  const [tipo, setTipo] = useState<EmployeeType>(employee?.tipo ?? 'NURSE')
  const [horasMinimas, setHorasMinimas] = useState(employee?.horas_minimas ?? 120)
  const [horasMaximas, setHorasMaximas] = useState(employee?.horas_maximas ?? 200)
  const [workDays, setWorkDays] = useState(employee?.work_days ?? 4)
  const [restDays, setRestDays] = useState(employee?.rest_days ?? 1)
  const [error, setError] = useState('')

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setError('')

    const payload: CreateEmployeePayload = {
      nombre,
      apellido,
      tipo,
      horas_minimas: horasMinimas,
      horas_maximas: horasMaximas,
      work_days: isEditing ? workDays : (workDays !== 4 ? workDays : undefined),
      rest_days: isEditing ? restDays : (restDays !== 1 ? restDays : undefined),
    }

    try {
      if (isEditing) {
        await updateMutation.mutateAsync(payload)
        toast.success('Empleado actualizado correctamente')
      } else {
        await createMutation.mutateAsync(payload)
        toast.success('Empleado creado correctamente')
      }
      router.push('/employees')
      router.refresh()
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Error al guardar empleado'
      setError(message)
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-6 max-w-lg">
      {error && (
        <div className="bg-destructive/10 text-destructive text-sm p-3 rounded-md">
          {error}
        </div>
      )}

      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-2">
          <Label htmlFor="nombre">Nombre</Label>
          <Input
            id="nombre"
            value={nombre}
            onChange={(e) => setNombre(e.target.value)}
            required
          />
        </div>
        <div className="space-y-2">
          <Label htmlFor="apellido">Apellido</Label>
          <Input
            id="apellido"
            value={apellido}
            onChange={(e) => setApellido(e.target.value)}
            required
          />
        </div>
      </div>

      <div className="space-y-2">
        <Label htmlFor="tipo">Tipo</Label>
        <Select value={tipo} onValueChange={(v) => { if (v) setTipo(v as EmployeeType) }}>
          <SelectTrigger>
            <SelectValue />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="NURSE">Licenciada/o</SelectItem>
            <SelectItem value="NURSE_ASSISTANT">Enfermera/o</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-2">
          <Label htmlFor="horas_minimas">Horas mínimas mensuales</Label>
          <Input
            id="horas_minimas"
            type="number"
            value={horasMinimas}
            onChange={(e) => setHorasMinimas(Number(e.target.value))}
            required
          />
        </div>
        <div className="space-y-2">
          <Label htmlFor="horas_maximas">Horas máximas mensuales</Label>
          <Input
            id="horas_maximas"
            type="number"
            value={horasMaximas}
            onChange={(e) => setHorasMaximas(Number(e.target.value))}
            required
          />
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-2">
          <Label htmlFor="work_days">Días trabajados</Label>
          <Input
            id="work_days"
            type="number"
            value={workDays}
            onChange={(e) => setWorkDays(Number(e.target.value))}
            min={1}
          />
        </div>
        <div className="space-y-2">
          <Label htmlFor="rest_days">Días descanso</Label>
          <Input
            id="rest_days"
            type="number"
            value={restDays}
            onChange={(e) => setRestDays(Number(e.target.value))}
            min={1}
          />
        </div>
      </div>

      <div className="flex gap-4">
        <Button type="submit" disabled={createMutation.isPending || updateMutation.isPending}>
          {isEditing ? 'Guardar cambios' : 'Crear empleado'}
        </Button>
        <Button type="button" variant="outline" onClick={() => router.back()}>
          Cancelar
        </Button>
      </div>
    </form>
  )
}
