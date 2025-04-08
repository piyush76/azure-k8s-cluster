
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
    node_count     = 1
    max_pods       = 30
    os_disk_size_gb = 128
    type           = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "calico"
  }

  api_server_authorized_ip_ranges = var.authorized_ip_ranges

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
  vm_size              = "Standard_DS2_v2"
  node_count           = 1
  max_pods             = 30
  vnet_subnet_id       = var.vnet_subnet_id
  os_disk_size_gb      = 128
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
