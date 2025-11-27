locals {
  homeassistant_environment_namespace = "homeassistant"
  ingress_class_name = "nginx"
  parent_domain = "parkl.ee"
  zfs_pool_name = "zfspv-pool"
  homeassistant_storage_size_gb = 32
  mosquitto_storage_size_gb = 8
  zigbee2mqtt_storage_size_gb = 8

  chart_linting_enabled = false

  homeassistant_trusted_proxies = [
    "127.0.0.0/8",
    "10.244.0.0/16",
    "10.96.0.0/12"
  ]
}

locals {
  cert_manager_namespace_name = "cert-manager"
}

locals {
  mosquitto_admin_username = "admin"
  mosquitto_admin_password_secret_name = "mosquitto-account-password"

  cloudflare_email_secret_name = "cloudflare-email"
  cloudflare_api_token_secret_name = "cloudflare-api-token"

  acme_email_secret_name = "cloudflare-email"
}
