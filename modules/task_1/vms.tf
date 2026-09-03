

resource "yandex_compute_instance" "vm" {
  count = 2

  name        = format("%s-%d", var.instance_name, count.index) #Имя ВМ в облачной консоли  
  platform_id = "standard-v1"

  boot_disk {
    initialize_params {
        image_id = var.image_id 
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
    core_fraction = 20
  }

  scheduling_policy { preemptible = true } #прерываемая

  metadata = {
    ssh-keys = "tettatform:${file("~/.ssh/ter23062026.pub")}" #указание какой паблик-ключ установить на машину
  }
  
  provisioner "remote-exec" {
    inline = [
      # Сначала обновляем списки пакетов 
      "sudo apt update", 
      # Затем устанавливаем nginx без интерактивных запросов (-y) 
      "sudo DEBIAN_FRONTEND=noninteractive apt install -y nginx", 
      # Включаем автозапуск nginx при старте системы 
      "sudo systemctl enable nginx", 
      # На всякий случай убеждаемся, что он запущен 
      "sudo systemctl start nginx" 
      ]
    connection { 
      type = "ssh" 
      user = "tettatform" 
      private_key = file("~/.ssh/ter23062026") 
      host = self.network_interface.0.nat_ip_address # Берем публичный IP созданной ВМ       
    } 
  }
}





