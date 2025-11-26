locals {
  repository = "http://pajikos.github.io/home-assistant-helm-chart"
  chart_reference = "home-assistant"
}

locals {
  chart_install_name = var.chart_install_name != null ? var.chart_install_name : local.chart_reference
}

locals {
  service_account_name       = "${local.chart_install_name}-sa"
  tls_secret_name            = "${local.chart_install_name}-ingress-tls"
  codeserver_tls_secret_name = "${local.chart_install_name}-codeserver-ingress-tls"
}

resource "helm_release" "home_assistant" {
  depends_on = [
    data.kubernetes_namespace.namespace
  ]

  name       = local.chart_install_name
  repository = local.repository
  chart      = local.chart_reference
  version    = var.chart_version

  namespace        = data.kubernetes_namespace.namespace.id
  create_namespace = false

  dependency_update = var.chart_dependency_update
  lint              = var.chart_linting_enabled
  recreate_pods     = var.chart_recreate_pods
  upgrade_install   = var.chart_upgrade_install
  replace           = var.chart_replace
  cleanup_on_fail   = var.chart_cleanup_on_fail

  set = [
    {
      name  = "image.repository"
      value = var.image_repository
    },
    {
      name  = "image.tag"
      value = var.image_tag
    },
    {
      name  = "image.pullPolicy"
      value = var.image_pull_policy
    },
    {
      name  = "service.type"
      value = var.service_type
    },
    {
      name  = "service.port"
      value = var.service_port
    },
    {
      name  = "persistence.enabled"
      value = var.data_storage_persistence_enabled
    },
    {
      name  = "persistence.storageClass"
      value = var.data_storage_class_name
    },
    {
      name  = "persistence.size"
      value = var.data_volume_size
    },
    {
      name  = "controller.type"
      value = "StatefulSet"
    },
    {
      name  = "hostNetwork"
      value = var.pod_host_network_enabled
    },
    {
      name  = "dnsPolicy"
      value = var.pod_dns_policy
    },
    {
      name  = "service.type"
      value = var.service_type
    },
    {
      name  = "service.port"
      value = var.service_port
    },
    {
      name  = "ingress.enabled"
      value = var.ingress_enabled
    },
    {
      name  = "ingress.className"
      value = var.ingress_class_name
    },
    {
      name  = "ingress.annotations"
      value = var.ingress_annotations
    },
    {
      name  = "ingress.hosts[0].host"
      value = var.ingress_host_address
    },
    {
      name  = "ingress.hosts[0].paths[0].path"
      value = "/"
    },
    {
      name  = "ingress.hosts[0].paths[0].pathType"
      value = "ImplementationSpecific"
    },
    {
      name  = "ingress.tls[0].secretName"
      value = local.tls_secret_name
    },
    {
      name  = "ingress.tls[0].hosts[0]"
      value = var.ingress_host_address
    },
    {
      name  = "deploymentStrategy"
      value = var.pod_update_strategy
    },
    {
      name  = "replicaCount"
      value = 1 # Always 1 for StatefulSet controller type
    },
    {
      name  = "addons.codeserver.enabled"
      value = var.codeserver_enabled
    },
    {
      name  = "addons.codeserver.image.repository"
      value = var.codeserver_image_repository
    },
    {
      name  = "addons.codeserver.image.tag"
      value = var.codeserver_image_tag
    },
    {
      name  = "addons.codeserver.image.pullPolicy"
      value = var.codeserver_image_pull_policy
    },
    {
      name  = "addons.codeserver.auth.enabled"
      value = var.codeserver_auth_enabled
    },
    {
      name  = "addons.codeserver.auth.existingSecret"
      value = var.codeserver_auth_enabled ? kubernetes_secret.codeserver_password_secret[0].id : null
    },
    {
      name  = "addons.codeserver.service.type"
      value = var.codeserver_service_type
    },
    {
      name  = "addons.codeserver.service.port"
      value = var.codeserver_service_port
    },
    {
      name  = "addons.codeserver.ingress.enabled"
      value = var.codeserver_ingress_enabled
    },
    {
      name  = "addons.codeserver.ingress.className"
      value = var.codeserver_ingress_class_name
    },
    {
      name  = "addons.codeserver.ingress.annotations"
      value = var.codeserver_ingress_annotations
    },
    {
      name  = "addons.codeserver.ingress.hosts[0].host"
      value = var.codeserver_ingress_host_address
    },
    {
      name  = "addons.codeserver.ingress.hosts[0].paths[0].path"
      value = "/"
    },
    {
      name  = "addons.codeserver.ingress.hosts[0].paths[0].pathType"
      value = "ImplementationSpecific"
    },
    {
      name  = "addons.codeserver.ingress.tls[0].secretName"
      value = local.codeserver_tls_secret_name
    },
    {
      name  = "addons.codeserver.ingress.tls[0].hosts[0]"
      value = var.codeserver_ingress_host_address
    },
  ]
}
