
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

  resourceGroupName = "basic-aks-rg"
  location          = "eastus"
  
  resourceName             = "basic-aks-cluster"
  managedNodeResourceGroup = "basic-aks-mrg"
  
  ingressApplicationGateway = false
  keyVaultCreate           = false
  keyVaultAksCSI           = false
}

output "kube_config" {
  value     = module.aks_cluster.kube_config
  sensitive = true
}

output "aks_cluster_name" {
  value = module.aks_cluster.aks_cluster_name
}
