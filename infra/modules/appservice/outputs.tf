# app service outputs
output "appservice_id" {
  value = azurerm_linux_web_app.backend.id
}

output "appservice_service_plan_id" {
  value = azurerm_service_plan.plan.id
}
