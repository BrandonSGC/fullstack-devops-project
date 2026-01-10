# Specify the Azure Resource Group for this environment
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

module "network" {
  # Assign the correct path to the network module
  source = "../../modules/network"

  # Pass variables to the network module from our variables.tf file in this environment
  rg_name  = azurerm_resource_group.rg.name
  location = var.location

  # Pass additional variables required by the network module
  vnet_name           = "fullstack-vnet-dev"
  address_space       = ["10.0.0.0/16"]
  backend_subnet_cidr = "10.0.1.0/24"
  db_subnet_cidr      = "10.0.2.0/24"
}
