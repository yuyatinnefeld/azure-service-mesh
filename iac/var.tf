variable "env" {
  type = string
}

variable "azure_storage_location" {
  type    = string
  default = "germanywestcentral"
}

variable "azure_storage_resource_group" {
  type    = string
  default = "storage-resource-group"
}

variable "azure_storage_account_name" {
  type = string
}

variable "azure_container_resouce_group" {
  type    = string
  default = "container-registry-resources"
}

variable "azure_container_registry_location" {
  type    = string
  default = "West Europe"
}

variable "azure_container_registry_name" {
  type = string
}

variable "azure_container_resource_group" {
  type = string
}

# Azure Service Principal
variable "ARM_TENANT_ID" {}
variable "ARM_SUBSCRIPTION_ID" {}
variable "ARM_CLIENT_ID" {}
variable "ARM_CLIENT_SECRET" {}
