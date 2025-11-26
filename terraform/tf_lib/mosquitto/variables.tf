# Provider vars
variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for the target Kubernetes cluster."
  type        = string
  default     = "~/.kube/config"
}

variable "python_executable" {
  description = "The Python executable to use for running the Mosquitto password hasher script. Must have the 'passlib' module installed."
  type        = string
  default     = "python3"
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

# Mosquitto vars
variable "namespace" {
  description = "The namespace in which Mosquitto is deployed."
  type        = string
  default     = "mosquitto"
}

variable "image_repository" {
  description = "The Docker image repository for Mosquitto."
  type        = string
  default     = "eclipse-mosquitto"
}

variable "image_tag" {
  description = "The Docker image tag for Mosquitto."
  type        = string
  default     = "latest"
}

variable "image_pull_policy" {
  description = "The image pull policy for the Mosquitto Docker image."
  type        = string
  default     = "Always"
}

variable "pod_replicas" {
  description = "The number of Mosquitto replicas to deploy."
  type        = number
  default     = 1
}

variable "pod_update_strategy" {
  description = "The pod update strategy for Mosquitto."
  type        = string
  default     = "Recreate"
}

variable "data_persistence_enabled" {
  description = "Whether to enable data persistence for Mosquitto."
  type        = bool
  default     = true
}

variable "data_storage_class_name" {
  description = "The storage class name for Mosquitto persistent volume."
  type        = string
  default     = "standard"
}

variable "data_volume_access_mode" {
  description = "The access mode for the Mosquitto persistent volume."
  type        = string
  default     = "ReadWriteOnce"
}

variable "data_volume_size" {
  description = "The size of the persistent volume for Mosquitto data."
  type        = string
  default     = "8Gi"
}

variable "admin_username" {
  description = "The username for Mosquitto authentication."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "The password for Mosquitto authentication."
  type        = string
  default     = "changeme"
  sensitive   = true
}

variable "mqtt_port" {
  description = "The MQTT port for Mosquitto."
  type        = number
  default     = 1883
}

variable "websocket_port" {
  description = "The WebSocket port for Mosquitto."
  type        = number
  default     = 9001
}

variable "service_type" {
  description = "The service type for Mosquitto."
  type        = string
  default     = "ClusterIP"
}

variable "service_external_traffic_policy" {
  description = "The external traffic policy for the Mosquitto service."
  type        = string
  default     = "Cluster"
}
