ephemeral "infisical_secret" "mosquitto_admin_password" {
  name         = local.mosquitto_admin_password_secret_name
  env_slug     = var.infisical_environment
  workspace_id  = var.infisical_project_id
  folder_path  = "/"
}

ephemeral "infisical_secret" "cloudflare_email" {
  name         = local.cloudflare_email_secret_name
  env_slug     = var.infisical_environment
  workspace_id  = var.infisical_project_id
  folder_path  = "/"
}

ephemeral "infisical_secret" "cloudflare_api_token" {
  name         = local.cloudflare_api_token_secret_name
  env_slug     = var.infisical_environment
  workspace_id  = var.infisical_project_id
  folder_path  = "/"
}

ephemeral "infisical_secret" "acme_email" {
  name         = local.acme_email_secret_name
  env_slug     = var.infisical_environment
  workspace_id  = var.infisical_project_id
  folder_path  = "/"
}
