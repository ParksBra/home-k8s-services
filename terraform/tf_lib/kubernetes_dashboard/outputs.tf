output "namespace" {
  description = "The namespace ID where Kubernetes Dashboard is deployed."
  value       = data.kubernetes_namespace.namespace.id
}

output "id" {
  description = "The Helm release ID for Kubernetes Dashboard."
  value       = helm_release.kubernetes_dashboard.id
}

output "chart_reference" {
  description = "The Helm chart reference for Kubernetes Dashboard."
  value       = local.chart_reference
}

output "service_address" {
  description = "The address of the Kubernetes Dashboard service."
  value       = "${helm_release.kubernetes_dashboard.id}.${data.kubernetes_namespace.namespace.id}.svc"
}
