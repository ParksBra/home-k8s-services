# Provider vars
variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for the target Kubernetes cluster."
  type        = string
  default     = "~/.kube/config"
}

# StorageClass vars
variable "name" {
  description = "The name of the ZFS StorageClass. If null, a default name will be generated."
  type        = string
  default     = null
}

variable "annotations" {
  description = "Annotations to be added to the ZFS StorageClass."
  type        = map
  default     = {}
}

variable "labels" {
  description = "Labels to be added to the ZFS StorageClass."
  type        = map
  default     = {}
}

variable "zfs_pool_name" {
  description = "The ZFS pool name to be used by the StorageClass."
  type        = string
}

variable "provisioner" {
  description = "The provisioner for the ZFS StorageClass."
  type        = string
  default     = "zfs.csi.openebs.io"
}

variable "reclaim_policy" {
  description = "The reclaim policy for the ZFS StorageClass."
  type        = string
  default     = "Delete"
}

variable "volume_binding_mode" {
  description = "The volume binding mode for the ZFS StorageClass."
  type        = string
  default     = "WaitForFirstConsumer"
}

variable "record_size" {
  description = "The record size for ZFS volumes created with this StorageClass."
  type        = string
  default     = "128K"
}

variable "compression" {
  description = "The compression setting for ZFS volumes created with this StorageClass."
  type        = string
  default     = "off"
}

variable "deduplication" {
  description = "The deduplication setting for ZFS volumes created with this StorageClass."
  type        = string
  default     = "off"
}
