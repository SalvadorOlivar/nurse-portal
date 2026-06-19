'use client'

import { useState } from 'react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { toast } from 'sonner'
import { useSectores, useUpdateSectores } from '@/features/planificaciones/hooks/use-planificaciones'

interface SectorManagerProps {
  planificacionId: string
  readonly: boolean
}

export function SectorManager({ planificacionId, readonly }: SectorManagerProps) {
  const { data: sectoresData, isLoading } = useSectores(planificacionId)
  const updateMutation = useUpdateSectores()
  const [nuevoSector, setNuevoSector] = useState('')

  const sectores = sectoresData?.data ?? []

  async function handleAgregar() {
    const nombre = nuevoSector.trim()
    if (!nombre) return
    if (sectores.some((s) => s.nombre === nombre)) {
      toast.error('El sector ya existe')
      return
    }

    const nombresActuales = sectores.map((s) => s.nombre)
    const updated = [...nombresActuales, nombre]
    try {
      await updateMutation.mutateAsync({ planificacionId, payload: { sectores: updated } })
      toast.success('Sector agregado')
      setNuevoSector('')
    } catch {
      toast.error('Error al agregar sector')
    }
  }

  async function handleEliminar(nombre: string) {
    if (!confirm(`¿Eliminar sector "${nombre}"? Se borrarán las configuraciones de dotación asociadas.`)) return

    const nombresActuales = sectores.map((s) => s.nombre)
    const updated = nombresActuales.filter((n) => n !== nombre)
    try {
      await updateMutation.mutateAsync({ planificacionId, payload: { sectores: updated } })
      toast.success('Sector eliminado')
    } catch {
      toast.error('Error al eliminar sector')
    }
  }

  if (isLoading) {
    return <div className="text-sm text-muted-foreground">Cargando sectores...</div>
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-lg">Sectores</CardTitle>
      </CardHeader>
      <CardContent className="space-y-3">
        {sectores.length === 0 ? (
          <p className="text-sm text-muted-foreground">No hay sectores configurados.</p>
        ) : (
          <ul className="space-y-2">
            {sectores.map((s) => (
              <li key={s.id} className="flex items-center justify-between py-1 px-3 bg-muted/30 rounded-md">
                <span className="text-sm font-medium">Sector {s.nombre}</span>
                {!readonly && (
                  <Button
                    variant="ghost"
                    size="sm"
                    className="text-destructive h-7 px-2 text-xs"
                    onClick={() => handleEliminar(s.nombre)}
                    disabled={updateMutation.isPending}
                  >
                    Eliminar
                  </Button>
                )}
              </li>
            ))}
          </ul>
        )}

        {!readonly && (
          <div className="flex gap-2 pt-2">
            <Input
              placeholder="Ej: 21-24"
              value={nuevoSector}
              onChange={(e) => setNuevoSector(e.target.value)}
              onKeyDown={(e) => { if (e.key === 'Enter') handleAgregar() }}
              className="h-8 text-sm"
            />
            <Button
              size="sm"
              onClick={handleAgregar}
              disabled={updateMutation.isPending || !nuevoSector.trim()}
            >
              Agregar
            </Button>
          </div>
        )}
      </CardContent>
    </Card>
  )
}
