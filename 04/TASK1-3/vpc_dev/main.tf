terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.5"
}

variable "vpc_name" {
  type = string
}

variable "zone" {
  type = string
}

variable "v4_cidr_blocks" {
  type = string
}

resource "yandex_vpc_network" "vpc" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnet" {
  name           = var.vpc_name
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = [var.v4_cidr_blocks]
}

output "subnet_info" {
  value = yandex_vpc_subnet.subnet
}
