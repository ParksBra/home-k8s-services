terraform {
  required_providers {
    infisical = {
      source  = "infisical/infisical"
      version = "~> 0.15.48"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.19.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.1.1"
    }
    jinja = {
      source  = "NikolaLohinski/jinja"
      version = "~> 2.4.3"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "infisical" {
  host = var.infisical_uri
  auth = {
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

provider "jinja" {
}
