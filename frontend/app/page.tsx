import Link from "next/link";

export default function Home() {
  return (
    <div className="flex flex-col items-center justify-center min-h-[60vh] text-center gap-6">
      <h1 className="text-4xl font-bold">Nursery Portal</h1>
      <p className="text-muted-foreground max-w-md">
        Sistema de gestión de turnos para el personal de enfermería
      </p>
      <div className="flex gap-4">
        <Link
          href="/employees"
          className="inline-flex items-center justify-center rounded-md bg-primary px-6 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 transition-colors"
        >
          Gestionar Empleados
        </Link>
        <Link
          href="/schedules"
          className="inline-flex items-center justify-center rounded-md border border-input bg-background px-6 py-2 text-sm font-medium hover:bg-accent transition-colors"
        >
          Planificaciones
        </Link>
      </div>
    </div>
  );
}
