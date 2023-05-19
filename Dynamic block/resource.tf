resource "azurerm_resource_group" "securitygp" {
  name     = "security-resources"
  location = "West Europe"
}

locals {
  security_rule = [
    { name = "deep"
      port = 80
    priority = 100 },
    { name = "singh"
      port = 22
    priority = 101 },
    { name = "dipu"
      port = 443
    priority = 102 }

  ]
}

resource "azurerm_network_security_group" "deepbhaiya" {
  name                = "SecurityGroup1"
  location            = azurerm_resource_group.securitygp.location
  resource_group_name = azurerm_resource_group.securitygp.name

  dynamic "security_rule" {
    for_each = local.security_rule
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = security_rule.value.port
      destination_port_range     = security_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

  }
  tags = {
    environment = "Production"
  }
}

output "security_rule" {
    value = azurerm_network_security_group.deepbhaiya.security_rule
  
}