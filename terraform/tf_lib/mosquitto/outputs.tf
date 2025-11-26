output "namespace_id" {
  description = "The namespace ID where Mosquitto is deployed."
  value       = data.kubernetes_namespace.namespace.id
}

output "id" {
  description = "The Helm release ID for Mosquitto."
  value       = helm_release.mosquitto.id
}

output "chart_reference" {
  description = "The Helm chart reference for Mosquitto."
  value       = local.chart_reference
}

output "service_address" {
  description = "The address of the Mosquitto service."
  value       = "${helm_release.mosquitto.id}.${data.kubernetes_namespace.namespace.id}.svc"
}

output "mqtt_port" {
  description = "The MQTT port exposed by the Mosquitto service."
  value       = var.mqtt_port
}

output "websocket_port" {
  description = "The WebSocket port exposed by the Mosquitto service."
  value       = var.websocket_port
}

output "admin_username" {
  description = "The admin username for Mosquitto."
  value       = var.admin_username
}

output "admin_password" {
  description = "The admin password for Mosquitto."
  value       = var.admin_password
  sensitive   = true
}
