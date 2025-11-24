resource "helm_release" "akri" {
  name       = "akri"
  repository = "https://akri.sh/helm-charts"
  chart      = "akri"

  namespace = var.chart_namespace

  depends_on = [
    kubernetes_namespace.akri
  ]
}
