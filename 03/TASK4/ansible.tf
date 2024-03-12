resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = length(yandex_compute_instance.web) > 0 ? [for w in yandex_compute_instance.web : {
      name = w.name,
      id = w.id,
      nat_ip_address = try(w.network_interface[0].nat_ip_address, "")
    }] : [],
    dbservers = length(yandex_compute_instance.db) > 0 ? [for d in yandex_compute_instance.db : {
      name = d.name,
      id = d.id,
      nat_ip_address = try(d.network_interface[0].nat_ip_address, "")
    }] : [],
    storages = [{
      name = yandex_compute_instance.vm_storage.name,
      id = yandex_compute_instance.vm_storage.id,
      nat_ip_address = try(yandex_compute_instance.vm_storage.network_interface[0].nat_ip_address, "")
    }]
  })
  filename = "${abspath(path.module)}/inventory.ini"
}
