variable "name" {}

variable "location" {}

variable "resource_group_name" {}

variable "subnet_id" {}

variable "size" {
  default = "Standard_F2"
}

variable "admin_username" {}
variable "admin_password" {}
variable "ssh_key" {}
