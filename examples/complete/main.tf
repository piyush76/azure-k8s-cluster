
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "aks_cluster" {
  source = "../../"

  resourceGroupName = "example-aks-rg"
  location          = "eastus"
  
  resourceName             = "example-aks-cluster"
  managedNodeResourceGroup = "example-aks-mrg"
  SystemPoolType           = "Standard_DS2_v2"
  nodePoolName             = "systempool"
  
  registries_sku = "Basic"
  
  omsagent        = true
  retentionInDays = 30
  
  authorizedIPRanges = ["0.0.0.0/0"] # Replace with your IP range for production
  
  ingressApplicationGateway = true
  
  keyVaultAksCSI             = true
  keyVaultCreate             = true
  keyVaultAksCSIPollInterval = "30m"
}

output "kube_config" {
  value     = module.aks_cluster.kube_config
  sensitive = true
}

output "aks_cluster_name" {
  value = module.aks_cluster.aks_cluster_name
}

output "acr_login_server" {
  value = module.aks_cluster.acr_login_server
}
