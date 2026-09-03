
resource "yandex_compute_instance_group" "ig-1" {
  name                = "fixed-ig-with-balancer"
  folder_id           = var.folder_id
  service_account_id  = "ajegpfvalbqadugcgurq"
  #service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
  #deletion_protection = "<защита_от_удаления>"
  instance_template {
    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.image_id
      }
    }

    network_interface {
      network_id         = "${yandex_vpc_network.network-1.id}"
      subnet_ids         = ["${yandex_vpc_subnet.subnet-1.id}"]
      #security_group_ids = ["${yandex_vpc_security_group.app_sg.id}"]
      nat        = true
    }

    metadata = {      
      ssh-keys = "${var.username}:${file(var.ssh_public_key_path)}"
      user-data = file("modules/task_2/nginx.yaml")
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]     
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name        = "group1"
    target_group_description = "Целевая группа Network Load Balancer"
  }
}


