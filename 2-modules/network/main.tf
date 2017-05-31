resource "azurerm_virtual_network" "main" {
  name                = "${var.name}"
  address_space       = ["${var.address_space}"]
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "${var.frontend_address_prefix}"
}

resource "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "${var.backend_address_prefix}"
}
