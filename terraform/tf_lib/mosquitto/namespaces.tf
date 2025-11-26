locals {
  namespace = var.namespace != null ? var.namespace : local.chart_install_name
}

resource "kubernetes_namespace" "namespace" {
  count = var.create_namespace ? 1 : 0
  metadata {
    name = local.namespace
  }
}

data "kubernetes_namespace" "namespace" {
  depends_on = [
    kubernetes_namespace.namespace,
  ]
  metadata {
    name = local.namespace
  }
}
