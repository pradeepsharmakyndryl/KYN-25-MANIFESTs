resource "azurerm_network_interface" "jump_nic" {

  name = "jumpvm"
  #they name of the nic card will be webvm-vm-nic-bentley and webvm-vm-nic-audi
  #we are using each.key to get the key from the map variable
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jump_public_ip.id
  }
}