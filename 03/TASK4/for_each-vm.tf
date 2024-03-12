data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}
resource "yandex_compute_instance" "db" {
  # Преобразование списка объектов в словарь с ключами, основанными на vm_name
  for_each = { for vm in var.each_vm : vm.vm_name => vm }
  depends_on = [yandex_vpc_subnet.develop]
  name        = each.value.vm_name
  folder_id   = var.folder_id
  zone        = var.default_zone
  platform_id = var.platform_id

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id #убуту
      size     = each.value.disk_volume
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
