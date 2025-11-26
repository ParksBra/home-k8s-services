provider "infisical" {
  host = var.infisical_uri
  auth {
    universal = {
      client_id     = var.infisical_auth_client_id
      client_secret = var.infisical_auth_client_secret
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "kubectl" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes = {
    config_path = var.kubeconfig_path
  }
}
