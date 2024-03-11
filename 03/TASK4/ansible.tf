resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",
    { 
      webservers = yandex_compute_instance.web
      dbservers = yandex_compute_instance.db
      storages = yandex_compute_instance.vm_storage
    })
  filename = "${abspath(path.module)}/inventory.ini"
}