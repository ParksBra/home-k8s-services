locals {
  # General configuration
  parent_domain = "parkl.ee"
}

locals {
  # OpenEBS ZFS configuration
  zfs_pool_name = "zfspv-pool"
}

locals {
  # Cert-Manager configuration
  cert_manager_namespace_name = "cert-manager"

  cert_manager_acme_email_infisical_secret_name = "cloudflare-email"
  cert_manager_dns_provider = "cloudflare"
  cert_manager_dns_provider_email_infisical_secret_name = "cloudflare-email"
  cert_manager_dns_provider_api_token_infisical_secret_name = "cloudflare-api-token"
}

locals {
  # Kubernetes Dashboard configuration
  kubernetes_dashboard_namespace_name = "kubernetes-dashboard"
}

locals {
  # Homeassistant environment configuration
  haenv_namespace_name = "home-assistant"
  haenv_ingress_class_name = "nginx"
  haenv_homeassistant_storage_size_gb = 32
  haenv_mosquitto_storage_size_gb = 8
  haenv_zigbee2mqtt_storage_size_gb = 8

  haenv_chart_linting_enabled = true

  haenv_ingress_annotations = {
    "cert-manager.io/cluster-issuer" = module.cert_manager.cluster_issuer_name
  }

  haenv_homeassistant_trusted_proxies = [
    "127.0.0.0/8",
    "10.244.0.0/16",
    "10.96.0.0/12"
  ]

  haenv_mosquitto_admin_username = "admin"
  haenv_mosquitto_admin_password_infisical_secret_name = "mosquitto-account-password"
}
