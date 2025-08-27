resource "null_resource" "copy_ssh_key" {
  depends_on = [azurerm_linux_virtual_machine.jumpvm]
  connection {
    type = "ssh" #rdp
    #host will be the pip address of the jump vm
    host        = azurerm_linux_virtual_machine.jumpvm.public_ip_address
    user        = azurerm_linux_virtual_machine.jumpvm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }
  provisioner "file" {
    source = "ssh-keys/terraform-azure.pem"
    #we are uploading mysql dumps
    destination = "/tmp/terraform-azure.pem"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 400 /tmp/terraform-azure.pem"
    ]
  }
}