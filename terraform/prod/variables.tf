variable "cloud_id" {
  description = "Cloud"
  type        = string
}
variable "folder_id" {
  description = "Folder"
  type        = string
}
variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
  type        = string
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
  type        = string
}
variable "private_key" {
  # Описание переменной
  description = "Path to the private key used for ssh access"
  type        = string
}
variable "image_id" {
  description = "Disk image"
  type        = string
}
variable "subnet_id" {
  description = "Subnet"
  type        = string
}
variable "service_account_key_file" {
  description = "key .json"
  type        = string
}
variable "instance_count" {
  description = "Count of instances"
  default     = "1"
  type        = number
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
  type        = string
}
variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
  type        = string
}
