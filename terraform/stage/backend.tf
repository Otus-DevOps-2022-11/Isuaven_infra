terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "otus-bucket"
    region   = "ru-central1"
    key      = "terraform/stage/terraform.tfstate"
    # Fake credentionals:
    # access_key = "YCAJEzxDhimRFlx_kYElbzPnH"
    # secret_key = "YCM2iB_e9qa-IxIYFmBsRNiIYz__CRmGlZpmCagl"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
