module "homeassistant_environment" {
  source = "https://github.com/ParksBra/home-k8s-tf-lib/tree/initial_development/modules/homeassistant_environment"

  namespace = local.homeassistant_environment_namespace
  ingress_class_name = local.ingress_class_name
  cloudflare_api_token = ephemeral.infisical_secret.cloudflare_api_token.value
  mosquitto_admin_username = ephemeral.infisical_secret.mosquitto_admin_username.value
  mosquitto_admin_password = ephemeral.infisical_secret.mosquitto_admin_password.value
  acme_email = ephemeral.infisical_secret.acme_email.value
  cloudflare_email = ephemeral.infisical_secret.cloudflare_email.value
  parent_domain = local.parent_domain
  zfs_pool_name = local.zfs_pool_name
  homeassistant_storage_size = local.homeassistant_storage_size
  mosquitto_storage_size = local.mosquitto_storage_size
  zigbee2mqtt_storage_size = local.zigbee2mqtt_storage_size
}
