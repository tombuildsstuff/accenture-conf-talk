variable "admin_username" {
  default = "talkuser"
}

variable "admin_password" {
  default = "P@ssW0r1d73"
}

resource "azurerm_resource_group" "main" {
  name     = "example-rg"
  location = "West Europe"
}

module "network" {
  source                  = "./network"
  name                    = "production-network"
  resource_group_name     = "${azurerm_resource_group.main.name}"
  location                = "${azurerm_resource_group.main.location}"
  address_space           = "10.0.0.0/16"
  backend_address_prefix  = "10.0.2.0/24"
  frontend_address_prefix = "10.0.3.0/24"
}

module "frontend_virtual_machine" {
  source              = "./ubuntu-vm"
  name                = "frontend-vm"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  subnet_id           = "${module.network.frontend_subnet_id}"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  ssh_key             = "${file("~/.ssh/id_rsa.pub")}"
}

module "backend_virtual_machine" {
  source              = "./ubuntu-vm"
  name                = "backend-vm"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  subnet_id           = "${module.network.backend_subnet_id}"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  ssh_key             = "${file("~/.ssh/id_rsa.pub")}"
}
