import { Suspense } from 'react'
import { EmployeeDetail } from '@/components/employees/employee-detail'

export default async function EmployeeDetailPage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params

  return (
    <Suspense fallback={<div className="text-center py-8 text-muted-foreground">Cargando...</div>}>
      <EmployeeDetail id={id} />
    </Suspense>
  )
}
