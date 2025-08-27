resource "azurerm_network_interface" "webvm_nic" {
  name                = "${local.resource_name_prefix}-webvm-vm-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webvm_public_ip.id
  }
}