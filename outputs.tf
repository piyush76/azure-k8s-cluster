
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
output "argocd_endpoint" {
  description = "The URL where ArgoCD UI can be accessed"
  value       = module.argocd.argocd_url
}
output "argocd_status" {
  description = "Status of ArgoCD Helm release"
  value       = module.argocd.argocd_helm_release_status
}
output "argocd_helm_release_name" {
  description = "Name of the ArgoCD Helm release"
  value       = module.argocd.argocd_helm_release_name
}
output "argocd_helm_release_status" {
  description = "Status of the ArgoCD Helm release"
  value       = module.argocd.argocd_helm_release_status
}
output "argocd_namespace" {
  description = "The Kubernetes namespace where ArgoCD is deployed"
  value       = module.argocd.argocd_namespace
}
output "argocd_server_service_name" {
  description = "The name of the ArgoCD server service"
  value       = module.argocd.argocd_server_service_name
}
output "argocd_repo_server_service_name" {
  description = "The name of the ArgoCD repo server service"
  value       = module.argocd.argocd_repo_server_service_name
}
output "argocd_application_controller_service_name" {
  description = "The name of the ArgoCD application controller service"
  value       = module.argocd.argocd_application_controller_service_name
}
output "argocd_ingress_host" {
  description = "The hostname configured for ArgoCD ingress"
  value       = module.argocd.argocd_ingress_host
}
output "argocd_chart_version" {
  description = "The version of the ArgoCD Helm chart that was deployed"
  value       = module.argocd.argocd_chart_version
}
output "argocd_url" {
  description = "The URL where ArgoCD UI can be accessed"
  value       = module.argocd.argocd_url
}

output "dns_zone_name" {
  value       = module.dns_zone.dns_zone_name
  description = "The name of the DNS zone"
}

output "dns_zone_name_servers" {
  value       = module.dns_zone.name_servers
  description = "The name servers for the DNS zone"
}



