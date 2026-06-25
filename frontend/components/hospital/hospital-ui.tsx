import type { ReactNode } from 'react'

export type StatItem = {
  label: string
  value: string | number
  highlight?: boolean
}

export function PageHeader({
  title,
  subtitle,
  actions,
}: {
  title: string
  subtitle?: string
  actions?: ReactNode
}) {
  return (
    <div className="np-page-header">
      <div>
        <h1 className="np-page-title">{title}</h1>
        {subtitle && <p className="np-page-kicker">{subtitle}</p>}
      </div>
      {actions && <div className="np-page-actions">{actions}</div>}
    </div>
  )
}

export function StatsGrid({ items }: { items: StatItem[] }) {
  return (
    <div className="np-stats-grid">
      {items.map((item) => (
        <div key={item.label} className={item.highlight ? 'np-stat-card highlight' : 'np-stat-card'}>
          <div className="np-stat-value">{item.value}</div>
          <div className="np-stat-label">{item.label}</div>
        </div>
      ))}
    </div>
  )
}

export function StatusBadge({
  children,
  tone = 'accent',
}: {
  children: ReactNode
  tone?: 'accent' | 'success' | 'warn' | 'danger'
}) {
  return <span className={`np-badge np-badge-${tone}`}>{children}</span>
}

export function Card({
  title,
  actions,
  children,
  className = '',
}: {
  title?: string
  actions?: ReactNode
  children: ReactNode
  className?: string
}) {
  return (
    <section className={`np-card ${className}`}>
      {(title || actions) && (
        <div className="np-card-header">
          {title ? <h2 className="np-card-title">{title}</h2> : <span />}
          {actions}
        </div>
      )}
      <div className="np-card-body">{children}</div>
    </section>
  )
}

export function EmptyState({ children }: { children: ReactNode }) {
  return <div className="np-empty">{children}</div>
}

export function initials(nombre?: string, apellido?: string) {
  const first = nombre?.trim().charAt(0) ?? ''
  const last = apellido?.trim().charAt(0) ?? ''
  return `${first}${last}`.toUpperCase() || 'NP'
}

export function fullName(employee?: { nombre: string; apellido: string }) {
  if (!employee) return 'Empleado no disponible'
  return `${employee.apellido}, ${employee.nombre}`
}

export function daysBetween(start?: string, end?: string) {
  if (!start || !end) return 0
  const startDate = new Date(`${start}T00:00:00`)
  const endDate = new Date(`${end}T00:00:00`)
  const diff = Math.round((endDate.getTime() - startDate.getTime()) / 86_400_000)
  return Math.max(diff + 1, 0)
}

export function todayIso() {
  return new Date().toISOString().slice(0, 10)
}

export function isDateInRange(date: string, start: string, end: string) {
  return date >= start && date <= end
}
