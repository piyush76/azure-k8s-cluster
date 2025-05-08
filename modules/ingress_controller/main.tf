resource "kubernetes_namespace" "ingress_system" {
  metadata {
    name = var.namespace
  }
}

resource "azurerm_kubernetes_cluster_extension" "ingress_nginx" {
  name                             = "ingress-nginx"
  cluster_id                       = var.aks_cluster_id
  extension_type                   = "microsoft.contoso/ingress-nginx"
  release_train                    = "stable"
  release_namespace                = kubernetes_namespace.ingress_system.metadata[0].name
  configuration_settings = {
    "controller.replicaCount"                = var.replica_count
    "controller.service.type"                = var.service_type
    "controller.ingressClassResource.name"   = var.ingress_type
    "controller.ingressClassResource.default" = "true"
    "controller.resources.requests.cpu"      = var.cpu_request
    "controller.resources.requests.memory"   = var.memory_request
    "controller.resources.limits.cpu"        = var.cpu_limit
    "controller.resources.limits.memory"     = var.memory_limit
  }

  depends_on = [
    kubernetes_namespace.ingress_system
  ]
}
