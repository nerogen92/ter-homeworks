locals {
  instance_name_prefix = var.instance_name_prefix
  platform_vm_name = "${local.instance_name_prefix}-web"
  db_vm_name       = "${local.instance_name_prefix}-db"
}