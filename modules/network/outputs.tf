
output "vnet_id" {
  value       = azurerm_virtual_network.aks_vnet.id
  description = "The ID of the virtual network"
}

output "vnet_name" {
  value       = azurerm_virtual_network.aks_vnet.name
  description = "The name of the virtual network"
}

output "aks_subnet_id" {
  value       = azurerm_subnet.aks_subnet.id
  description = "The ID of the AKS subnet"
}

output "secondary_subnet_id" {
  value       = azurerm_subnet.secondary_subnet.id
  description = "The ID of the secondary subnet"
}
