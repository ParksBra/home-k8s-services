# Provider vars
variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for the target Kubernetes cluster."
  type        = string
}

# Chart vars
variable "chart_version" {
  description = "The version of the Akri Helm chart to deploy."
  type        = string
  default     = "latest"
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

# Akri vars
variable "akri_namespace" {
  description = "The namespace in which to deploy Akri."
  type        = string
  default     = "akri"
}

# Akri controller image vars
variable "akri_controller_image_repository" {
  description = "The Akri controller image repository."
  type        = string
  default     = "ghcr.io/project-akri/akri/controller"
}

variable "akri_controller_image_tag" {
  description = "The Akri controller image tag."
  type        = string
  default     = "latest"
}

variable "akri_controller_image_pull_policy" {
  description = "The Akri controller image pull policy."
  type        = string
  default     = "Always"
}

# Akri agent image vars
variable "akri_agent_image_repository" {
  description = "The Akri agent image repository."
  type        = string
  default     = "ghcr.io/project-akri/akri/agent"
}

variable "akri_agent_full_image_repository" {
  description = "The full Akri agent image repository."
  type        = string
  default     = "ghcr.io/project-akri/akri/agent-full"
}

variable "akri_agent_image_tag" {
  description = "The Akri agent image tag."
  type        = string
  default     = "latest"
}

variable "akri_agent_image_pull_policy" {
  description = "The Akri agent image pull policy."
  type        = string
  default     = "Always"
}

# Akri udev instance vars
variable "akri_udev_instance_name" {
  description = "The name of the Akri udev instance."
  type        = string
  default     = "udev-instance"
}

variable "akri_udev_discovery_group_recursive" {
  description = "Whether the Akri udev discovery group should be recursive."
  type        = bool
  default     = true
}

variable "akri_udev_discovery_rules" {
  description = "The Akri udev discovery rules."
  type        = list(string)
  default     = []
}
