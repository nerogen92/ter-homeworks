resource "yandex_compute_disk" "example_disk" {
  count = 3
  name = "disk-${count.index+1}"
  size = 1
  type = "network-hdd"
  zone = var.default_zone
}
resource "yandex_compute_instance" "vm_storage" {
  name        = "storage-1"   # Storage 1
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

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.example_disk.*.id

    content {
      auto_delete = true
      disk_id     = secondary_disk.value
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
