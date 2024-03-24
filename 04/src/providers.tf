terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.1"
    }
   template = {
      source  = "gxben/template"
      version = "= 2.2.0-m1"
    }
    random = {
      source  = "hashicorp/random"
      version = "> 3.5"
    }
  }
  required_version = ">=1.5"
}

provider "aws" {
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
provider "vault" {
  address         = "http://172.31.1.192:8200"
  skip_tls_verify = true
  token           = "education"
  # checkov:skip=CKV_SECRET_6: education
}