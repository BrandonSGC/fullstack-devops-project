# Specify the Azure Resource Group for this environment
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# Network module
module "network" {
  # Assign the correct path to the network module
  source = "../../modules/network"

  # Pass variables to the network module from our variables.tf file 
  # in this environment
  rg_name  = azurerm_resource_group.rg.name
  location = var.location

  # Pass additional variables required by the network module
  vnet_name           = "fullstack-vnet-dev"
  address_space       = ["10.0.0.0/16"]
  backend_subnet_cidr = "10.0.1.0/24"
  db_subnet_cidr      = "10.0.2.0/24"
}

# Keyvault module
module "keyvault" {
  source      = "../../modules/keyvault"
  rg_name     = azurerm_resource_group.rg.name
  location    = var.location
  name        = "prjctbgc"
  environment = "dev"
}

# Assign the "Key Vault Secrets Officer" role to the current user/service 
# principal for the Key Vault
data "azurerm_client_config" "current" {}
resource "azurerm_role_assignment" "kv_secrets_officer" {
  scope                = module.keyvault.keyvault_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Create a random password for the MySQL admin user
resource "random_password" "mysql_admin" {
  length  = 20
  special = true
}

# Store the MySQL admin password in Key Vault as a secret
resource "azurerm_key_vault_secret" "mysql_admin_password" {
  name         = "mysql-admin-password"
  value        = random_password.mysql_admin.result
  key_vault_id = module.keyvault.keyvault_id

  # Ensure the role assignment is created before storing the secret, 
  # so the deployment doesn't fail due to insufficient permissions
  depends_on = [
    azurerm_role_assignment.kv_secrets_officer
  ]
}

# MySQL module
module "mysql" {
  source = "../../modules/mysql"

  admin_username = "mysqladminuser"
  admin_password = random_password.mysql_admin.result
  server_name    = "mysql-server-bgcmnged-dev"
  rg_name        = azurerm_resource_group.rg.name
  location       = var.location

  # We access the db_subnet_id output from the network module
  delegated_subnet_id = module.network.db_subnet_id

  # Adding dependencies to avoid potential bug in the Azure provider,
  # where throws the error "Error: Provider produced inconsistent result
  # after apply", even though the resources are created successfully.
  depends_on = [module.network.db_subnet_id, azurerm_role_assignment.kv_secrets_officer]
}

# ACR module
module "container_registry" {
  source   = "../../modules/container_registry"
  acr_name = "acrprjctbgcdev"
  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  sku      = "Basic"
}

# Managed Identity module
module "managed_identity" {
  source                = "../../modules/managed_identity"
  rg_name               = azurerm_resource_group.rg.name
  location              = var.location
  managed_identity_name = "managed-identity-dev"
}

# App Service module
module "appservice" {
  source = "../../modules/appservice"

  rg_name             = azurerm_resource_group.rg.name
  location            = var.location
  plan_name           = "fullstack-plan-dev"
  appservice_name     = "fullstack-appservice-dev"
  os_type             = "Linux"
  sku_name            = "B1"
  backend_subnet_id   = module.network.backend_subnet_id
  managed_identity_id = module.managed_identity.managed_identity_id
}

# Static Web App module
module "static_web_app" {
  source = "../../modules/static_web_app"

  static_webapp_name = "fullstack-frontend-dev"
  rg_name            = azurerm_resource_group.rg.name
  location           = "eastus2"
  sku_tier           = "Free"
  sku_size           = "Free"
}
