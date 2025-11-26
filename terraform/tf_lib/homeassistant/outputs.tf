output "namespace_id" {
  description = "The namespace ID in which Home Assistant is deployed."
  value       = data.kubernetes_namespace.namespace.id
}

output "id" {
  description = "The Helm release ID for Home Assistant."
  value       = helm_release.home_assistant.id
}

output "service_address" {
  description = "The address of the Home Assistant service."
  value       = "${helm_release.home_assistant.id}.${data.kubernetes_namespace.namespace.id}.svc"
}

output "codeserver_enabled" {
  description = "Whether the Home Assistant code server is enabled."
  value       = var.codeserver_enabled
}

output "codeserver_password_generated" {
  description = "Whether the Home Assistant code server password was generated."
  value       = local.codeserver_generate_password
}

output "codeserver_password" {
  description = "The password for the Home Assistant code server."
  value       = local.codeserver_password
  sensitive   = true
}

output "codeserver_service_address" {
  description = "The address of the Home Assistant code server service."
  value       = "${helm_release.codeserver.id}-codeserver.${data.kubernetes_namespace.namespace.id}.svc"
}
