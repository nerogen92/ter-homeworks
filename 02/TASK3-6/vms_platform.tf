
variable "vm_db_image_family" {
  type        = string
  description = "Family of the image"
  default     = "ubuntu-2004-lts"
}

variable "vm_db_platform_id" {
  type        = string
  description = "Platform ID for VM"
  default     = "standard-v1"
}
/*
variable "vm_db_cores" {
  type        = number
  description = "Number of cores for VM"
  default     = 2
}

variable "vm_db_memory" {
  type        = number
  description = "Amount of memory for VM"
  default     = 2
}

variable "vm_db_core_fraction" {
  type        = number
  description = "Core fraction for VM"
  default     = 20
}
*/
variable "vm_db_preemptible" {
  type        = bool
  description = "Whether VM is preemptible or not"
  default     = true
}
variable "vm_db_vpc_name" {
  type        = string
  default     = "develop_db"
  description = "VPC network & subnet name"
}
variable "vm_db_default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}