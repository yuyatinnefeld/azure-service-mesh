terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}

  tenant_id       = var.ARM_TENANT_ID       # ANALOG GCP ORGANIZATION_ID
  subscription_id = var.ARM_SUBSCRIPTION_ID # ANALOG GCP PROJECT_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET

}

resource "azurerm_storage_account" "storage_account_analytics" {
  name                     = var.azure_storage_account_name
  resource_group_name      = var.azure_resource_group
  location                 = var.azure_bucket_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.storage_account_analytics.name
  container_access_type = "private"
}

# module "container_registry" {
#   source                     = "./modules/container-registry"
# }

# module "aks_cluster" {
#   source                     = "./modules/aks-cluster"
# }
