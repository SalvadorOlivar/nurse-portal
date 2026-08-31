# Diagrama de Arquitectura - Nurse Portal

## Versión Detallada

```mermaid
flowchart TB
  %% Diagrama de Arquitectura - Nurse Portal

  subgraph Frontend["Frontend - Next.js / React"]
    subgraph Pages["Pages - App Router"]
      login["login"]
      planificaciones["planificaciones"]
      planificacionId["planificacion/[id]"]
      employees["employees"]
      employeeId["employees/[id]"]
      employeeNew["employees/new"]
      intercambio["intercambio"]
      intercambioNew["intercambio/new"]
      leaveRequests["leave-requests"]
      leaveRequestsNew["leave-requests/new"]
      schedules["schedules"]
      profile["profile"]
    end

    subgraph Components["Components"]
      appShell["AppShell"]
      planifComponents["Planificacion Components"]
      employeeComponents["Employee Components"]
      ausenciaComponents["Ausencia Components"]
      intercambioComponents["Intercambio Components"]
      uiPrimitives["UI Primitives - shadcn/ui"]
    end

    subgraph Features["Features - React Query Hooks"]
      useAuth["use-auth"]
      usePlanificaciones["use-planificaciones"]
      useEmployees["use-employees"]
      useAusencia["use-ausencia"]
      useIntercambio["use-intercambio"]
    end

    subgraph ApiLayer["API Client Layer"]
      apiClient["api/client.ts"]
      apiAuth["auth.ts"]
      apiEmployees["employees.ts"]
      apiPlanificaciones["planificaciones.ts"]
      apiAusencia["ausencia.ts"]
      apiIntercambio["intercambio.ts"]
    end

    Types["TypeScript Interfaces"]
  end

  subgraph Backend["Backend - Go Hexagonal"]
    subgraph HTTPAdapter["HTTP Adapter"]
      router["chi Router /api/v1"]
      authRoutes["Auth Route Registrar"]
      employeeRoutes["Employee Route Registrar"]
      planifRoutes["Planificacion Route Registrar"]
      ausenciaRoutes["Ausencia Route Registrar"]
      intercambioRoutes["Intercambio Route Registrar"]
      authMiddleware["Auth Middleware"]
      authHandler["Auth Handler"]
      employeeHandler["Employee Handler"]
      planifHandler["Planificacion Handler"]
      ausenciaHandler["Ausencia Handler"]
      intercambioHandler["Intercambio Handler"]
    end

    subgraph Application["Application Layer"]
      subgraph Services["Services"]
        authService["Auth Service"]
        employeeService["Employee Service"]
        planifService["Planificacion Service"]
        ausenciaService["Ausencia Service"]
        intercambioService["Intercambio Service"]
      end

      subgraph Commands["Commands - CQRS"]
        cmdEmployee["Employee Commands"]
        cmdPlanif["Planificacion Commands"]
        cmdTurno["Turno Commands"]
        cmdLeave["Leave Commands"]
        cmdIntercambio["Intercambio Commands"]
        cmdCompensatory["Compensatory Commands"]
      end

      subgraph Queries["Queries - CQRS"]
        qryPlanif["Planificacion Queries"]
        qryLeave["Leave Queries"]
        qryIntercambio["Intercambio Queries"]
        qryCompensatory["Compensatory Queries"]
      end
    end

    subgraph Domain["Domain - Core"]
      domainEmployee["Employee"]
      domainPlanif["Planificacion"]
      domainTurno["Turno"]
      domainAusencia["Ausencia"]
      domainIntercambio["Intercambio"]
      domainAuth["Auth"]
    end

    Repos["Repository Interfaces"]

    subgraph PostgreSQLAdapter["PostgreSQL Adapter"]
      pgEmployee["Employee Repo"]
      pgPlanif["Planificacion Repo"]
      pgTurno["Turno Repo"]
      pgDotacion["Dotacion Repo"]
      pgLeave["Leave Repo"]
      pgCompensatory["Compensatory Repo"]
      pgIntercambio["Intercambio Repo"]
      pgAuth["Auth Repo"]
    end
  end

  Database["PostgreSQL 16"]

  login --> appShell
  planificaciones --> appShell
  planificacionId --> appShell
  employees --> appShell
  employeeId --> appShell
  employeeNew --> appShell
  intercambio --> appShell
  intercambioNew --> appShell
  leaveRequests --> appShell
  leaveRequestsNew --> appShell
  schedules --> appShell
  profile --> appShell

  appShell --> planifComponents
  appShell --> employeeComponents
  appShell --> ausenciaComponents
  appShell --> intercambioComponents
  appShell --> uiPrimitives

  planifComponents --> usePlanificaciones
  employeeComponents --> useEmployees
  ausenciaComponents --> useAusencia
  intercambioComponents --> useIntercambio
  appShell --> useAuth

  useAuth --> apiAuth
  usePlanificaciones --> apiPlanificaciones
  useEmployees --> apiEmployees
  useAusencia --> apiAusencia
  useIntercambio --> apiIntercambio

  apiAuth --> apiClient
  apiEmployees --> apiClient
  apiPlanificaciones --> apiClient
  apiAusencia --> apiClient
  apiIntercambio --> apiClient

  planifComponents --> Types
  employeeComponents --> Types
  ausenciaComponents --> Types
  intercambioComponents --> Types

  apiClient --> router
  router --> authRoutes
  router --> employeeRoutes
  router --> planifRoutes
  router --> ausenciaRoutes
  router --> intercambioRoutes

  authRoutes --> authMiddleware
  employeeRoutes --> authMiddleware
  planifRoutes --> authMiddleware
  ausenciaRoutes --> authMiddleware
  intercambioRoutes --> authMiddleware

  authRoutes --> authHandler
  employeeRoutes --> employeeHandler
  planifRoutes --> planifHandler
  ausenciaRoutes --> ausenciaHandler
  intercambioRoutes --> intercambioHandler

  authMiddleware --> authService
  authHandler --> authService
  employeeHandler --> employeeService
  planifHandler --> planifService
  ausenciaHandler --> ausenciaService
  intercambioHandler --> intercambioService

  authService --> domainAuth
  employeeService --> domainEmployee
  planifService --> domainPlanif
  planifService --> domainTurno
  ausenciaService --> domainAusencia
  intercambioService --> domainIntercambio

  employeeService --> cmdEmployee
  planifService --> cmdPlanif
  planifService --> cmdTurno
  ausenciaService --> cmdLeave
  ausenciaService --> cmdCompensatory
  intercambioService --> cmdIntercambio

  planifService --> qryPlanif
  ausenciaService --> qryLeave
  ausenciaService --> qryCompensatory
  intercambioService --> qryIntercambio

  cmdEmployee --> Repos
  cmdPlanif --> Repos
  cmdTurno --> Repos
  cmdLeave --> Repos
  cmdCompensatory --> Repos
  cmdIntercambio --> Repos
  qryPlanif --> Repos
  qryLeave --> Repos
  qryCompensatory --> Repos
  qryIntercambio --> Repos

  Repos --> pgEmployee
  Repos --> pgPlanif
  Repos --> pgTurno
  Repos --> pgDotacion
  Repos --> pgLeave
  Repos --> pgCompensatory
  Repos --> pgIntercambio
  Repos --> pgAuth

  pgEmployee --> Database
  pgPlanif --> Database
  pgTurno --> Database
  pgDotacion --> Database
  pgLeave --> Database
  pgCompensatory --> Database
  pgIntercambio --> Database
  pgAuth --> Database
```

## Versión Compacta

```mermaid
flowchart TB
  %% Nurse Portal - Arquitectura Lógica

  subgraph Frontend["Frontend"]
    pages["App Router Pages"]
    components["React Components"]
    hooks["React Query Hooks"]
    apiClient["API Client Layer"]
    types["TypeScript Types"]
  end

  subgraph Backend["Backend"]
    router["chi Router /api/v1"]
    routeRegistrars["Route Registrars"]
    handlers["HTTP Handlers"]
    middleware["Auth Middleware"]

    subgraph Application["Application"]
      services["Services"]

      subgraph CQRS["CQRS"]
        cmds["Commands"]
        qrys["Queries"]
      end
    end

    domain["Domain Entities"]
    ports["Repository Ports"]
    repos["PostgreSQL Repos"]
  end

  subgraph DB["DB"]
    db["PostgreSQL 16"]
  end

  pages --> components
  components --> hooks
  components --> types
  hooks --> apiClient
  apiClient --> router
  router --> routeRegistrars
  routeRegistrars --> middleware
  routeRegistrars --> handlers

  handlers --> services

  services --> cmds
  services --> qrys
  services --> domain

  cmds --> domain
  qrys --> domain
  cmds --> ports
  qrys --> ports

  ports --> repos
  repos --> db
```

## Notas de implementación

### Backend HTTP — Registro modular de rutas
- `router.go` configura el router `chi`, los middleware globales y el prefijo `/api/v1`.
- `RouteRegistrar` define el contrato `RegisterRoutes(chi.Router)` usado para incorporar módulos HTTP sin ampliar la firma de `NewRouter`.
- Cada módulo (`auth`, `employees`, `planificaciones`, `ausencia` e `intercambio`) encapsula el registro de sus endpoints, su handler y el middleware de autenticación/autorización correspondiente en un archivo `*_routes.go`.
- `cmd/api/main.go` actúa como composition root: construye repositorios, servicios, handlers y registradores, y entrega estos últimos a `NewRouter`.

### Planificaciones — Listado agrupado
- `PlanificacionService.List()` auto-cierra (`PUBLICADO → CERRADO`) planificaciones cuya semana ya venció antes de retornar la lista.
- El frontend (`planificacion-list.tsx`) clasifica las planificaciones en:
  - **Actual**: la de la semana vigente con `estado === PUBLICADO` (destacada como card principal).
  - **Próximas**: futuras dentro del próximo mes (collapsible, expandido por defecto).
  - **Recientes**: pasadas del último mes (collapsible, expandido por defecto).
  - **Anteriores**: el resto (collapsible, cerrado por defecto).
- Cada sección agrupa por mes usando `getMonthFromWeek()` de `lib/utils.ts`.
- `CollapsibleSection` (`components/ui/collapsible-section.tsx`) es un toggle reutilizable con icono chevron y contador.
- `isoWeekToDate()`, `getWeekRange()`, `getMonthFromWeek()` residen en `lib/utils.ts` (extraídas de componentes duplicados).
