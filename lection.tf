#ansible.tf

#main.tf
/*
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.129.0"
    }
  }

  required_version = ">=1.8.4"
}

provider "yandex" {    
  zone = "ru-central1-b" 
  # token                  = "do not use!!!"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = file("~/.authorized_key.json")
}
*/
/*
resource "yandex_compute_instance" "vm" {
  count = 2

  name        = "vm${count.index}" #Имя ВМ в облачной консоли  
  platform_id = "standard-v1"

  boot_disk {
    initialize_params {
        image_id = "fd819nnsamg64h4gup91" #взять айди в яндексе. в лекции убунту 24.04
        size = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet1.id
    nat                = true    
  }

  resources {
    cores         = 2
    memory        = 2
    #core_fraction = 20
  }


  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/ter23062026.pub")}" #указание какой паблик-ключ установить на машину
    }
   
}
*/
/*
resource "yandex_vpc_network" "network1" {
  name = "network1"
}


resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"  
  v4_cidr_blocks = ["172.24.8.0/24"]
  network_id     = yandex_vpc_network.network1.id  
}
*/
/*
resource "yandex_lb_target_group" "group1" {
  name           = "group1"

  dynamic "target" {
    for_each = yandex_compute_instance.vm
    content {
        subnet_id = yandex_vpc_subnet.subnet1.id
        address = target.value.network_interface.0.ip_address
    }
  }   
}


resource "yandex_lb_network_load_balancer" "balancer1" {
  name = "balancer1"
  deletion_protection = "false"

  listener {
    name = "my-lb"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.group1.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
*/

#output.tf
