variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string #map list of string
  #in string variable we can define only one single value
  default = "rg-gopal"
}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "dev"

}

variable "business_devision" {
  description = "The business unit for the resources"
  type        = string
  default     = "sap"

}