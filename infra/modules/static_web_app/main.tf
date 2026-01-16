# Static Web App to host the React frontend
resource "azurerm_static_web_app" "frontend" {
  name                = var.static_webapp_name
  resource_group_name = var.rg_name
  location            = var.location
  sku_tier            = var.sku_tier
  sku_size            = var.sku_size

  app_settings = {
    VITE_API_BASE_URL = var.API_BASE_URL
  }

  depends_on = [var.rg_name]
}
