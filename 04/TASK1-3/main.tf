#  Использование модуля vpc_dev
module "vpc_dev" {
  source         = "./vpc_dev"
  vpc_name       = "develop"
  zone           = "ru-central1-a"
  v4_cidr_blocks = "10.0.1.0/24"
}
# Создание ВМ для проекта marketing
module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing"
  network_id     = module.vpc_dev.subnet_info.network_id
  subnet_zones   = [module.vpc_dev.subnet_info.zone]
  subnet_ids     = [module.vpc_dev.subnet_info.id]
  instance_name  = "marketing-web"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  labels         = {
    project = "marketing"
  }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}
# Создание ВМ для проекта analytics
module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "analytics"
  network_id     = module.vpc_dev.subnet_info.network_id
  subnet_zones   = [module.vpc_dev.subnet_info.zone]
  subnet_ids     = [module.vpc_dev.subnet_info.id]
  instance_name  = "analytics-web"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  labels         = {
    project = "analytics"
  }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

#Пример передачи cloud-config в ВМ
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username           = var.username
    ssh_public_key     = file(var.ssh_public_key)
    packages           = join("\n  - ", var.packages) // Преобразуем список в строку, разделенную новой строкой
  }
}
