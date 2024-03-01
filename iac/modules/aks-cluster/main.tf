data "azurerm_resource_group" "arg_example" {
  name = var.azure_container_resource_group
}

data "azurerm_container_registry" "acr_example" {
  name                = var.azure_container_registry_name
  resource_group_name = var.azure_container_resource_group
}

resource "azurerm_kubernetes_cluster" "aks_example" {
  name                = "example-aks1"
  location            = data.azurerm_resource_group.arg_example.location
  resource_group_name = data.azurerm_resource_group.arg_example.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.env
  }
}

resource "azurerm_role_assignment" "ars_example" {
  principal_id                     = azurerm_kubernetes_cluster.aks_example.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.acr_example.id
  skip_service_principal_aad_check = true
}
