resource "azurerm_storage_account" "storage_example_bucket" {
  name                     = "${var.azure_storage_account_name}${var.env}"
  resource_group_name      = "${var.azure_resource_group}-${var.env}"
  location                 = var.azure_project_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = var.env
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.storage_example_bucket.name
  container_access_type = "private"
}
