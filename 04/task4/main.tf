module "vpc_prod" {
  source       = "./vpc_dev"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}
module "vpc_dev" {
  source       = "./vpc_dev"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}

module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing"
  network_id     = module.vpc_prod.subnet_info[0].network_id
  subnet_zones   = [for subnet in module.vpc_prod.subnet_info : subnet.zone]
  subnet_ids     = [for subnet in module.vpc_prod.subnet_info : subnet.id]
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

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "analytics"
  network_id     = module.vpc_prod.subnet_info[0].network_id
  subnet_zones   = [for subnet in module.vpc_prod.subnet_info : subnet.zone]
  subnet_ids     = [for subnet in module.vpc_prod.subnet_info : subnet.id]
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
