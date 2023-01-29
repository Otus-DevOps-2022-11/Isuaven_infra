variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db-base"
}
variable subnet_id {
  description = "Subnets for modules"
}
variable private_key {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}
variable deploy_app {
  description = "Deploy app true(1) or false(0)"
  default = 1
}
