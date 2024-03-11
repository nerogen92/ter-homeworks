resource "yandex_compute_instance" "web" {
  count       = 2
  name        = "web-${count.index + 1}" # Счет начинается с 0, добавляем 1 для имен web-1 и web-2
  folder_id   = var.folder_id
  zone        = var.default_zone
  platform_id = var.platform_id
  depends_on = [yandex_compute_instance.db]

  resources {
    cores = var.vm_web_cores
    memory = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id #убуту
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id # ID сети
    nat       = true
    // Группа безопасности, созданная в первом задании
   security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}
