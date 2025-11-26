resource "terraform_data" "mosquitto_password_hasher" {
  input = var.admin_password

  triggers_replace = [
    var.admin_password
  ]

  provisioner "local-exec" {
    command = "${var.python_executable} mosquitto_password_hasher.py ${var.admin_password}"
    working_dir = "${path.module}/scripts"
  }
}
