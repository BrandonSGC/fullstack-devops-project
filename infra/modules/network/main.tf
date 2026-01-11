# Terraform module for Azure Virtual Network and Subnets

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rg_name
}

# Subnet for backend App Service.
resource "azurerm_subnet" "backend" {
  name                 = "backend-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.backend_subnet_cidr]

  delegation {
    name = "backend-delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }

  # This is to avoid that Terraform can detect false diffs on every 
  # "terraform plan". We ignore changes to this field to prevent 
  # unnecessaryin-place updates and keep plans stable and idempotent.
  lifecycle {
    ignore_changes = [
      delegation[0].service_delegation[0].actions
    ]
  }
}

# Subnet for Database.
resource "azurerm_subnet" "db" {
  name                 = "db-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.db_subnet_cidr]

  delegation {
    name = "db-delegation"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
    }
  }

  # This is to avoid that Terraform can detect false diffs on every 
  # "terraform plan". We ignore changes to this field to prevent 
  # unnecessaryin-place updates and keep plans stable and idempotent.
  lifecycle {
    ignore_changes = [
      delegation[0].service_delegation[0].actions
    ]
  }
}
