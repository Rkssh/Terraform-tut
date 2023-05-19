resource "azurerm_resource_group" "testresources" {
  name     = "testresources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "myvnet" {
  name                = "myv-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.testresources.location
  resource_group_name = azurerm_resource_group.testresources.name
}

resource "azurerm_subnet" "mysubnet" {
  name                 = "mysubnet"
  resource_group_name  = azurerm_resource_group.testresources.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "mypublicip" {
  name                = "myTestPublicIp1"
  resource_group_name = azurerm_resource_group.testresources.name
  location            = azurerm_resource_group.testresources.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "mynic" {
  name                = "my-nic"
  location            = azurerm_resource_group.testresources.location
  resource_group_name = azurerm_resource_group.testresources.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mypublicip.id
  }
}

resource "azurerm_linux_virtual_machine" "myvml" {
  name                = "myvml"
  resource_group_name = azurerm_resource_group.testresources.name
  location            = azurerm_resource_group.testresources.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.mynic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.module}/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}