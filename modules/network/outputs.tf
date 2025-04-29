
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

output "application_gateway_id" {
  value       = var.create_application_gateway ? azurerm_application_gateway.app_gateway[0].id : null
  description = "The ID of the Application Gateway"
}

output "application_gateway_name" {
  value       = var.create_application_gateway ? azurerm_application_gateway.app_gateway[0].name : null
  description = "The name of the Application Gateway"
}
