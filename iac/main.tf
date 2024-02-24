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
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}

  tenant_id       = var.ARM_TENANT_ID       # ANALOG GCP ORGANIZATION_ID
  subscription_id = var.ARM_SUBSCRIPTION_ID # ANALOG GCP = PROJECT_ID
  client_id       = var.ARM_CLIENT_ID       # AZURE_APP_ID
  client_secret   = var.ARM_CLIENT_SECRET   # AZURE_SERVICE_PRINCIPAL_PASSWORD
}

module "storage_account" {
  source                     = "./modules/storage-account"
  azure_storage_account_name = var.azure_storage_account_name
  azure_bucket_location      = var.azure_bucket_location
  azure_resource_group       = var.azure_resource_group
}
