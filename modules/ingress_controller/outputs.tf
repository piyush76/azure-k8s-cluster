output "ingress_namespace" {
  description = "Namespace where the ingress controller is deployed"
  value       = kubernetes_namespace.ingress_system.metadata[0].name
}

output "ingress_service_name" {
  description = "Name of the ingress controller service"
  value       = "${var.ingress_type}-ingress-ingress-nginx-controller"
}

output "ingress_class_name" {
  description = "Name of the ingress class"
  value       = var.ingress_type
}
