
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

  site_config {
    # Enable Managed Identity to pull from ACR
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = var.managed_identity_client_id
  }

  app_settings = {
    # Adding setting to disable App Service storage for Linux 
    # containers so we dont have issues with terraform updating
    # the App Service every time we deploy even with no real changes.
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"

    "DB_HOST"     = var.DB_HOST
    "DB_USER"     = var.DB_USER
    "DB_PASSWORD" = var.DB_PASSWORD
    "DB_NAME"     = var.DB_NAME
    "DB_PORT"     = var.DB_PORT
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.managed_identity_id]
  }

  depends_on = [azurerm_service_plan.plan]
}
