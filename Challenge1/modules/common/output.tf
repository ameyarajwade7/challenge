output "resource_group_name" {
    value = azurerm_resource_group.application.name
    description = "Name of the resource group."
}

output "location_id" {
    value = azurerm_resource_group.application.location
    description = "Location id of the resource group"
}


output "vnet_name" {
    value = azurerm_virtual_network.vnet01.name
    description = "Name of vnet"
}