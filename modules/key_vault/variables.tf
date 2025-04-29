
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

variable "create_key_vault" {
  type        = bool
  default     = true
  description = "Whether to create a Key Vault"
}

variable "aks_identity_principal_id" {
  type        = string
  default     = null
  description = "Principal ID of the AKS cluster identity"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the Key Vault resources"
}
