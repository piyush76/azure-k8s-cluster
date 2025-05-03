resource "kubernetes_namespace" "ingress_system" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "ingress_controller" {
  name       = "${var.ingress_type}-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.chart_version
  namespace  = kubernetes_namespace.ingress_system.metadata[0].name

  set {
    name  = "controller.replicaCount"
    value = var.replica_count
  }

  set {
    name  = "controller.service.type"
    value = var.service_type
  }

  set {
    name  = "controller.ingressClassResource.name"
    value = var.ingress_type
  }

  set {
    name  = "controller.ingressClassResource.default"
    value = "true"
  }

  set {
    name  = "controller.resources.requests.cpu"
    value = var.cpu_request
  }

  set {
    name  = "controller.resources.requests.memory"
    value = var.memory_request
  }

  set {
    name  = "controller.resources.limits.cpu"
    value = var.cpu_limit
  }

  set {
    name  = "controller.resources.limits.memory"
    value = var.memory_limit
  }
}
