###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###VM vars
variable "vm_web_image_family" {
  type        = string
  description = "Family of the image"
  default     = "ubuntu-2004-lts"
}

variable "vm_web_platform_id" {
  type        = string
  description = "Platform ID for VM"
  default     = "standard-v1"
}
/*
variable "vm_web_cores" {
  type        = number
  description = "Number of cores for VM"
  default     = 2
}

variable "vm_web_memory" {
  type        = number
  description = "Amount of memory for VM"
  default     = 1
}

variable "vm_web_core_fraction" {
  type        = number
  description = "Core fraction for VM"
  default     = 5
}
*/

variable "vm_web_preemptible" {
  type        = bool
  description = "Whether VM is preemptible or not"
  default     = true
}

###ssh vars
/*
variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1 nerogen@MacBook-Pro-Gleb.local"
  description = "ssh-keygen -t ed25519"
}
*/
variable "instance_name_prefix" {
  type        = string
  description = "Prefix for instance name"
  default     = "netology-develop-platform"
}

##Задание 6.1
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  description = "Configuration for VM resources"
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

#Задание 6.2
variable "common_metadata" {
  type = map(string)
  description = "Common metadata for all VMs"
  default = {
    "serial-port-enable" = "1"
    "ssh-keys" = "ubuntu:ssh-ed25519 AAAAC3NzaCb2YdYGQAj3k nerogen@MacBook-Pro-Gleb.local"
  }
}