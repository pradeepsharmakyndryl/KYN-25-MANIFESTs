locals {
  owner                = var.business_devision #sap
  environment          = var.environment       #dev
  resource_name_prefix = "${var.environment}-${var.business_devision}"
  #dev-sap
  project_tag = {                   #this is the name of the variable
    owner       = local.owner       #sap #against that varaible we can define multiple values i key value fomat
    environment = local.environment #dev
  }
}