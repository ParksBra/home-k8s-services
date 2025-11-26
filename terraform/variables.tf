variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
}

variable "python_executable" {
  description = "Path to the Python executable"
  type        = string
}

variable "infisical_uri" {
  description = "The Infisical API URI"
  type        = string
}

variable "infisical_auth_client_id" {
  description = "The Infisical Auth Client ID"
  type        = string
  sensitive   = true
}

variable "infisical_auth_client_secret" {
  description = "The Infisical Auth Client Secret"
  type        = string
  sensitive   = true
}

variable "infisical_project_id" {
  description = "The Infisical Project ID"
  type        = string
}

variable "infisical_environment" {
  description = "The Infisical Environment"
  type        = string
}
