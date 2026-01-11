variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

# CIDR = Classless Inter-Domain Routing
# Used to specify IP address ranges
variable "backend_subnet_cidr" {
  type = string
}
variable "db_subnet_cidr" {
  type = string
}
