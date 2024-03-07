resource "azurerm_resource_group" "arg_example" {
  name     = var.azure_container_resource_group
  location = var.azure_container_registry_location
}

resource "azurerm_container_registry" "acr_example" {
  name                = var.azure_container_registry_name
  resource_group_name = azurerm_resource_group.arg_example.name
  location            = azurerm_resource_group.arg_example.location
  sku                 = "Premium"
  admin_enabled       = true

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
