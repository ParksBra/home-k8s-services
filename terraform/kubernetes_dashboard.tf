module "kubernetes_dashboard" {
  source = "github.com/ParksBra/home-k8s-tf-lib//modules/kubernetes_dashboard?ref=initial_development"
  depends_on = [
    module.cert_manager
  ]

  namespace = local.kubernetes_dashboard_namespace_name
  create_namespace = true

  chart_linting_enabled = local.kubernetes_dashboard_chart_linting_enabled

  ingress_enabled = true
  ingress_class_name = local.kubernetes_dashboard_ingress_class_name
  ingress_annotations = {
    "cert-manager.io/cluster-issuer" = module.cert_manager.cluster_issuer_name
  }
  ingress_host_address = "k8s.home.${local.parent_domain}"
}
