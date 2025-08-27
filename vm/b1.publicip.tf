resource "azurerm_public_ip" "webvm_public_ip" {
  name                = "${local.resource_name_prefix}-webvm-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard" #basic #premium
  tags                = local.project_tag
}