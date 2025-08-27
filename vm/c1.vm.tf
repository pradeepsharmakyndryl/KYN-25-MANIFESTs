resource "azurerm_linux_virtual_machine" "webvm" {
  name                = "${local.resource_name_prefix}-webvm-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_F2"
  admin_username      = "azureuser"
  #when i attach the nic card it will get public ip private ip from subnet- when we attache wiuth the subnet nsg rule also will be applied
  network_interface_ids = [
    azurerm_network_interface.webvm_nic.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  tags        = local.project_tag
  custom_data = filebase64("${path.module}/app/app.sh")
}