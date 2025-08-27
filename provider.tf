/*terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0" #this is required for the production environment
    }
  }
   backend "azurerm" {
    resource_group_name  = "gopal-terraform-vm" #replace this with your resource name
    storage_account_name = "terraformremotestategd" #replace this with your storage account name
    container_name       = "tfstate" #replace this your your container name
    key                  = "skyproject.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  #resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}*/