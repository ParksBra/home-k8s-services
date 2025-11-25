# Provider vars
variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for the target Kubernetes cluster."
  type        = string
}

# Chart vars
variable "chart_version" {
  description = "The version of the Akri Helm chart to deploy."
  type        = string
  default     = null
}

variable "chart_namespace" {
  description = "The namespace in which to deploy the Akri Helm chart."
  type        = string
  default     = "akri"
}

variable "chart_create_namespace" {
  description = "Whether to create the namespace for the Akri Helm chart."
  type        = bool
  default     = true
}

variable "chart_linting_enabled" {
  description = "Whether to enable Helm chart linting."
  type        = bool
  default     = true
}

variable "chart_recreate_pods" {
  description = "Whether to recreate pods when deploying the Helm chart."
  type        = bool
  default     = false
}

variable "chart_upgrade_install" {
  description = "Whether to install the Helm chart if it is not already installed during an upgrade."
  type        = bool
  default     = true
}

variable "chart_replace" {
  description = "Whether to replace the Helm chart if it is already installed."
  type        = bool
  default     = false
}

variable "chart_dependency_update" {
  description = "Whether to update chart dependencies before installing or upgrading the Helm chart."
  type        = bool
  default     = true
}

variable "chart_cleanup_on_fail" {
  description = "Whether to cleanup resources if the Helm chart installation or upgrade fails."
  type        = bool
  default     = true
}

# Akri chart specific vars
variable "akri_values_yaml" {
  description = "Raw YAML string containing values to override the default Akri Helm chart values."
  type        = string
}
