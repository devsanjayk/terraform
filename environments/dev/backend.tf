terraform {
  backend "azurerm" {
    resource_group_name = "ci-app-tfstate-rg"
    storage_account_name = "tfstateci"
    container_name = "tfstate"
    key = "dev.tfstate"
  }
}