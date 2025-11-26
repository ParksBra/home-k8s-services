data "infisical_secrets" "environment" {
  env_slug     = var.infisical_environment
  workspace_id  = var.infisical_project_id
  folder_path  = "/"
}
