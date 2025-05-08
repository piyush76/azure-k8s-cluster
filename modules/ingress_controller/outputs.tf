output "ingress_namespace" {
  description = "Namespace where the ingress controller is deployed"
  value       = kubernetes_namespace.ingress_system.metadata[0].name
}

output "ingress_service_name" {
  description = "Name of the ingress controller service"
  value       = "azure-nginx-ingress-controller"
}

output "ingress_class_name" {
  description = "Name of the ingress class"
  value       = var.ingress_type
}

output "ingress_extension_id" {
  description = "ID of the Azure Managed NGINX Ingress Controller extension"
  value       = azurerm_kubernetes_cluster_extension.ingress_nginx.id
}

output "ingress_extension_name" {
  description = "Name of the Azure Managed NGINX Ingress Controller extension"
  value       = azurerm_kubernetes_cluster_extension.ingress_nginx.name
}
