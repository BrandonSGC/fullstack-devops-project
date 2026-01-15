output "mysql_hostname" {
  value = azurerm_mysql_flexible_server.mysql_server.fqdn
}

output "mysql_db_name" {
  value = azurerm_mysql_flexible_database.db.name
}
