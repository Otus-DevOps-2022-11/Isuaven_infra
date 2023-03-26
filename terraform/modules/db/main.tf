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

resource "yandex_compute_instance" "db" {
  name = "reddit-db"
  labels = {
    tags = "reddit-db"
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

resource "null_resource" "db_postconfig" {
  count = "${var.deploy_app == 1 ? 1 : 0}"
  connection {
    type  = "ssh"
    host  = yandex_compute_instance.db.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = "${file(var.private_key)}"
  }
    provisioner "file" {
    content     = templatefile("${path.module}/files/mongod.conf.tftpl", { db_int_ip = yandex_compute_instance.db.network_interface.0.ip_address })
    destination = "/tmp/mongod.conf"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}
