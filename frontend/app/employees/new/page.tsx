import { EmployeeForm } from '@/components/employees/employee-form'

export default function NewEmployeePage() {
  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold">Nuevo empleado</h1>
      <EmployeeForm />
    </div>
  )
}
