output "dr_plan" {
  value = var.dr_plan == null ? null : oci_disaster_recovery_dr_plan.dr_plan[0]
}

output "dr_plan_execution" {
  value = var.dr_plan_execution == null ? null : oci_disaster_recovery_dr_plan_execution.dr_plan_execution[0]
}