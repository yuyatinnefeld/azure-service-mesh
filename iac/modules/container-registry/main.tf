resource "azurerm_resource_group" "container_registry_resource_group" {
  name     = "container-registry-resources"
  location = "West Europe"
}

resource "azurerm_container_registry" "acr" {
  name                = var.azure_container_registry_name
  resource_group_name = azurerm_resource_group.container_registry_resource_group.name
  location            = azurerm_resource_group.container_registry_resource_group.location
  sku                 = "Premium"
  admin_enabled       = false

  georeplications {
    location                = "East US"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "North Europe"
    zone_redundancy_enabled = true
    tags                    = {}
  }
}
