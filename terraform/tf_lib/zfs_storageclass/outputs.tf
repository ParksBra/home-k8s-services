output "name" {
  description = "The name of the ZFS StorageClass."
  value       = kubernetes_storage_class.zfs.metadata[0].name
}

output "id" {
  description = "The ID of the ZFS StorageClass."
  value       = kubernetes_storage_class.zfs.id
}

output "reclaim_policy" {
  description = "The reclaim policy of the ZFS StorageClass."
  value       = kubernetes_storage_class.zfs.reclaim_policy
}
