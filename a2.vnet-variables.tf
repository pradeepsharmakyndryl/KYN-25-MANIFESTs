variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "kyn-vnet"

}
variable "vnet_address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}