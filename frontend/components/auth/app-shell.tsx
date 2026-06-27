'use client'

import Link from 'next/link'
import { usePathname, useRouter } from 'next/navigation'
import { useEffect, useRef, useState, type ReactNode } from 'react'
import {
  CalendarDays,
  LogOut,
  Repeat,
  Stethoscope,
  Users,
} from 'lucide-react'
import { useLogout, useMe } from '@/features/auth/hooks/use-auth'
import { cn } from '@/lib/utils'

const publicPaths = ['/login']

const primaryNav = [
  { href: '/planificaciones', label: 'Planificaciones', icon: CalendarDays },
  { href: '/employees', label: 'Empleados', icon: Users, roles: ['ADMIN', 'SUPERVISOR'] },
  { href: '/intercambio', label: 'Intercambios', icon: Repeat },
  { href: '/leave-requests', label: 'Licencias', icon: Stethoscope },
] as const

export function AppShell({ children }: { children: ReactNode }) {
  const pathname = usePathname()
  const router = useRouter()
  const isPublic = publicPaths.includes(pathname)
  const { data, isLoading, isError } = useMe()
  const logoutMutation = useLogout()
  const [isUserMenuOpen, setIsUserMenuOpen] = useState(false)
  const userMenuRef = useRef<HTMLDivElement>(null)
  const user = data?.user

  const role = user?.role
  const visiblePrimary = primaryNav.filter((item) => !('roles' in item) || (!!role && item.roles.some((allowed) => allowed === role)))

  useEffect(() => {
    if (!isPublic && isError) {
      router.replace('/login')
    }
  }, [isError, isPublic, router])

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (userMenuRef.current && !userMenuRef.current.contains(event.target as Node)) {
        setIsUserMenuOpen(false)
      }
    }

    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  async function handleLogout() {
    setIsUserMenuOpen(false)
    await logoutMutation.mutateAsync()
    router.replace('/login')
  }

  if (!isPublic && isLoading) {
    return (
      <div className="grid min-h-screen place-items-center text-sm text-muted-foreground">
        Cargando sesion...
      </div>
    )
  }

  if (isPublic) {
    return <main className="min-h-screen">{children}</main>
  }

  if (!user) {
    return null
  }

  const dateStr = new Date().toLocaleDateString('es-ES', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })
    .replace(/^\w/, (c) => c.toUpperCase())
  const avatarInitials = user.username.slice(0, 2).toUpperCase()

  return (
    <div className="min-h-screen bg-[var(--bg)]">
      <header className="np-topbar">
        <div className="np-topbar-inner">
          <Link href="/planificaciones" className="flex items-center gap-[10px] text-sm font-semibold text-[var(--fg)] no-underline">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-[var(--accent)] shrink-0">
              <path d="M22 12h-4l-3 9L9 3l-3 9H2"/>
            </svg>
            Gestión de Turnos
          </Link>

          <div className="flex items-center gap-5">
            <span className="text-[0.85rem] text-[var(--muted-foreground)] pr-4 border-r border-[var(--border)] leading-none">
              {dateStr}
            </span>
            <div className="relative" ref={userMenuRef}>
              <button
                type="button"
                onClick={() => setIsUserMenuOpen((current) => !current)}
                className="flex items-center gap-[10px] text-[0.875rem] text-[var(--muted-foreground)] bg-none border-none cursor-pointer font-inherit"
                aria-expanded={isUserMenuOpen}
                aria-haspopup="menu"
              >
                <span>{user.username}</span>
                <div className="w-[34px] h-[34px] rounded-full bg-[var(--accent-light)] text-[var(--accent-dark)] flex items-center justify-center font-semibold text-[0.8rem]">
                  {avatarInitials}
                </div>
              </button>

              {isUserMenuOpen && (
                <div className="absolute right-0 top-full mt-2 w-48 rounded-[var(--radius)] border border-[var(--border)] bg-[var(--surface)] p-2 text-sm shadow-[var(--shadow-md)]">
                  <button
                    type="button"
                    onClick={handleLogout}
                    disabled={logoutMutation.isPending}
                    className="flex w-full items-center gap-2 rounded-[var(--radius-sm)] px-3 py-2 text-left text-[0.82rem] text-[var(--danger)] hover:bg-[color-mix(in_srgb,var(--danger)_8%,transparent)] disabled:opacity-60"
                  >
                    <LogOut className="size-4" />
                    {logoutMutation.isPending ? 'Saliendo...' : 'Salir'}
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>
      </header>

      <aside className="np-sidebar" aria-label="Navegacion principal">
        <div className="np-sidebar-inner">
          <nav className="np-nav-section">
            <p className="np-nav-label">Principal</p>
            <div className="np-nav-list">
              {visiblePrimary.map((item) => (
                <NavItem key={item.href} href={item.href} label={item.label} icon={item.icon} pathname={pathname} />
              ))}
            </div>
          </nav>

        </div>
      </aside>

      <div className="np-app-layout">
        <main className="np-main">{children}</main>
      </div>
    </div>
  )
}

function NavItem({
  href,
  label,
  icon: Icon,
  pathname,
}: {
  href: string
  label: string
  icon: React.ElementType
  pathname: string
}) {
  const isActive = pathname === href || pathname.startsWith(`${href}/`)

  return (
    <Link href={href} className={cn('np-nav-item', isActive && 'active')} aria-current={isActive ? 'page' : undefined}>
      <Icon aria-hidden="true" />
      <span>{label}</span>
    </Link>
  )
}
