module "homeassistant_environment" {
  depends_on = [
    module.cert_manager
  ]
  source = "github.com/ParksBra/home-k8s-tf-lib//modules/homeassistant_environment?ref=initial_development"

  chart_linting_enabled = local.chart_linting_enabled

  python_executable = var.python_executable

  namespace = local.homeassistant_environment_namespace

  ingress_class_name = local.ingress_class_name
  ingress_annotations = {
    "cert-manager.io/cluster-issuer" = module.cert_manager.cluster_issuer_name
  }

  mosquitto_admin_username = local.mosquitto_admin_username
  mosquitto_admin_password = data.infisical_secrets.environment.secrets[local.mosquitto_admin_password_secret_name].value

  homeassistant_trusted_proxies = local.homeassistant_trusted_proxies

  parent_domain = local.parent_domain

  zfs_pool_name = local.zfs_pool_name
  homeassistant_storage_size_gb = local.homeassistant_storage_size_gb
  mosquitto_storage_size_gb = local.mosquitto_storage_size_gb
  zigbee2mqtt_storage_size_gb = local.zigbee2mqtt_storage_size_gb
}
