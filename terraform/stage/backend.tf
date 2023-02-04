terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "otus-bucket"
    region   = "ru-central1"
    key      = "terraform/stage/terraform.tfstate"
    # Fake credentionals:
    access_key = "inKfymJWcMa8XzFtvoOA"
    secret_key = "xEMiI4A4dwmzJuE66yjC"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
