output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "backend_subnet_id" {
  value = azurerm_subnet.backend.id
}

output "db_subnet_id" {
  value = azurerm_subnet.db.id
}
