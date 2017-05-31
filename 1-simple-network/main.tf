resource "azurerm_resource_group" "production" {
  name     = "production"
  location = "West Europe"
}

resource "azurerm_virtual_network" "production" {
  name                = "production-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.production.location}"
  resource_group_name = "${azurerm_resource_group.production.name}"
}
