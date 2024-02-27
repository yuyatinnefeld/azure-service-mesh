resource "azurerm_resource_group" "container_resources" {
  name     = "container-registry-resources"
  location = "West Europe"
}

resource "azurerm_container_registry" "acr" {
  name                = var.azure_container_registry_name
  resource_group_name = azurerm_resource_group.container_resources.name
  location            = azurerm_resource_group.container_resources.location
  sku                 = "Premium"
  admin_enabled       = false

  georeplications {
    location                = "East US"
    zone_redundancy_enabled = true
    tags = {
      environment = var.env
    }
  }
  georeplications {
    location                = "North Europe"
    zone_redundancy_enabled = true
    tags = {
      environment = var.env
    }
  }
}
