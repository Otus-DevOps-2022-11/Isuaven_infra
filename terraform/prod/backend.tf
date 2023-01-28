terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "otus-bucket"
    region   = "ru-central1"
    key      = "terraform/prod/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
