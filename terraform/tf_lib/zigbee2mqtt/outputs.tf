output "namespace" {
  description = "The namespace where Zigbee2MQTT is deployed."
  value       = local.namespace
}

output "name" {
  description = "The name used to install the Zigbee2MQTT Helm chart."
  value       = local.chart_install_name
}

output "chart_reference" {
  description = "The Helm chart reference for Zigbee2MQTT."
  value       = local.chart_reference
}

output "service_address" {
  description = "The address of the Zigbee2MQTT service."
  value       = "${local.chart_install_name}.${local.namespace}.svc"
}

output "tls_secret_name" {
  description = "The name of the TLS secret used for Zigbee2MQTT ingress."
  value       = local.tls_secret_name
}
