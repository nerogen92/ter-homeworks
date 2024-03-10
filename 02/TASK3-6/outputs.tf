output "platform_vm_info" {
  value = {
    instance_name = yandex_compute_instance.platform.name
    external_ip   = yandex_compute_instance.platform.network_interface.0.nat_ip_address
    fqdn          = "${yandex_compute_instance.platform.name}.${var.default_zone}.internal"
  }
}

output "db_vm_info" {
  value = {
    instance_name = yandex_compute_instance.vm_platform_db.name
    external_ip   = yandex_compute_instance.vm_platform_db.network_interface.0.nat_ip_address
    fqdn          = "${yandex_compute_instance.vm_platform_db.name}.${var.vm_db_default_zone}.internal"
  }
}
