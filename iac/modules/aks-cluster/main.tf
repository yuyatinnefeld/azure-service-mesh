data "azurerm_container_registry" "acr" {
  name                = "container-registry-resources"
  resource_group_name = azurerm_resource_group.arg_container.name
}

resource "azurerm_kubernetes_cluster" "aks_cluster_1" {
  name                = "example-aks1"
  location            = var.azure_container_registry_location
  resource_group_name = var.azure_container_resource_group
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

resource "azurerm_role_assignment" "example" {
  principal_id                     = azurerm_kubernetes_cluster.aks_cluster_1.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
