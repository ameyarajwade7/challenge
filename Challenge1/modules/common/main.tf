resource "azurerm_resource_group" "application" {
  name     = var.name
  location = var.location
}

resource "azurerm_virtual_network" "vnet01" {
  name                = "vnet01"
  resource_group_name = azurerm_resource_group.application.name
  location            = var.location
  address_space       = [var.vnetcidr]
}