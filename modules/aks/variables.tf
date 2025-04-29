
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

variable "managed_node_resource_group" {
  type        = string
  description = "Name of the resource group for managed AKS resources"
}



variable "system_pool_type" {
  type        = string
  default     = "Standard_DS2_v2"
  description = "VM size for the system node pool"
}

variable "node_pool_name" {
  type        = string
  default     = "systempool"
  description = "Name of the default node pool"
}

variable "vnet_subnet_id" {
  type        = string
  description = "ID of the subnet for AKS nodes"
}

variable "authorized_ip_ranges" {
  type        = list(string)
  default     = []
  description = "Authorized IP ranges for API server access"
}

variable "ingress_application_gateway" {
  type        = bool
  default     = false
  description = "Enable Application Gateway Ingress Controller"
}

variable "application_gateway_id" {
  type        = string
  default     = null
  description = "ID of the Application Gateway to use with AGIC"
}

variable "key_vault_aks_csi" {
  type        = bool
  default     = false
  description = "Enable Key Vault CSI driver"
}

variable "key_vault_aks_csi_poll_interval" {
  type        = string
  default     = "2m"
  description = "Poll interval for Key Vault CSI driver"
}

variable "omsagent" {
  type        = bool
  default     = false
  description = "Enable OMS agent for monitoring"
}

variable "log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "ID of the Log Analytics workspace for monitoring"
}

variable "acr_id" {
  type        = string
  default     = null
  description = "ID of the Azure Container Registry"
}

variable "create_additional_node_pool" {
  type        = bool
  default     = false
  description = "Create an additional user node pool"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the AKS resources"
}
