# Static Web App to host the React frontend
resource "azurerm_static_web_app" "frontend" {
  name                = var.static_webapp_name
  resource_group_name = var.rg_name
  location            = var.location
  sku_tier            = var.sku_tier
  sku_size            = var.sku_size

  # Ignore changes to repository URL and GitHub branch
  lifecycle {
    ignore_changes = [
      repository_url,
      repository_branch
    ]
  }

  depends_on = [var.rg_name]
}
