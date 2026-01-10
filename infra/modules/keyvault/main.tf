# Fetch the current Azure client configuration
data "azurerm_client_config" "current" {}

# Create an Azure Key Vault
resource "azurerm_key_vault" "keyvault" {
  name                        = "kv-fullstack-${var.environment}-bgc3"
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  rbac_authorization_enabled  = true

  sku_name = "standard"
}
