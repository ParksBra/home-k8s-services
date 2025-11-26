locals {
  filesystem_type = "zfs"
}

resource "kubernetes_storage_class" "zfs" {
  metadata {
    name          = var.name
    generate_name = var.name == null ? "${local.filesystem_type}-" : null
    annotations   = var.annotations
    labels        = var.labels
  }

  storage_provisioner = var.provisioner
  reclaim_policy      = var.reclaim_policy
  volume_binding_mode = var.volume_binding_mode
  parameters          = {
    recordsize    = var.record_size
    compression   = var.compression
    deduplication = var.deduplication
    fstype        = local.filesystem_type
    poolname      = var.zfs_pool_name
  }
}
