
variable "cloud_id" {
  type    = string
  #default = "default-cloud_id"
}

variable "folder_id" {
  type    = string
  #default = "default-folder_id"
}

variable "instance_name" {
  type    = string
  default = "default-vm-name"
}

variable "image_id" {
  type    = string
  default = "fd819nnsamg64h4gup91" #убунту 24.04
}


variable "ssh_public_key_path" {
  type    = string
  default = "default_fssh_public_key_path"
}

variable "username" {
  type    = string
  default = "default_username"
}