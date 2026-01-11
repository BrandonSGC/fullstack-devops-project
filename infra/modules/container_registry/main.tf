resource "azurerm_container_registry" "container_registry" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false
}
