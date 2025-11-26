# Provider vars
variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for the target Kubernetes cluster."
  type        = string
  default     = "~/.kube/config"
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

# kubernetes_dashboard specific vars
variable "api_image_repository" {
  description = "The image repository for the Kubernetes Dashboard API server."
  type        = string
  default     = "docker.io/kubernetesui/dashboard-api"
}

variable "api_image_tag" {
  description = "The image tag for the Kubernetes Dashboard API server."
  type        = string
  default     = "latest"
}

variable "web_image_repository" {
  description = "The image repository for the Kubernetes Dashboard web component."
  type        = string
  default     = "docker.io/kubernetesui/dashboard-web"
}

variable "web_image_tag" {
  description = "The image tag for the Kubernetes Dashboard web component."
  type        = string
  default     = "latest"
}

variable "auth_image_repository" {
  description = "The image repository for the Kubernetes Dashboard auth proxy."
  type        = string
  default     = "docker.io/kubernetesui/dashboard-auth"
}

variable "auth_image_tag" {
  description = "The image tag for the Kubernetes Dashboard auth proxy."
  type        = string
  default     = "latest"
}

variable "image_pull_policy" {
  description = "The image pull policy for all Kubernetes Dashboard components."
  type        = string
  default     = "Always"
}

variable "api_only" {
  description = "Whether to deploy only the API server component of the Kubernetes Dashboard."
  type        = bool
  default     = false
}

variable "ingress_enabled" {
  description = "Whether to enable ingress for the Kubernetes Dashboard."
  type        = bool
  default     = false
}

variable "ingress_class_name" {
  description = "The ingress class name to use for the Kubernetes Dashboard ingress."
  type        = string
  default     = "nginx"
}

variable "ingress_annotations" {
  description = "A map of annotations to add to the Kubernetes Dashboard ingress."
  type        = map
  default     = {}
}

variable "ingress_host_address" {
  description = "The host address for the Kubernetes Dashboard web ingress."
  type        = string
  default     = "kubernetes-dashboard.local"
}
