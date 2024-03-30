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

module "storage_account" {
  source                       = "./modules/storage-account"
  env                          = var.env
  azure_storage_location       = var.azure_storage_location
  azure_storage_resource_group = var.azure_storage_resource_group
  azure_storage_account_name   = var.azure_storage_account_name
}

# module "container_registry" {
#   source                            = "./modules/container-registry"
#   env                               = var.env
#   azure_container_registry_name     = var.azure_container_registry_name
#   azure_container_registry_location = var.azure_container_registry_location
#   azure_container_resource_group    = var.azure_container_resource_group
#   depends_on                        = [module.storage_account]
# }

# module "aks_cluster" {
#   source                         = "./modules/aks-cluster"
#   env                            = var.env
#   azure_container_resource_group = var.azure_container_resource_group
#   azure_container_registry_name  = var.azure_container_registry_name
#   depends_on                     = [module.container_registry]
# }
