
variable "resourceGroupName" {
  type        = string
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
  description = "Azure region where resources will be created"
}

variable "resourceName" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "managedNodeResourceGroup" {
  type        = string
  description = "Name of the resource group for managed AKS resources"
}

variable "SystemPoolType" {
  type        = string
  description = "VM size for the system node pool"
}

variable "nodePoolName" {
  type        = string
  description = "Name of the default node pool"
}

variable "registries_sku" {
  type        = string
  default     = "Basic"
  description = "SKU for the Azure Container Registry"
}

variable "omsagent" {
  type        = bool
  description = "Enable OMS agent for monitoring"
}

variable "retentionInDays" {
  type        = number
  description = "Log retention period in days"
}

variable "authorizedIPRanges" {
  type        = list(string)
  description = "Authorized IP ranges for API server access"
}

variable "ingressApplicationGateway" {
  type        = bool
  description = "Enable Application Gateway Ingress Controller"
}

variable "ingressController" {
  type        = bool
  description = "Enable Kubernetes Ingress Controller (e.g., NGINX)"
}

variable "ingressControllerType" {
  type        = string
  description = "Type of Ingress Controller to deploy (nginx, traefik, etc.)"
}

variable "ingressControllerReplicas" {
  type        = number
  description = "Number of replicas for the Ingress Controller"
}

variable "keyVaultAksCSI" {
  type        = bool
  description = "Enable Key Vault CSI driver"
}

variable "keyVaultCreate" {
  type        = bool
  description = "Create a new Key Vault"
}

variable "keyVaultAksCSIPollInterval" {
  type        = string
  description = "Poll interval for Key Vault CSI driver"
}

variable "dns_zone_name" {
  type        = string
  description = "Name of the DNS zone to create"
}

variable "create_dns_zone" {
  type        = bool
  description = "Whether to create a DNS zone"
}

variable "environment" {
  type        = string
  description = "Environment name for tagging resources"
}


