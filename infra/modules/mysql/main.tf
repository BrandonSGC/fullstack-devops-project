# Terraform Module to deploy MySQL Flexible Server

// MySQL Server
resource "azurerm_mysql_flexible_server" "mysql_server" {
  name                = var.server_name
  resource_group_name = var.rg_name
  location            = var.location

  administrator_login    = var.admin_username
  administrator_password = var.admin_password

  delegated_subnet_id   = var.delegated_subnet_id
  backup_retention_days = 7
  sku_name              = "B_Standard_B1ms"
  version               = "8.0.21"
}
