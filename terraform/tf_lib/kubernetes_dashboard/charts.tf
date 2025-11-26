locals {
  repository = "https://kubernetes.github.io/dashboard"
  chart_reference = "kubernetes-dashboard"
}

locals {
  chart_install_name = var.chart_install_name != null ? var.chart_install_name : local.chart_reference
}

locals {
  tls_secret_name = "${local.chart_install_name}-ingress-tls"
}

resource "helm_release" "kubernetes_dashboard" {
  depends_on = [
    data.kubernetes_namespace.namespace
  ]
  name       = local.chart_install_name
  repository = local.repository
  chart      = local.chart_reference

  namespace = data.kubernetes_namespace.namespace.id
  version  = var.chart_version
  create_namespace = false
  dependency_update = var.chart_dependency_update
  lint = var.chart_linting_enabled
  recreate_pods = var.chart_recreate_pods
  upgrade_install = var.chart_upgrade_install
  replace = var.chart_replace
  cleanup_on_fail = var.chart_cleanup_on_fail

  set = [
    {
      name  = "api.image.repository"
      value = var.api_image_repository
    },
    {
      name  = "api.image.tag"
      value = var.api_image_tag
    },
    {
      name  = "web.image.repository"
      value = var.web_image_repository
    },
    {
      name  = "web.image.tag"
      value = var.web_image_tag
    },
    {
      name  = "auth.image.repository"
      value = var.auth_image_repository
    },
    {
      name  = "auth.image.tag"
      value = var.auth_image_tag
    },
    {
      name  = "app.image.pullPolicy"
      value = var.image_pull_policy
    },
    {
      name  = "app.mode"
      value = var.api_only ? "api" : "dashboard"
    },
    {
      name  = "app.ingress.enabled"
      value = var.ingress_enabled
    },
    {
      name  = "app.ingress.hosts[0]"
      value = var.ingress_host_address
    },
    {
      name  = "app.ingress.ingressClassName"
      value = var.ingress_class_name
    },
    {
      name  = "app.ingress.path"
      value = "/"
    },
    {
      name  = "app.ingress.pathType"
      value = "ImplementationSpecific"
    },
    {
      name  = "app.ingress.issuer.name"
      value = null # Rely on user-provided annotations
    },
    {
      name  = "app.ingress.issuer.scope"
      value = "disabled" # Rely on user-provided annotations
    },
    {
      name  = "app.ingress.annotations"
      value = var.ingress_annotations
    },
    {
      name  = "app.ingress.useDefaultIngressClass"
      value = false # Rely on user-provided ingress class name
    },
    {
      name  = "app.ingress.useDefaultAnnotations"
      value = false # Rely on user-provided annotations
    },
    {
      name  = "app.ingress.tls.enabled"
      value = true
    },
    {
      name  = "app.ingress.tls.secretName"
      value = local.tls_secret_name
    },
  ]
}
