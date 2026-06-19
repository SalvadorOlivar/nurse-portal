'use client'

import { useState, Suspense } from 'react'
import { useRouter, useSearchParams } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { useSetPassword } from '@/features/auth/hooks/use-auth'

function SetPasswordForm() {
  const router = useRouter()
  const searchParams = useSearchParams()
  const username = searchParams.get('username') ?? ''
  const setPasswordMutation = useSetPassword()
  const [error, setError] = useState('')

  async function handleSetPassword() {
    setError('')

    const passwordEl = document.getElementById('password') as HTMLInputElement | null
    const confirmEl = document.getElementById('confirm-password') as HTMLInputElement | null
    const password = passwordEl?.value ?? ''
    const confirm = confirmEl?.value ?? ''

    if (!password) {
      setError('Ingrese una contraseña')
      return
    }

    if (password.length < 8) {
      setError('La contraseña debe tener al menos 8 caracteres')
      return
    }

    if (password !== confirm) {
      setError('Las contraseñas no coinciden')
      return
    }

    try {
      await setPasswordMutation.mutateAsync({ username, password })
      router.replace('/planificaciones')
    } catch {
      setError('Error al configurar la contraseña')
    }
  }

  if (!username) {
    return (
      <div className="rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
        Usuario no especificado. Vaya a{' '}
        <a href="/login" className="underline">
          iniciar sesión
        </a>
        .
      </div>
    )
  }

  return (
    <>
      <div className="mb-4 text-sm text-muted-foreground">
        Usuario: <span className="font-medium text-foreground">{username}</span>
      </div>

      {error && (
        <div className="mb-4 rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
          {error}
        </div>
      )}

      {setPasswordMutation.isError && !error && (
        <div className="mb-4 rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
          Error al configurar la contraseña
        </div>
      )}

      <div className="space-y-4">
        <div className="space-y-2">
          <Label htmlFor="password">Nueva contraseña</Label>
          <Input id="password" type="password" autoComplete="new-password" />
        </div>
        <div className="space-y-2">
          <Label htmlFor="confirm-password">Confirmar contraseña</Label>
          <Input id="confirm-password" type="password" autoComplete="new-password" />
        </div>
        <Button className="w-full" onClick={handleSetPassword} disabled={setPasswordMutation.isPending}>
          {setPasswordMutation.isPending ? 'Configurando...' : 'Configurar contraseña'}
        </Button>
      </div>
    </>
  )
}

export default function SetPasswordPage() {
  return (
    <div className="min-h-screen grid place-items-center bg-muted/30 px-4">
      <Card className="w-full max-w-sm">
        <CardHeader>
          <CardTitle>Configurar contraseña</CardTitle>
          <CardDescription>Ingrese su nueva contraseña para acceder al portal</CardDescription>
        </CardHeader>
        <CardContent>
          <Suspense fallback={<div>Cargando...</div>}>
            <SetPasswordForm />
          </Suspense>
        </CardContent>
      </Card>
    </div>
  )
}
