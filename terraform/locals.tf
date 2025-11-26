locals {
  homeassistant_environment_namespace = "homeassistant"
  ingress_class_name = "nginx"
  parent_domain = "parkl.ee"
  zfs_pool_name = "zfspv-pool"
  homeassistant_storage_size = "32Gi"
  mosquitto_storage_size = "8Gi"
  zigbee2mqtt_storage_size = "8Gi"
}

locals {
  mosquito_admin_username_secret_name = "mosquito-admin-username"
  mosquito_admin_password_secret_name = "mosquito-admin-password"

  cloudflare_email_secret_name = "cloudflare-email"
  cloudflare_api_token_secret_name = "cloudflare-api-token"

  acme_email_secret_name = "acme-email"
}
