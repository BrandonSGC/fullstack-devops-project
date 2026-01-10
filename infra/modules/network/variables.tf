variable "rg_name" {}
variable "location" {}

variable "vnet_name" {}
variable "address_space" {
  type = list(string)
}

# CIDR = Classless Inter-Domain Routing
# Used to specify IP address ranges
variable "backend_subnet_cidr" {}
variable "db_subnet_cidr" {}
