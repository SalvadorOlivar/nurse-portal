import Link from "next/link";

export default function SchedulesPage() {
  return (
    <div className="flex flex-col items-center justify-center min-h-[40vh] text-center gap-4">
      <h1 className="text-2xl font-bold">Planificaciones</h1>
      <p className="text-muted-foreground">
        Esta funcionalidad estará disponible en la próxima iteración.
      </p>
      <Link
        href="/"
        className="text-sm text-primary hover:underline"
      >
        Volver al inicio
      </Link>
    </div>
  )
}
