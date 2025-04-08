
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be created"
}

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "registries_sku" {
  type        = string
  default     = "Basic"
  description = "SKU for the Azure Container Registry"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the ACR resources"
}
