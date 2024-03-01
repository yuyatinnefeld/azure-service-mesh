resource "azurerm_resource_group" "arg_container" {
  name     = var.azure_container_resource_group
  location = var.azure_container_registry_location
}

resource "azurerm_container_registry" "acr" {
  name                = var.azure_container_registry_name
  resource_group_name = azurerm_resource_group.arg_container.name
  location            = azurerm_resource_group.arg_container.location
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
