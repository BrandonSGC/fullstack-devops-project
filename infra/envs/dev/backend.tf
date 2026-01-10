# This backend file is used to configure the remote state storage for Terraform in a development environment
# It uses Azure Blob Storage as the backend to store the state file securely

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-my-resources"
    storage_account_name = "mystgaccntbgc"
    container_name       = "terraform"
    key                  = "dev.terraform.tfstate"
  }
}
