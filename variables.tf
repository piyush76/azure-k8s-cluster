
variable "resourceGroupName" {
  type        = string
  default     = "ics-dev-aks-rg"
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  default     = "centralus"
  description = "Azure region where resources will be created"
} 

variable "resourceName" {
  type        = string
  default     = "ics-dev-aks-cluster"
  description = "Name of the AKS cluster"
} 

variable "managedNodeResourceGroup" {
  type        = string
  default     = "ics-dev-aks-mrg"
  description = "Name of the resource group for managed AKS resources"
} 



variable "SystemPoolType" {
  type        = string
  default     = "Standard"
  description = "VM size for the system node pool"
} 

variable "nodePoolName" {
  type        = string
  default     = "icsdevpool01"
  description = "Name of the default node pool"
} 

variable "registries_sku" {
  type        = string
  default     = "Basic"
  description = "SKU for the Azure Container Registry"
} 

variable "omsagent" {
  type        = bool
  default     = true
  description = "Enable OMS agent for monitoring"
} 

variable "retentionInDays" {
  type        = number
  default     = 30
  description = "Log retention period in days"
} 

variable "authorizedIPRanges" {
  type        = list(string)
  default     = ["198.180.200.254/32"]
  description = "Authorized IP ranges for API server access"
} 

variable "ingressApplicationGateway" {
  type        = bool
  default     = true
  description = "Enable Application Gateway Ingress Controller"
} 

variable "keyVaultAksCSI" {
  type        = bool
  default     = true
  description = "Enable Key Vault CSI driver"
} 

variable "keyVaultCreate" {
  type        = bool
  default     = true
  description = "Create a new Key Vault"
} 

variable "keyVaultAksCSIPollInterval" {
  type        = string
  default     = "30m"
  description = "Poll interval for Key Vault CSI driver"
}
