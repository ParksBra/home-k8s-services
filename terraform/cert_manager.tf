module "cert_manager" {
  source = "github.com/ParksBra/home-k8s-tf-lib//modules/cert_manager?ref=initial_development"

  namespace = local.cert_manager_namespace_name
  create_namespace = true
  create_cluster_issuer = true

  acme_email = data.infisical_secrets.environment.secrets[local.acme_email_secret_name].value
  dns_solver_email = data.infisical_secrets.environment.secrets[local.cloudflare_email_secret_name].value
  dns_solver_api_token = data.infisical_secrets.environment.secrets[local.cloudflare_api_token_secret_name].value
  dns_solver_provider = "cloudflare"
}
