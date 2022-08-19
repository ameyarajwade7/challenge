resource "azurerm_mssql_server" "example" {
  name                         = "example-sqlserver"
  resource_group_name = var.resource_group
  location = var.location
  administrator_login = var.primary_database_admin
  administrator_login_password = var.primary_database_password
  version                      = "12.0"
  
}

resource "azurerm_mssql_database" "test" {
  name           = "acctest-db-d"
  server_id      = azurerm_mssql_server.example.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true

}

resource "azurerm_subnet" "db-subnet" {
  name                 = "db-subnet"
  virtual_network_name = var.vnet
  resource_group_name  = var.resource_group
  address_prefixes     = [var.dbsubnetcidr]
}

resource "azurerm_network_security_group" "db-nsg" {
  name                = "db-nsg"
  location            = var.resource_group
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.db-subnet.id
  network_security_group_id = azurerm_network_security_group.db-nsg.id
}