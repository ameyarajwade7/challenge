resource "azurerm_virtual_machine" "web-app" {
  name                  = "web-vm"
  location              = var.location
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = var.primary_admin
    admin_password = var.primary_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "main" {
  name                = "web-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.web-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_subnet" "web-subnet" {
  name                 = "web-subnet"
  virtual_network_name = var.vnet
  resource_group_name  = var.resource_group
  address_prefixes     = [var.websubnetcidr]
}

resource "azurerm_network_security_group" "server-nsg" {
  name                = "web-nsg"
  location            = var.location
  resource_group_name = var.resource_group

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
  subnet_id                 = azurerm_subnet.web-subnet.id
  network_security_group_id = azurerm_network_security_group.web-nsg.id
}