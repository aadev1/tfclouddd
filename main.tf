provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "diamond_dogs" {
  name     = "${var.prefix}-rg"
  location = var.region
}

resource "azurerm_virtual_network" "diamond_dogs" {
  name                = "${var.prefix}-vnet"
  address_space       = [var.address_space]
  location            = azurerm_resource_group.diamond_dogs.location
  resource_group_name = azurerm_resource_group.diamond_dogs.name

  tags = {
    environment = var.environment
  }
}

# resource "azurerm_subnet" "diamond_dogs" {
#   name                 = "${var.prefix}-subnet"
#   resource_group_name  = azurerm_resource_group.diamond_dogs.name
#   virtual_network_name = azurerm_virtual_network.diamond_dogs.name
#   address_prefixes     = [var.subnet_prefix]
# }

# resource "azurerm_network_security_group" "diamond_dogs" {
#   name                = "${var.prefix}-nsg"
#   location            = azurerm_resource_group.diamond_dogs.location
#   resource_group_name = azurerm_resource_group.diamond_dogs.name

#   security_rule {
#     name                       = "allow-http"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "80"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "allow-https"
#     priority                   = 101
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "443"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "allow-all-outbound"
#     priority                   = 102
#     direction                  = "Outbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   tags = {
#     environment = var.environment
#   }
# }

# resource "azurerm_public_ip" "diamond_dogs" {
#   name                = "${var.prefix}-public-ip"
#   location            = azurerm_resource_group.diamond_dogs.location
#   resource_group_name = azurerm_resource_group.diamond_dogs.name
#   allocation_method   = "Dynamic"

#   tags = {
#     environment = var.environment
#   }
# }

# resource "azurerm_network_interface" "diamond_dogs" {
#   name                = "${var.prefix}-nic"
#   location            = azurerm_resource_group.diamond_dogs.location
#   resource_group_name = azurerm_resource_group.diamond_dogs.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.diamond_dogs.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.diamond_dogs.id
#   }

#   tags = {
#     environment = var.environment
#   }
# }

# resource "azurerm_virtual_machine" "diamond_dogs" {
#   name                  = "${var.prefix}-vm"
#   location              = azurerm_resource_group.diamond_dogs.location
#   resource_group_name   = azurerm_resource_group.diamond_dogs.name
#   network_interface_ids = [azurerm_network_interface.diamond_dogs.id]
#   vm_size               = var.instance_type

#   storage_os_disk {
#     name              = "${var.prefix}-os-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }

#   os_profile {
#     computer_name  = "${var.prefix}-vm"
#     admin_username = var.admin_username
#     admin_password = var.admin_password
#   }

#   os_profile_linux_config {
#     disable_password_authentication = false
#   }

#   tags = {
#     environment = var.environment
#   }
# }