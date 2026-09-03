
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

*/

resource "yandex_lb_network_load_balancer" "lb-1" {
  name = "network-load-balancer-1"

  listener {
    name = "network-load-balancer-1-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.ig-1.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        #path = "/index.html"
        path = "/"
      }
    }
  }
}