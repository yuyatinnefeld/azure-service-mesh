resource "azurerm_container_registry" "acr" {
  name                = var.azure_container_registry_name
  resource_group_name = var.azure_resource_group
  location            = var.azure_project_location
  sku                 = "Premium"
  admin_enabled       = false

  georeplications {
    location                = var.azure_project_location
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "North Europe"
    zone_redundancy_enabled = true
    tags                    = {}
  }
}
