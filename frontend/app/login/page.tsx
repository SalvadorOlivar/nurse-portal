'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { useLogin } from '@/features/auth/hooks/use-auth'

export default function LoginPage() {
  const router = useRouter()
  const loginMutation = useLogin()
  const [error, setError] = useState('')

  async function handleLogin() {
    setError('')

    const usernameEl = document.getElementById('username') as HTMLInputElement | null
    const passwordEl = document.getElementById('password') as HTMLInputElement | null
    const rawUsername = usernameEl?.value ?? ''
    const rawPassword = passwordEl?.value ?? ''

    if (!rawUsername.trim() || !rawPassword) {
      setError('Ingrese usuario y contraseña')
      return
    }

    try {
      const result = await loginMutation.mutateAsync({ username: rawUsername.trim(), password: rawPassword })
      if (result.requires_password) {
        router.replace(`/set-password?username=${encodeURIComponent(result.username ?? rawUsername.trim())}`)
        return
      }
      if (result.password_required) {
        setError('Usuario o contraseña invalidos')
        return
      }
      router.replace('/planificaciones')
    } catch {
      setError('Usuario o contraseña invalidos')
    }
  }

  return (
    <div className="min-h-screen grid place-items-center bg-muted/30 px-4">
      <Card className="w-full max-w-sm">
        <CardHeader>
          <CardTitle>Ingresar al portal</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="username">Usuario</Label>
              <Input
                id="username"
                placeholder="nombre.apellido"
                autoComplete="username"
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="password">Contraseña</Label>
              <Input
                id="password"
                type="password"
                autoComplete="current-password"
              />
            </div>
            {error && (
              <div className="rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
                {error}
              </div>
            )}
            {loginMutation.isError && !error && (
              <div className="rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
                Usuario o contraseña invalidos
              </div>
            )}
            <Button className="w-full" onClick={handleLogin} disabled={loginMutation.isPending}>
              {loginMutation.isPending ? 'Ingresando...' : 'Ingresar'}
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
