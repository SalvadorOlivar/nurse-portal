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
import { useCreatePlanificacion } from '@/features/planificaciones/hooks/use-planificaciones'

export function PlanificacionForm() {
  const router = useRouter()
  const createMutation = useCreatePlanificacion()

  const today = new Date()
  const [mes, setMes] = useState(String(today.getMonth() + 1))
  const [anio, setAnio] = useState(String(today.getFullYear()))
  const [nombre, setNombre] = useState('')
  const [error, setError] = useState('')

  const monthNames = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
  ]

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setError('')

    const generatedName = nombre || `Planificación ${monthNames[Number(mes) - 1]} ${anio}`

    try {
      await createMutation.mutateAsync({
        mes: Number(mes),
        anio: Number(anio),
        nombre: generatedName,
      })
      toast.success('Planificación creada correctamente')
      router.push('/planificaciones')
      router.refresh()
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Error al crear planificación'
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

      <div className="space-y-2">
        <Label htmlFor="nombre">Nombre</Label>
        <Input
          id="nombre"
          placeholder="Planificación Junio 2026"
          value={nombre}
          onChange={(e) => setNombre(e.target.value)}
        />
        <p className="text-xs text-muted-foreground">Si se deja vacío, se generará automáticamente.</p>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-2">
          <Label htmlFor="mes">Mes</Label>
          <Select value={mes} onValueChange={(v) => { if (v) setMes(v) }}>
            <SelectTrigger>
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {monthNames.map((name, i) => (
                <SelectItem key={i + 1} value={String(i + 1)}>{name}</SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
        <div className="space-y-2">
          <Label htmlFor="anio">Año</Label>
          <Input
            id="anio"
            type="number"
            value={anio}
            onChange={(e) => setAnio(e.target.value)}
            min={2020}
            max={2100}
            required
          />
        </div>
      </div>

      <div className="flex gap-4">
        <Button type="submit" disabled={createMutation.isPending}>
          Crear planificación
        </Button>
        <Button type="button" variant="outline" onClick={() => router.back()}>
          Cancelar
        </Button>
      </div>
    </form>
  )
}
