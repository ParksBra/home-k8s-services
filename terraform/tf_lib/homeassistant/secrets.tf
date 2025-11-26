locals {
  codeserver_generate_password = var.codeserver_password == null && var.codeserver_auth_enabled ? true : false
  codeserver_generated_password_length = 32
}

resource "random_password" "codeserver_password" {
  count            = local.codeserver_generate_password ? 1 : 0
  length           = local.codeserver_generated_password_length
  special          = false
  numeric          = true
  lower            = true
  upper            = true
  min_lower        = floor((local.codeserver_generated_password_length / 2) / 3)
  min_upper        = ceil((local.codeserver_generated_password_length / 2) / 3)
  min_numeric      = floor((local.codeserver_generated_password_length / 2) / 3)
  keepers          = [
    local.codeserver_generated_password_length,
  ]
}

locals {
  codeserver_password_secret_name = "${local.chart_install_name}-codeserver-auth"
  codeserver_password = var.codeserver_password != null ? var.codeserver_password : random_password.codeserver_password.result
}

resource "kubernetes_secret" "codeserver_password_secret" {
  count = var.codeserver_auth_enabled ? 1 : 0
  depends_on = [
    random_password.codeserver_password,
    data.kubernetes_namespace.namespace
  ]
  metadata {
    name = local.codeserver_password_secret_name
    namespace = data.kubernetes_namespace.namespace.id
  }
  data = {
    password = local.codeserver_password
  }
  type = "Opaque"
}
