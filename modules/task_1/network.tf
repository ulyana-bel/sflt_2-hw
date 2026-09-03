

resource "yandex_vpc_network" "network1" {
  name = "network1"
}


resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"  
  v4_cidr_blocks = ["172.24.8.0/24"]
  network_id     = yandex_vpc_network.network1.id  
}



