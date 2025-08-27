variable "bastion_subnet_name" {
  description = "The name of the bastion subnet"
  type        = string
  default     = "AzureBastionSubnet"
  #bastion subnet name should be always AzureBastionSubnet
}

variable "bastion_subnet_address" {
  description = "this is the subnet address for bastion subnet"
  type        = list(string)
  default     = ["10.0.101.0/27"]
}