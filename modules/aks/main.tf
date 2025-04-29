
resource "azurerm_kubernetes_cluster" "aks" {
  name                    = var.cluster_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.cluster_name
  node_resource_group     = var.managed_node_resource_group
  kubernetes_version      = null # Uses latest version by default
  private_cluster_enabled = false
  sku_tier                = "Free"

  default_node_pool {
    name           = var.node_pool_name
    vm_size        = var.system_pool_type
    vnet_subnet_id = var.vnet_subnet_id
    node_count     = 3
    max_pods       = 30
    os_disk_size_gb = 128
    type           = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "kubenet"
    pod_cidr       = "172.16.0.0/16"  # Internal pod network managed by Kubernetes
    service_cidr   = "10.0.0.0/16"    # Internal service network
    dns_service_ip = "10.0.0.10"      # Must be within service_cidr
  }

  dynamic "ingress_application_gateway" {
    for_each = var.ingress_application_gateway && var.application_gateway_id != null ? [1] : []
    content {
      gateway_id = var.application_gateway_id
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_aks_csi ? [1] : []
    content {
      secret_rotation_enabled  = true
      secret_rotation_interval = var.key_vault_aks_csi_poll_interval
    }
  }

  dynamic "oms_agent" {
    for_each = var.omsagent && var.log_analytics_workspace_id != null ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "user_node_pool" {
  count                = var.create_additional_node_pool ? 1 : 0
  name                 = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size              = "Standard_DS4_v2"  # Upgraded from DS2_v2 to DS4_v2 (8 vCPU, 28GB RAM)
  node_count           = 2
  max_pods             = 30
  vnet_subnet_id       = var.vnet_subnet_id
  os_disk_size_gb      = 128
  os_disk_type         = "Managed"
  node_labels          = {
    "nodepool-type" = "user"
    "environment"   = "production"
  }
  tags                 = var.tags
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  count                = var.acr_id != null ? 1 : 0
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  scope                = var.acr_id
  role_definition_name = "AcrPull"
}

resource "azurerm_role_assignment" "aks_network_contributor" {
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  scope                = var.vnet_subnet_id
  role_definition_name = "Network Contributor"
}
resource "azurerm_kubernetes_cluster_node_pool" "ci_node_pool" {
  name                 = "cipool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size              = "Standard_D8s_v3"  # 8 vCPU, 32GB RAM
  node_count           = 2
  # Remove enable_auto_scaling and related fields
  vnet_subnet_id       = var.vnet_subnet_id
  os_disk_size_gb      = 128
  os_disk_type         = "Managed"
  node_labels          = {
    "nodepool-type" = "ci"
    "workload"      = "harness-delegate"
    "environment"   = "production"
  }
  tags                 = var.tags
}
