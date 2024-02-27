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
  source                     = "./modules/storage-account"
  azure_project_location     = var.azure_project_location
  azure_resource_group       = var.azure_resource_group
  azure_storage_account_name = var.azure_storage_account_name

}

# module "container_registry" {
#   source                        = "./modules/container-registry"
#   azure_project_location        = var.azure_project_location
#   azure_resource_group          = var.azure_resource_group
#   azure_container_registry_name = var.azure_container_registry_name
# }

# module "aks_cluster" {
#   source                     = "./modules/aks-cluster"
# }
