'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { useLogin, useSetPassword } from '@/features/auth/hooks/use-auth'

type LoginStep = 'username' | 'password' | 'set-password'

export default function LoginPage() {
  const router = useRouter()
  const loginMutation = useLogin()
  const setPasswordMutation = useSetPassword()
  const [step, setStep] = useState<LoginStep>('username')
  const [username, setUsername] = useState('')
  const [error, setError] = useState('')

  function handleUsernameSubmit() {
    setError('')

    const usernameEl = document.getElementById('step-username') as HTMLInputElement | null
    const rawUsername = usernameEl?.value ?? ''

    if (!rawUsername.trim()) {
      setError('Ingrese su nombre de usuario')
      return
    }

    const normalized = rawUsername.trim()
    setUsername(normalized)

    loginMutation.mutate(
      { username: normalized, password: '' },
      {
        onSuccess: (result) => {
          if (result.requires_password) {
            setStep('set-password')
          } else if (result.must_change_password) {
            setStep('set-password')
          } else if (result.password_required) {
            setStep('password')
          } else {
            setError('Error inesperado')
          }
        },
        onError: () => {
          setError('Usuario no encontrado')
        },
      },
    )
  }

  function handlePasswordSubmit() {
    setError('')

    const passwordEl = document.getElementById('step-password') as HTMLInputElement | null
    const password = passwordEl?.value ?? ''

    if (!password) {
      setError('Ingrese su contraseña')
      return
    }

    loginMutation.mutate(
      { username, password },
      {
        onSuccess: (result) => {
          if (result.user) {
            router.replace('/planificaciones')
          } else {
            setError('Usuario o contraseña invalidos')
          }
        },
        onError: () => {
          setError('Usuario o contraseña invalidos')
        },
      },
    )
  }

  function handleSetPassword() {
    setError('')

    const passwordEl = document.getElementById('new-password') as HTMLInputElement | null
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

    setPasswordMutation.mutate(
      { username, password },
      {
        onSuccess: () => {
          router.replace('/planificaciones')
        },
        onError: () => {
          setError('Error al configurar la contraseña')
        },
      },
    )
  }

  function handleKeyDown(e: React.KeyboardEvent, handler: () => void) {
    if (e.key === 'Enter') handler()
  }

  return (
    <div className="min-h-screen grid place-items-center bg-muted/30 px-4">
      <Card className="w-full max-w-sm">
        <CardHeader>
          <CardTitle>Ingresar al portal</CardTitle>
          {step === 'set-password' && (
            <CardDescription>Ingrese su nueva contraseña para acceder al portal</CardDescription>
          )}
          {step === 'username' && (
            <CardDescription>Ingrese su usuario para continuar</CardDescription>
          )}
        </CardHeader>
        <CardContent>
          {step === 'username' && (
            <div className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="step-username">Usuario</Label>
                <Input
                  id="step-username"
                  placeholder="nombre.apellido"
                  autoComplete="username"
                  onKeyDown={(e) => handleKeyDown(e, handleUsernameSubmit)}
                />
              </div>

              {error && (
                <div className="rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
                  {error}
                </div>
              )}

              {loginMutation.isError && !error && (
                <div className="rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
                  Usuario no encontrado
                </div>
              )}

              <Button
                className="w-full"
                onClick={handleUsernameSubmit}
                disabled={loginMutation.isPending}
              >
                {loginMutation.isPending ? 'Verificando...' : 'Continuar'}
              </Button>
            </div>
          )}

          {step === 'password' && (
            <div className="space-y-4">
              <div className="mb-4 text-sm text-muted-foreground">
                Usuario: <span className="font-medium text-foreground">{username}</span>
              </div>

              <div className="space-y-2">
                <Label htmlFor="step-password">Contraseña</Label>
                <Input
                  id="step-password"
                  type="password"
                  autoComplete="current-password"
                  onKeyDown={(e) => handleKeyDown(e, handlePasswordSubmit)}
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

              <Button
                className="w-full"
                onClick={handlePasswordSubmit}
                disabled={loginMutation.isPending}
              >
                {loginMutation.isPending ? 'Ingresando...' : 'Ingresar'}
              </Button>

              <button
                className="w-full text-center text-sm text-muted-foreground underline"
                onClick={() => { setStep('username'); setError('') }}
              >
                Volver
              </button>
            </div>
          )}

          {step === 'set-password' && (
            <div className="space-y-4">
              <div className="mb-4 text-sm text-muted-foreground">
                Usuario: <span className="font-medium text-foreground">{username}</span>
              </div>

              <div className="space-y-2">
                <Label htmlFor="new-password">Nueva contraseña</Label>
                <Input id="new-password" type="password" autoComplete="new-password" />
              </div>
              <div className="space-y-2">
                <Label htmlFor="confirm-password">Confirmar contraseña</Label>
                <Input
                  id="confirm-password"
                  type="password"
                  autoComplete="new-password"
                  onKeyDown={(e) => handleKeyDown(e, handleSetPassword)}
                />
              </div>

              {error && (
                <div className="rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
                  {error}
                </div>
              )}

              {setPasswordMutation.isError && !error && (
                <div className="rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
                  Error al configurar la contraseña
                </div>
              )}

              <Button
                className="w-full"
                onClick={handleSetPassword}
                disabled={setPasswordMutation.isPending}
              >
                {setPasswordMutation.isPending ? 'Configurando...' : 'Configurar contraseña'}
              </Button>

              <button
                className="w-full text-center text-sm text-muted-foreground underline"
                onClick={() => { setStep('username'); setError('') }}
              >
                Volver
              </button>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  )
}
