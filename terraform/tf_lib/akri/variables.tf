# Provider vars
variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for the target Kubernetes cluster."
  type        = string
}

# Chart vars
variable "namespace" {
  description = "The namespace in which to deploy the Helm chart."
  type        = string
  default     = null
}

variable "create_namespace" {
  description = "Whether to create the namespace for the module."
  type        = bool
  default     = false
}

variable "chart_install_name" {
  description = "The name used to install the Helm chart."
  type        = string
  default     = null
}

variable "chart_version" {
  description = "The version of the Helm chart to deploy. If null, the latest version is used."
  type        = string
  default     = null
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
variable "kubernetes_distro" {
  description = "The Kubernetes distribution where Akri is being deployed."
  type        = string
  default     = "k8s"
}

variable "controller_enabled" {
  description = "Whether to enable the Akri controller."
  type        = bool
  default     = true
}

variable "controller_image_repository" {
  description = "The Akri controller image repository."
  type        = string
  default     = "ghcr.io/project-akri/akri/controller"
}

variable "controller_image_tag" {
  description = "The Akri controller image tag."
  type        = string
  default     = "latest"
}

variable "controller_image_pull_policy" {
  description = "The image pull policy for the Akri controller."
  type        = string
  default     = "Always"
}

variable "agent_enabled" {
  description = "Whether to enable the Akri agent."
  type        = bool
  default     = true
}

variable "agent_image_repository" {
  description = "The Akri agent image repository."
  type        = string
  default     = "ghcr.io/project-akri/akri/agent"
}

variable "agent_image_full_repository" {
  description = "The Akri agent image repository."
  type        = string
  default     = "ghcr.io/project-akri/akri/agent-full"
}

variable "agent_image_tag" {
  description = "The Akri agent image tag."
  type        = string
  default     = "latest"
}

variable "agent_image_pull_policy" {
  description = "The image pull policy for the Akri agent."
  type        = string
  default     = "Always"
}

variable "udev_enabled" {
  description = "Whether to enable Akri udev configuration."
  type        = bool
  default     = true
}

variable "udev_discovery_enabled" {
  description = "Whether to enable Akri udev discovery."
  type        = bool
  default     = true
}

variable "udev_instance_name" {
  description = "The name of the Akri udev instance."
  type        = string
  default     = "akri-udev"
}

variable "udev_discovery_rules_list" {
  description = "List of udev discovery rules for Akri."
  type        = list(string)
  default     = []
}

variable "udev_discovery_group_recursive" {
  description = "Whether to use recursive group matching for udev discovery in Akri."
  type        = bool
  default     = true
}
