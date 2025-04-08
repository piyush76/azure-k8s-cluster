
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

module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resourceGroupName
  location            = var.location
}

module "network" {
  source = "./modules/network"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  cluster_name        = var.resourceName
  depends_on          = [module.resource_group]
}

module "aks" {
  source = "./modules/aks"

  resource_group_name        = module.resource_group.resource_group_name
  location                   = var.location
  cluster_name               = var.resourceName
  managed_node_resource_group = var.managedNodeResourceGroup
  system_pool_type           = var.SystemPoolType
  node_pool_name             = var.nodePoolName
  vnet_subnet_id             = module.network.aks_subnet_id
  authorized_ip_ranges       = var.authorizedIPRanges
  ingress_application_gateway = var.ingressApplicationGateway
  application_gateway_id     = module.network.application_gateway_id
  key_vault_aks_csi          = var.keyVaultAksCSI
  key_vault_aks_csi_poll_interval = var.keyVaultAksCSIPollInterval
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
  omsagent                   = var.omsagent
  depends_on                 = [module.resource_group, module.network]
}

module "acr" {
  source = "./modules/acr"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  cluster_name        = var.resourceName
  registries_sku      = var.registries_sku
  depends_on          = [module.resource_group]
}

module "key_vault" {
  source = "./modules/key_vault"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  cluster_name        = var.resourceName
  create_key_vault    = var.keyVaultCreate
  depends_on          = [module.resource_group, module.aks]
}

module "monitoring" {
  source = "./modules/monitoring"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  cluster_name        = var.resourceName
  retention_in_days   = var.retentionInDays
  depends_on          = [module.resource_group]
}
