#this will create my load balancer 
#so this block created lb and attach an frontend ip configuration with public ip
resource "azurerm_lb" "azurelb" {
  name                = "${local.resource_name_prefix}-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  frontend_ip_configuration {
    name = "PublicIPAddress"
    #once the lb is created we need to attach the public ip 
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

#lets create the backend address pool and attach the same with lb 
resource "azurerm_lb_backend_address_pool" "lb_back_end_pool" {
  loadbalancer_id = azurerm_lb.azurelb.id
  name            = "BackEndAddressPool"
}

#let creat the healthcheckup
resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.azurelb.id
  name            = "frontend-probe"
  protocol        = "Tcp"
  #protocol = "Http"
  #the probe it is going to check the port 80
  port = 80
  #but i have a web page in a differnet path 
  # request_path = "/var/www/html/app/index.html"
  interval_in_seconds = 30
  number_of_probes    = 2 # 1 min 
}

#we will create lb rule 
resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.azurelb.id
  name                           = "lbRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80 #8080
  frontend_ip_configuration_name = azurerm_lb.azurelb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_back_end_pool.id]
  probe_id                       = azurerm_lb_probe.lb_probe.id
}

#we will attach both the nic card to the backend pool
resource "azurerm_network_interface_backend_address_pool_association" "nic_association" {
  for_each                = var.dasauto
  network_interface_id    = azurerm_network_interface.webvm_nic[each.key].id
  ip_configuration_name   = azurerm_network_interface.webvm_nic[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_back_end_pool.id
}