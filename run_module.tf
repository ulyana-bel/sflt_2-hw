# Не врубать оба!!! Только один. Если простартовано сначала завершиться со старым. Пальцы в розетку не совать...  
/*
module "task_1" { 
    source = "./modules/task_1" 
    instance_name = "vm" 
    cloud_id = var.cloud_id
    folder_id = var.folder_id    
    image_id = var.image_id
    }
*/
  

module "task_2" { 
    source = "./modules/task_2" 
    instance_name = "group" 
    cloud_id = var.cloud_id
    folder_id = var.folder_id    
    image_id = var.image_id
    
    ssh_public_key_path = var.ssh_public_key_path
    username = var.username

    }
