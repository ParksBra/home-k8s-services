module "cert_manager" {
  source = "github.com/ParksBra/home-k8s-tf-lib//modules/cert_manager?ref=${local.cert_manager_branch_ref}"

  namespace = local.cert_manager_namespace_name
  create_namespace = true
  create_cluster_issuer = true

  acme_email = data.infisical_secrets.environment.secrets[local.cert_manager_acme_email_infisical_secret_name].value
  dns_solver_email = data.infisical_secrets.environment.secrets[local.cert_manager_dns_provider_email_infisical_secret_name].value
  dns_solver_api_token = data.infisical_secrets.environment.secrets[local.cert_manager_dns_provider_api_token_infisical_secret_name].value
  dns_solver_provider = local.cert_manager_dns_provider
}
