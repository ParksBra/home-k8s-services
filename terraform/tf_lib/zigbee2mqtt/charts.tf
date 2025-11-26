locals {
  repository = "https://charts.zigbee2mqtt.io"
  chart_reference = "zigbee2mqtt"
}

locals {
  chart_install_name = var.chart_install_name != null ? var.chart_install_name : local.chart_reference
}

locals {
  tls_secret_name = "${local.chart_install_name}-ingress-tls"
}

resource "helm_release" "zigbee2mqtt" {
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
      name  = "zigbee2mqtt.mqtt.server"
      value = var.mqtt_broker_address
    },
    {
      name  = "zigbee2mqtt.mqtt.username"
      value = var.mqtt_broker_username
    },
    {
      name  = "zigbee2mqtt.serial.port"
      value = var.zigbee_serial_port
    },
    {
      name  = "ingress.enabled"
      value = var.ingress_enabled
    },
    {
      name  = "ingress.ingressClassName"
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
      name  = "ingress.hosts[0].paths[1].path"
      value = "/api"
    },
    {
      name  = "ingress.hosts[0].paths[1].pathType"
      value = "ImplementationSpecific"
    },
    {
      name  = "ingress.tls[0].secretName"
      value = local.tls_secret_name
    },
    {
      name  = "ingress.tls[0].hosts[0]"
      value = var.ingress_host_address
    }
  ]
  set_sensitive = [
    {
      name  = "zigbee2mqtt.mqtt.password"
      value = var.mqtt_broker_password
    }
  ]
}
