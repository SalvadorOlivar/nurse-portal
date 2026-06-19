'use client'

import { useMemo, useCallback, useEffect, useState } from 'react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { toast } from 'sonner'
import { useSectores, useStaffingRequirements, useUpdateDotacion } from '@/features/planificaciones/hooks/use-planificaciones'

const tipoLabels: Record<string, string> = {
  SUPERVISOR: 'Supervisor/a',
  NURSE: 'Licenciada/o en Enf.',
  NURSE_ASSISTANT: 'Enfermera/o',
  AUXILIAR_SERVICIO: 'Aux. Servicio',
}

const turnoLabels: Record<string, string> = {
  MANANA: 'Mañana',
  TARDE: 'Tarde',
  VESPERTINO: 'Vespertino',
  NOCHE: 'Noche',
}

const turnoColors: Record<string, string> = {
  MANANA: 'bg-blue-50',
  TARDE: 'bg-yellow-50',
  VESPERTINO: 'bg-orange-50',
  NOCHE: 'bg-indigo-50',
}

const turnosOrden = ['MANANA', 'TARDE', 'VESPERTINO', 'NOCHE'] as const

interface DotacionConfigProps {
  planificacionId: string
  readonly: boolean
}

export function DotacionConfig({ planificacionId, readonly }: DotacionConfigProps) {
  useSectores(planificacionId)
  const { data: reqData } = useStaffingRequirements(planificacionId)
  const updateMutation = useUpdateDotacion()

  const requirements = useMemo(() => reqData?.data ?? [], [reqData?.data])

  const [valores, setValores] = useState<Record<string, number>>({})

  useEffect(() => {
    const map: Record<string, number> = {}
    for (const req of requirements) {
      const key = `${req.sector}|${req.tipo_empleado}|${req.turno}`
      map[key] = req.cantidad_minima
    }
    queueMicrotask(() => {
      setValores((prev) => {
        const hasChanges = Object.keys(map).some((k) => map[k] !== prev[k])
        return hasChanges ? map : prev
      })
    })
  }, [requirements])

  const handleChange = useCallback((key: string, value: number) => {
    setValores((prev) => ({ ...prev, [key]: value }))
  }, [])

  async function handleGuardar() {
    const items: { sector: string; tipo_empleado: string; turno: string; cantidad_minima: number }[] = []

    for (const [key, cantidad] of Object.entries(valores)) {
      const [sector, tipo_empleado, turno] = key.split('|')
      items.push({ sector, tipo_empleado, turno, cantidad_minima: cantidad })
    }

    try {
      await updateMutation.mutateAsync({ planificacionId, payload: { items } })
      toast.success('Dotación guardada')
    } catch {
      toast.error('Error al guardar dotación')
    }
  }

  const allSectores = useMemo(() => {
    return [...new Set(requirements.filter((r) => r.sector).map((r) => r.sector))].sort((a, b) => {
      const na = parseInt(a.split('-')[0], 10)
      const nb = parseInt(b.split('-')[0], 10)
      return na - nb
    })
  }, [requirements])

  const getValor = (sector: string, tipo: string, turno: string) => {
    const key = `${sector}|${tipo}|${turno}`
    return valores[key] ?? 0
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-lg">Dotación Mínima por Turno</CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="overflow-x-auto pb-4">
          <table className="w-full text-sm border-collapse">
            <thead>
              <tr>
                <th className="text-left px-3 py-2 font-medium text-muted-foreground border-b w-48">
                  Cargo
                </th>
                {turnosOrden.map((turno) => (
                  <th
                    key={turno}
                    className={`px-3 py-2 font-medium text-center border-b ${turnoColors[turno]}`}
                  >
                    {turnoLabels[turno]}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              <tr>
                <td className="px-3 py-2 font-medium border-b">
                  {tipoLabels['SUPERVISOR'] ?? 'SUPERVISOR'}
                </td>
                {turnosOrden.map((turno) => (
                  <td key={turno} className={`px-3 py-2 border-b text-center ${turnoColors[turno]}`}>
                    <Input
                      type="number"
                      min={0}
                      value={getValor('', 'SUPERVISOR', turno)}
                      onChange={(e) => handleChange(`|SUPERVISOR|${turno}`, Math.max(0, Number(e.target.value)))}
                      className="w-16 h-8 text-center mx-auto"
                      disabled={readonly}
                    />
                  </td>
                ))}
              </tr>

              {allSectores.map((sec) => (
                <tr key={`sec-${sec}`}>
                  <td className="px-3 py-1 font-medium text-xs text-muted-foreground border-b" colSpan={5}>
                    Sector {sec}
                  </td>
                </tr>
              ))}
              {allSectores.map((sec) => (
                ['NURSE', 'NURSE_ASSISTANT'].map((tipo) => (
                  <tr key={`${sec}-${tipo}`}>
                    <td className="px-3 py-2 text-sm border-b pl-6">
                      {tipoLabels[tipo] ?? tipo}
                    </td>
                    {turnosOrden.map((turno) => (
                      <td key={turno} className={`px-3 py-2 border-b text-center ${turnoColors[turno]}`}>
                        <Input
                          type="number"
                          min={0}
                          value={getValor(sec, tipo, turno)}
                          onChange={(e) => handleChange(`${sec}|${tipo}|${turno}`, Math.max(0, Number(e.target.value)))}
                          className="w-16 h-8 text-center mx-auto"
                          disabled={readonly}
                        />
                      </td>
                    ))}
                  </tr>
                ))
              ))}

              <tr>
                <td className="px-3 py-2 font-medium border-b">
                  {tipoLabels['AUXILIAR_SERVICIO'] ?? 'AUXILIAR_SERVICIO'}
                </td>
                {turnosOrden.map((turno) => (
                  <td key={turno} className={`px-3 py-2 border-b text-center ${turnoColors[turno]}`}>
                    <Input
                      type="number"
                      min={0}
                      value={getValor('', 'AUXILIAR_SERVICIO', turno)}
                      onChange={(e) => handleChange(`|AUXILIAR_SERVICIO|${turno}`, Math.max(0, Number(e.target.value)))}
                      className="w-16 h-8 text-center mx-auto"
                      disabled={readonly}
                    />
                  </td>
                ))}
              </tr>
            </tbody>
          </table>
        </div>

        {!readonly && (
          <Button onClick={handleGuardar} disabled={updateMutation.isPending}>
            {updateMutation.isPending ? 'Guardando...' : 'Guardar dotación'}
          </Button>
        )}
      </CardContent>
    </Card>
  )
}
