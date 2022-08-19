provider "azurerm" {
  features {}
}

module "common" {
  source         = "./modules/common"
  name           = var.name
  location       = var.location
  vnetcidr       = var.vnetcidr
}

module "database" {
  source         = "./modules/database"
  location = module.common.location_id
  resource_group = module.common.resource_group_name
  vnet           = module.common.vnet_name
  dbsubnetcidr   = var.dbsubnetcidr
  primary_database_password = var.primary_database_password
  primary_database_admin = var.primary_database_admin
}

module "server-app" {
  source         = "./modules/server-app"
  location = module.common.location_id
  resource_group = module.common.resource_group_name
  vnet           = module.common.vnet_name
  serversubnetcidr   = var.serversubnetcidr
  primary_password = var.primary_password
  primary_admin = var.primary_password
}

module "web-app" {
  source         = "./modules/server-app"
  location = module.common.location_id
  resource_group = module.common.resource_group_name
  vnet           = module.common.vnet_name
  serversubnetcidr   = var.websubnetcidr
  primary_password = var.primary_password
  primary_admin = var.primary_password
}