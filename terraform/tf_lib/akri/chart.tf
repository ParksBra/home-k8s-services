resource "helm_repository" "akri" {
  name = "akri"
  url  = "https://project-akri.github.io/akri"
}

resource "helm_release" "akri" {
  name       = "akri"
  repository = helm_repository.akri.name
  chart      = "akri"

  namespace = var.chart_namespace
  version  = var.chart_version
  create_namespace = var.chart_create_namespace
  dependency_update = var.chart_dependency_update
  lint = var.chart_linting_enabled
  recreate_pods = var.chart_recreate_pods
  upgrade_install = var.chart_upgrade_install
  replace = var.chart_replace
  cleanup_on_fail = var.chart_cleanup_on_fail
  values = [var.akri_values_yaml]
}
