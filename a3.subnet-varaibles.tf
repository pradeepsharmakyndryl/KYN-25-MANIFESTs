variable "web_subnet_name" {
  description = "The name of the web subnet"
  type        = string
  default     = "web-subnet"

}

variable "web_subnet_address_prefix" {
  description = "The address prefix of the web subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]

}