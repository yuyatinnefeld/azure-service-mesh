variable "azure_project_location" {
  type    = string
  default = "germanywestcentral"
}

variable "azure_resource_group" {
  type    = string
  default = "storage-resource-group-dev"
}

variable "azure_storage_account_name" {
  type = string
}

variable "azure_container_registry_name" {
  type = string
}


# Azure Service Principal
variable "ARM_TENANT_ID" {}
variable "ARM_SUBSCRIPTION_ID" {}
variable "ARM_CLIENT_ID" {}
variable "ARM_CLIENT_SECRET" {}
