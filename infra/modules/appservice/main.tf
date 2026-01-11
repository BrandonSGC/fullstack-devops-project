
# App Service Plan - For backend container
resource "azurerm_service_plan" "plan" {
  name                = var.plan_name
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

// App Service - For backend container
resource "azurerm_linux_web_app" "backend" {
  name                = var.appservice_name
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan.id

  # VNet Integration
  virtual_network_subnet_id = var.backend_subnet_id

  site_config {}

  identity {
    type         = "UserAssigned"
    identity_ids = [var.managed_identity_id]
  }

  depends_on = [azurerm_service_plan.plan]
}
