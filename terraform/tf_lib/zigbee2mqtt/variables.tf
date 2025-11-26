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

# Zigbee2MQTT specific vars
variable "namespace" {
  description = "The namespace where Zigbee2MQTT is deployed."
  type        = string
  default     = "zigbee2mqtt"
}

variable "image_repository" {
  description = "The Docker image repository for Zigbee2MQTT."
  type        = string
  default     = "koenkk/zigbee2mqtt"
}

variable "image_tag" {
  description = "The Docker image tag for Zigbee2MQTT."
  type        = string
  default     = "latest"
}

variable "image_pull_policy" {
  description = "The image pull policy for Zigbee2MQTT."
  type        = string
  default     = "Always"
}

variable "ingress_enabled" {
  description = "Whether to enable ingress for Zigbee2MQTT."
  type        = bool
  default     = false
}

variable "ingress_class_name" {
  description = "The ingress class name to use for the Zigbee2MQTT ingress."
  type        = string
  default     = "nginx"
}

variable "ingress_annotations" {
  description = "A map of annotations to add to the Zigbee2MQTT ingress."
  type        = map
  default     = {}
}

variable "ingress_host_address" {
  description = "The host address for the Zigbee2MQTT web ingress."
  type        = string
  default     = "zigbee2mqtt.local"
}

variable "service_port" {
  description = "The port exposed by the Zigbee2MQTT service."
  type        = number
  default     = 8080
}

variable "service_type" {
  description = "The type of Kubernetes service to create for Zigbee2MQTT."
  type        = string
  default     = "ClusterIP"
}

variable "mqtt_broker_address" {
  description = "The address of the MQTT broker for Zigbee2MQTT to connect to. Use 'mqtt://<broker_address>:<port>' format."
  type        = string
}

variable "mqtt_broker_username" {
  description = "The username for the MQTT broker."
  type        = string
  default     = null
}

variable "mqtt_broker_password" {
  description = "The password for the MQTT broker."
  type        = string
  default     = null
  sensitive   = true
}

variable "zigbee_serial_port" {
  description = "The serial port for the Zigbee adapter."
  type        = string
  default     = null
}
