output "namespace_id" {
  description = "The namespace in which Akri is deployed."
  value       = data.kubernetes_namespace.namespace.id
}

output "id" {
  description = "The Helm release ID for Akri."
  value       = helm_release.akri.id
}

output "chart_reference" {
  description = "The Helm chart reference for Akri."
  value       = local.chart_reference
}

output "controller_enabled" {
  description = "Whether the Akri controller is enabled."
  value       = var.controller_enabled
}

output "agent_enabled" {
  description = "Whether the Akri agent is enabled."
  value       = var.agent_enabled
}

output "udev_enabled" {
  description = "Whether UDEV configuration is enabled in Akri."
  value       = var.udev_enabled
}

output "udev_instance_name" {
  description = "The name of the UDEV instance configured in Akri."
  value       = var.udev_instance_name
}
