terraform {
  required_version = ">= 0.13.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.44.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = file(var.service_account_key_file)
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_storage_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = "true"
}
