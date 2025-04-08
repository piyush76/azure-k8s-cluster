
output "resource_group_name" {
  value       = azurerm_resource_group.aks_rg.name
  description = "The name of the resource group"
}

output "resource_group_id" {
  value       = azurerm_resource_group.aks_rg.id
  description = "The ID of the resource group"
}
