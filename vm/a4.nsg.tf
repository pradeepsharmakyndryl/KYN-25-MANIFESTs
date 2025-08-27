resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${local.resource_name_prefix}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.project_tag
}

#this nsg need to be mapped with whom 
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.web_subnet.id #this is the subnet
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}
locals {
  web_nsg_rule_inbound = { #this is the name 
    #expression is alwyas in the key value format 
    "110" : "22", #priority is the key and port is the value
    "120" : "80",
    "130" : "443"
  }
}
#finally inside the nsg we will create rules open ports
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each                    = local.web_nsg_rule_inbound
  name                        = "Rule-port-${each.value}" #Rule-Port-22
  priority                    = each.key                  #110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value #22
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}
