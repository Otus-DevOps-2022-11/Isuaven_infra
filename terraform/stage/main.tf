terraform {
  required_providers {
    yandex = "~> 0.35.0"
  }
  required_version = ">= 0.12.0"
/*
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.44.0"
    }
  }
*/
}

provider "yandex" {
  service_account_key_file = file(var.service_account_key_file)
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "vpc" {
  source          = "../modules/vpc"
}

module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = module.vpc.vpc_subnet_id
  private_key     = var.private_key
  db_int_ip       = module.db.internal_ip_address_db
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = module.vpc.vpc_subnet_id
  private_key     = var.private_key
}
