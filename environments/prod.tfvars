# Production Environment Configuration

# Resource Group
resourceGroupName = "ics-prod-aks-rg"
location = "eastus2"

# AKS Cluster
resourceName = "ics-prod-aks-cluster"
managedNodeResourceGroup = "ics-prod-aks-mrg"
SystemPoolType = "Standard_D4s_v3"
nodePoolName = "icsprodpool01"

# Network
authorizedIPRanges = ["10.61.6.32/27"]
ingressApplicationGateway = true

# Ingress Controller
ingressController = false
ingressControllerType = "nginx"
ingressControllerReplicas = 2

# Monitoring
omsagent = true
retentionInDays = 90

# Key Vault
keyVaultAksCSI = true
keyVaultCreate = true
keyVaultAksCSIPollInterval = "30m"

# DNS
dns_zone_name = "prod.apps.azure.incora.com"
environment = "prod"
