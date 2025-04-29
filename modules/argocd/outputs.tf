# Output variables for ArgoCD Terraform module

output "argocd_namespace" {
  description = "The Kubernetes namespace where ArgoCD is deployed"
  value       = kubernetes_namespace.argo.metadata[0].name
}

output "argocd_server_service_name" {
  description = "The name of the ArgoCD server service"
  value       = "${var.release_name}-argocd-server"
}

output "argocd_repo_server_service_name" {
  description = "The name of the ArgoCD repo server service"
  value       = "${var.release_name}-argocd-repo-server"
}

output "argocd_application_controller_service_name" {
  description = "The name of the ArgoCD application controller service"
  value       = "${var.release_name}-argocd-application-controller"
}

output "argocd_url" {
  description = "The URL where ArgoCD UI can be accessed"
  value       = "https://${kubernetes_ingress_v1.argocd.spec[0].rule[0].host}"
}

output "argocd_ingress_host" {
  description = "The hostname configured for ArgoCD ingress"
  value       = kubernetes_ingress_v1.argocd.spec[0].rule[0].host
}

output "argocd_chart_version" {
  description = "The version of the ArgoCD Helm chart that was deployed"
  value       = var.argocd_chart_version
}

output "argocd_helm_release_name" {
  description = "The name of the Helm release for ArgoCD"
  value       = helm_release.argocd.name
}

output "argocd_helm_release_status" {
  description = "The status of the Helm release for ArgoCD"
  value       = helm_release.argocd.status
}