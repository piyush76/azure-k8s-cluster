terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id     # Service Principal App ID
  client_secret   = var.client_secret # Service Principal Password/Secret
}

provider "kubernetes" {
  host                   = module.aks.kube_config_host
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}
provider "helm" {
  kubernetes {
    host                   = module.aks.kube_config_host
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
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

  resource_group_name             = module.resource_group.resource_group_name
  location                        = var.location
  cluster_name                    = var.resourceName
  managed_node_resource_group     = var.managedNodeResourceGroup
  system_pool_type                = var.SystemPoolType
  node_pool_name                  = var.nodePoolName
  vnet_subnet_id                  = module.network.aks_subnet_id
  authorized_ip_ranges            = var.authorizedIPRanges
  ingress_application_gateway     = var.ingressApplicationGateway
  application_gateway_id          = module.network.application_gateway_id
  key_vault_aks_csi               = var.keyVaultAksCSI
  key_vault_aks_csi_poll_interval = var.keyVaultAksCSIPollInterval
  log_analytics_workspace_id      = module.monitoring.log_analytics_workspace_id
  omsagent                        = var.omsagent
  depends_on                      = [module.resource_group, module.network]
}

data "azurerm_container_registry" "existing" {
  name                = "incora"
  resource_group_name = "ics-containers"
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

module "argocd" {
  source = "./modules/argocd"
  namespace            = "argo"
  argocd_chart_version = "5.46.7"
  service_type         = "LoadBalancer"
}

module "ingress_controller" {
  count  = var.ingressController ? 1 : 0
  source = "./modules/ingress_controller"
  
  namespace           = "ingress-system"
  ingress_type        = var.ingressControllerType
  replica_count       = var.ingressControllerReplicas
  resource_group_name = module.resource_group.resource_group_name
  aks_cluster_id      = module.aks.cluster_id
  
  depends_on = [module.aks]
}

module "dns_zone" {
  count  = var.create_dns_zone ? 1 : 0
  source = "./modules/dns_zone"
  dns_zone_name       = var.dns_zone_name
  resource_group_name = module.resource_group.resource_group_name
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
  depends_on = [module.resource_group]
}

