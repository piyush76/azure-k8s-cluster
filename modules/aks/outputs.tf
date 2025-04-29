
output "cluster_id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "The ID of the AKS cluster"
}

output "cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "The name of the AKS cluster"
}

output "kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
  description = "The kubeconfig for the AKS cluster"
}

output "kube_config_host" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
  description = "The Kubernetes cluster server host"
}

output "client_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive   = true
  description = "The client certificate for the AKS cluster"
}

output "client_key" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive   = true
  description = "The client key for the AKS cluster"
}

output "cluster_ca_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive   = true
  description = "The cluster CA certificate for the AKS cluster"
}

output "identity_principal_id" {
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  description = "The principal ID of the system assigned identity of the AKS cluster"
}

output "kubelet_identity_object_id" {
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  description = "The object ID of the kubelet identity of the AKS cluster"
}
