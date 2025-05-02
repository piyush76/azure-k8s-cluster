# Output variables for ArgoCD Terraform module

output "argocd_namespace" {
  description = "The Kubernetes namespace where ArgoCD is deployed"
  value       = kubernetes_namespace.argocd.metadata[0].name
}

output "argocd_server_service_name" {
  description = "The name of the ArgoCD server service"
  value       = "${var.release_name}-server"
}

output "argocd_repo_server_service_name" {
  description = "The name of the ArgoCD repo server service"
  value       = "${var.release_name}-repo-server"
}

output "argocd_application_controller_service_name" {
  description = "The name of the ArgoCD application controller service"
  value       = "${var.release_name}-application-controller"
}

output "argocd_url" {
  description = "The URL where ArgoCD UI can be accessed"
  value       = var.ingress_enabled ? "https://${var.ingress_hostname}" : "Use kubectl port-forward to access the UI"
}

output "argocd_server_service_type" {
  description = "The service type used for ArgoCD server"
  value       = var.server_service_type
}

output "argocd_chart_version" {
  description = "The version of the ArgoCD Helm chart that was deployed"
  value       = var.chart_version
}

output "argocd_helm_release_name" {
  description = "The name of the Helm release for ArgoCD"
  value       = helm_release.argocd.name
}

output "argocd_helm_release_status" {
  description = "The status of the Helm release for ArgoCD"
  value       = helm_release.argocd.status
}

output "argocd_applications" {
  description = "The ArgoCD applications that were created"
  value       = keys(var.applications)
}

output "argocd_ha_enabled" {
  description = "Whether high availability is enabled for ArgoCD"
  value       = var.ha_enabled
}
