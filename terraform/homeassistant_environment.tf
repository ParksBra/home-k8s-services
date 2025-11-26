module "homeassistant_environment" {
  source = "github.com/ParksBra/home-k8s-tf-lib//modules/homeassistant_environment?ref=initial_development"

  python_executable = var.python_executable

  namespace = local.homeassistant_environment_namespace

  ingress_class_name = local.ingress_class_name

  mosquitto_admin_username = local.mosquitto_admin_username
  mosquitto_admin_password = ephemeral.infisical_secret.mosquitto_admin_password.value

  acme_email = ephemeral.infisical_secret.acme_email.value
  cloudflare_email = ephemeral.infisical_secret.cloudflare_email.value
  cloudflare_api_token = ephemeral.infisical_secret.cloudflare_api_token.value

  parent_domain = local.parent_domain

  zfs_pool_name = local.zfs_pool_name
  homeassistant_storage_size_gb = local.homeassistant_storage_size_gb
  mosquitto_storage_size_gb = local.mosquitto_storage_size_gb
  zigbee2mqtt_storage_size_gb = local.zigbee2mqtt_storage_size_gb
}
