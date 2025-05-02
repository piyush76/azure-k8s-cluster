# Development Environment Configuration

# Resource Group
resourceGroupName = "ics-dev-aks-rg"
location = "centralus"

# AKS Cluster
resourceName = "ics-dev-aks-cluster"
managedNodeResourceGroup = "ics-dev-aks-mrg"
SystemPoolType = "Standard_DS2_v2"
nodePoolName = "icsdevpool01"

# Network
authorizedIPRanges = ["10.61.6.32/27"]
ingressApplicationGateway = false

# Ingress Controller
ingressController = true
ingressControllerType = "nginx"
ingressControllerReplicas = 2

# Monitoring
omsagent = true
retentionInDays = 30

# Key Vault
keyVaultAksCSI = true
keyVaultCreate = true
keyVaultAksCSIPollInterval = "30m"

# DNS
dns_zone_name = "dev.apps.azure.incora.com"
environment = "dev"
