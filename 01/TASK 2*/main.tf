terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 0.13"
}

provider "docker" {
  host = "ssh://nerogen@158.160.150.232:22"
}

resource "random_password" "mysql_root" {
  length      = 8
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "mysql_user" {
  length      = 8
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = false
}

resource "docker_container" "mysql_container" {
  image = docker_image.mysql.image_id
  name  = "mysql_example_${random_password.mysql_root.result}"
  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.mysql_root.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.mysql_user.result}",
    "MYSQL_ROOT_HOST=%",
  ]
  ports {
    internal = 3306
    external = 3306
  }
}
