resource "azurerm_storage_account" "storage_account_analytics" {
  name                     = var.azure_storage_account_name
  resource_group_name      = var.azure_resource_group
  location                 = var.azure_project_location
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
