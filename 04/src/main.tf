data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 




#Задание 6
# //прописаны в personal.auto.tfvars
# variable "existing_account_id" {
#   type = string
# }
# variable "existing_account_access_key" {
#   type = string
# }
# variable "existing_account_secret_key" {
#   type = string
# }

# module "s3_bucket" {
#  folder_id = var.folder_id 
#  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=master"
#  bucket_name = "my-example"
#  storage_admin_service_account = {
#     //name                        = "s3 admin"
#     existing_account_id         = var.existing_account_id
#     existing_account_access_key = var.existing_account_access_key
#     existing_account_secret_key = var.existing_account_secret_key
#   }
#  max_size = 1073741824 //1 Гб
#  policy_console = {
#    enabled = true
# }
#  policy = {
#     enabled = false
#   }
#   default_storage_class = "STANDARD"
# }

/*

#Задание 5
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

module "mysql_cluster" {
  source       = "./yandex_mysql_cluster"
  cluster_name = "example"
  network_id   = yandex_vpc_network.develop.id
  ha_enabled   = true  # false-1 true-2 = количество хостов
  zone_and_cidr_blocks = {
    "zone1" = {
      zone           = "ru-central1-a"
      v4_cidr_blocks = ["10.0.1.0/24"]
    },
    "zone2" = {
      zone           = "ru-central1-b"
      v4_cidr_blocks = ["10.0.2.0/24"]
    }
  }
  }

module "mysql_database_and_user" {
  source      = "./yandex_mysql_db"
  database_name = "test"
  username     = "app"
  cluster_id   = module.mysql_cluster.cluster_id
}




#Задания 1-4
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
*/

/*
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
*/