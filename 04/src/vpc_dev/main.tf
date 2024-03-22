terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.5"
}

variable "env_name" {
  type = string
}

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
}

resource "yandex_vpc_network" "vpc" {
  name = var.env_name
}

resource "yandex_vpc_subnet" "subnet" {
  count          = length(var.subnets)
  name           = "${var.env_name}-${var.subnets[count.index]["zone"]}"
  zone           = var.subnets[count.index]["zone"]
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = [var.subnets[count.index]["cidr"]]
}

output "subnet_info" {
  value = yandex_vpc_subnet.subnet[*]
}
