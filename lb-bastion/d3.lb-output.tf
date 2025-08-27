#this output we are driving from the public ip 
output "web_lb_public_ip" {
  description = "this is the pu8blic ip of the lb"
  value       = azurerm_public_ip.lb_public_ip.ip_address
}

#this output we are driving from the lb 
output "web_lb_frontend_ip" {
  description = "this is the id of the lb"
  value       = [azurerm_lb.azurelb.frontend_ip_configuration]
}