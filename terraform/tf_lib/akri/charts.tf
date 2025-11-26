locals {
  repository = "https://project-akri.github.io/akri"
  chart_reference = "akri"
}

locals {
  chart_install_name = var.chart_install_name != null ? var.chart_install_name : local.chart_reference
}

resource "helm_release" "akri" {
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
      name  = "kubernetesDistro"
      value = var.kubernetes_distro
    },
    {
      name  = "controller.enabled"
      value = var.controller_enabled
    },
    {
      name  = "controller.image.repository"
      value = var.controller_image_repository
    },
    {
      name  = "controller.image.tag"
      value = var.controller_image_tag
    },
    {
      name  = "controller.image.pullPolicy"
      value = var.controller_image_pull_policy
    },
    {
      name = "agent.enabled"
      value = var.agent_enabled
    },
    {
      name  = "agent.image.repository"
      value = var.agent_image_repository
    },
    {
      name  = "agent.image.fullRepository"
      value = var.agent_image_full_repository
    },
    {
      name  = "agent.image.tag"
      value = var.agent_image_tag
    },
    {
      name  = "agent.image.pullPolicy"
      value = var.agent_image_pull_policy
    },
    {
      name  = "udev.configuration.enabled"
      value = var.udev_enabled
    },
    {
      name  = "udev.configuration.name"
      value = var.udev_instance_name
    },
    {
      name  = "udev.configuration.discoveryDetails.groupRecursive"
      value = var.udev_discovery_group_recursive
    },
    {
      name  = "udev.discovery.enabled"
      value = var.udev_discovery_enabled
    }
  ]
  set_list = [
    {
      name  = "udev.configuration.discoveryDetails.udevRules"
      values = var.udev_discovery_rules_list
    }
  ]
}
