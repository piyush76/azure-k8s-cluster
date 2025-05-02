
variable "resourceGroupName" {
  type        = string
  default     = "ics-dev-aks-rg"
  description = "Name of the resource group"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}
variable "client_id" {
  description = "Azure Service Principal App ID"
  type        = string
}

variable "client_secret" {
  description = "Azure Service Principal Secret"
  type        = string
  sensitive   = true
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
  default     = "Standard_DS2_v2"
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
  default     = ["10.61.6.32/27"]
  description = "Authorized IP ranges for API server access"
}

variable "ingressApplicationGateway" {
  type        = bool
  default     = true
  description = "Enable Application Gateway Ingress Controller"
}

variable "ingressController" {
  type        = bool
  default     = false
  description = "Enable Kubernetes Ingress Controller (e.g., NGINX)"
}

variable "ingressControllerType" {
  type        = string
  default     = "nginx"
  description = "Type of Ingress Controller to deploy (nginx, traefik, etc.)"
}

variable "ingressControllerReplicas" {
  type        = number
  default     = 2
  description = "Number of replicas for the Ingress Controller"
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

variable "dns_zone_name" {
  type        = string
  default     = "dev.apps.azure.incora.com"
  description = "Name of the DNS zone to create"
}
variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment name for tagging resources"
}


