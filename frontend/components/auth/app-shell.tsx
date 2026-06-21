'use client'

import Link from 'next/link'
import { usePathname, useRouter } from 'next/navigation'
import { useEffect, useRef, useState, type ReactNode } from 'react'
import { CalendarDays, ChevronDown, LogOut, Repeat, Stethoscope, User, Users } from 'lucide-react'
import { useLogout, useMe } from '@/features/auth/hooks/use-auth'
import { cn } from '@/lib/utils'

const publicPaths = ['/login']
const topbarHeightClass = 'h-14'
const sidebarCollapsedWidth = 'w-[3.5rem]'
const sidebarReserveWidth = 'pl-44'
const contentRightReserveWidth = 'pr-44'
const sidebarTopOffsetClass = 'top-14'
const sidebarHeightClass = 'h-[calc(100vh-3.5rem)]'
const navItems = [
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
  const visibleNavItems = navItems.filter((item) => !item.roles || item.roles.includes(user?.role ?? ''))

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
      <div className="min-h-screen grid place-items-center text-sm text-muted-foreground">
        Cargando sesion...
      </div>
    )
  }

  if (isPublic) {
    return (
      <main className="min-h-screen">
        {children}
      </main>
    )
  }

  if (!user) {
    return null
  }

  return (
    <div className="min-h-screen bg-muted/30">
      <header className="fixed inset-x-0 top-0 z-30 border-b bg-background/95 backdrop-blur">
        <div className={cn('flex items-center justify-between gap-4 px-4 sm:px-5', topbarHeightClass)}>
          <Link href="/planificaciones" className="truncate text-sm font-semibold">
            Nurse Portal
          </Link>

          <div className="relative shrink-0" ref={userMenuRef}>
            <button
              type="button"
              onClick={() => setIsUserMenuOpen((current) => !current)}
              className="flex items-center gap-2 rounded-full border bg-background px-3 py-1.5 text-xs font-medium shadow-sm transition-colors hover:bg-muted"
            >
              <span>{user.username}</span>
              <ChevronDown className={cn('size-3.5 transition-transform', isUserMenuOpen && 'rotate-180')} />
            </button>

            {isUserMenuOpen && (
              <div className="absolute right-0 top-full mt-2 w-44 rounded-2xl border bg-popover p-2 text-popover-foreground shadow-lg">
                <Link
                  href="/profile"
                  onClick={() => setIsUserMenuOpen(false)}
                  className="flex items-center gap-2 rounded-xl px-3 py-2 text-xs transition-colors hover:bg-accent hover:text-accent-foreground"
                >
                  <User className="size-3.5" />
                  Mi perfil
                </Link>
                <button
                  type="button"
                  onClick={handleLogout}
                  disabled={logoutMutation.isPending}
                  className="flex w-full items-center gap-2 rounded-xl px-3 py-2 text-left text-xs text-destructive transition-colors hover:bg-accent disabled:opacity-60"
                >
                  <LogOut className="size-3.5" />
                  {logoutMutation.isPending ? 'Saliendo...' : 'Salir'}
                </button>
              </div>
            )}
          </div>
        </div>
      </header>

      <div className={cn('relative min-h-screen pt-14', sidebarReserveWidth, contentRightReserveWidth)}>
        <aside
          className={cn(
            'group fixed left-0 z-20 transition-[width] duration-300 ease-out hover:w-44',
            sidebarCollapsedWidth,
            sidebarTopOffsetClass
          )}
        >
          <div className={cn('flex flex-col overflow-hidden border-r border-sidebar-border bg-sidebar text-sidebar-foreground shadow-sm', sidebarHeightClass)}>
            <nav className="flex-1 px-1.5 py-2">
              <ul className="space-y-1.5">
                {visibleNavItems.map((item) => {
                  const isActive = pathname === item.href || pathname.startsWith(`${item.href}/`)
                  const Icon = item.icon

                  return (
                    <li key={item.href}>
                      <Link
                        href={item.href}
                        className={cn(
                          'flex h-9 items-center gap-2 rounded-xl px-2 text-[0.78rem] font-medium transition-all duration-200',
                          'hover:bg-sidebar-accent hover:text-sidebar-accent-foreground',
                          isActive && 'bg-sidebar-primary text-sidebar-primary-foreground hover:bg-sidebar-primary hover:text-sidebar-primary-foreground'
                        )}
                        title={item.label}
                      >
                        <span className="flex w-7 shrink-0 justify-center">
                          <Icon className="size-3.5 shrink-0" />
                        </span>
                        <span className="block min-w-[5.75rem] whitespace-nowrap opacity-0 transition-opacity duration-200 group-hover:opacity-100">
                          {item.label}
                        </span>
                      </Link>
                    </li>
                  )
                })}
              </ul>
            </nav>
          </div>
        </aside>

        <main className="min-w-0 px-3 py-4 sm:px-4 sm:py-5">
          {children}
        </main>
      </div>
    </div>
  )
}
