
output "log_analytics_workspace_id" {
  value       = azurerm_log_analytics_workspace.aks.id
  description = "The ID of the Log Analytics workspace"
}

output "log_analytics_workspace_name" {
  value       = azurerm_log_analytics_workspace.aks.name
  description = "The name of the Log Analytics workspace"
}

output "log_analytics_workspace_primary_key" {
  value       = azurerm_log_analytics_workspace.aks.primary_shared_key
  sensitive   = true
  description = "The primary shared key of the Log Analytics workspace"
}
