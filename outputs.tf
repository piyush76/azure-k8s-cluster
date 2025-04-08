
output "resource_group_name" {
  value       = module.resource_group.resource_group_name
  description = "The name of the resource group"
}

output "aks_cluster_name" {
  value       = module.aks.cluster_name
  description = "The name of the AKS cluster"
}

output "aks_cluster_id" {
  value       = module.aks.cluster_id
  description = "The ID of the AKS cluster"
}

output "kube_config" {
  value       = module.aks.kube_config
  sensitive   = true
  description = "The kubeconfig for the AKS cluster"
}

output "acr_login_server" {
  value       = module.acr.acr_login_server
  description = "The login server URL for the Azure Container Registry"
}

output "key_vault_id" {
  value       = module.key_vault.key_vault_id
  description = "The ID of the Key Vault"
}

output "key_vault_uri" {
  value       = module.key_vault.key_vault_uri
  description = "The URI of the Key Vault"
}

output "log_analytics_workspace_id" {
  value       = module.monitoring.log_analytics_workspace_id
  description = "The ID of the Log Analytics workspace"
}
