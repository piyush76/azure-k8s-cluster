
resource "kubernetes_namespace" "argo" {
  metadata {
    name = var.namespace
    labels = merge(
      var.labels,
      {
        "app.kubernetes.io/name" = "argocd"
        "app.kubernetes.io/part-of" = "argocd"
      }
    )
  }
  }

/*resource "azurerm_dns_a_record" "argocd" {
  name                = "argocd"
  zone_name           = "argocd.incoraics.com"
  resource_group_name = "my-dns-rg" ## Change to your DNS resource group currently not create for Incora ICS
  ttl                 = 300
  records             = ["64.236.68.84"]  # Use data lookup if dynamic
}*/

# Install ArgoCD using Helm
resource "helm_release" "argocd" {
  name       = var.release_name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_chart_version
  namespace  = kubernetes_namespace.argo.metadata[0].name

  values = [
    templatefile("${path.module}/argocd-values.yaml", {
      service_type = var.service_type
      insecure    = var.insecure
      server_resources = var.server_resources
      controller_resources = var.controller_resources
      repo_server_resources = var.repo_server_resources
      enable_ha = var.enable_ha
      argocd_url = var.argocd_url
      azure_client_id = var.azure_client_id
      azure_client_secret = var.azure_client_secret
      azure_tenant_id = var.azure_tenant_id
    })
  ]

  set {
    name  = "crds.install"
    value = "false"
  }

  dynamic "set" {
    for_each = var.helm_values
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.helm_sensitive_values
    content {
      name  = set_sensitive.value.name
      value = set_sensitive.value.value
    }
  }
  wait = var.wait_for_deployment
  timeout = var.timeout
  atomic     = false

  depends_on = [kubernetes_namespace.argo]

}
resource "kubernetes_ingress_v1" "argocd" {
  metadata {
    name      = "argocd-ingress"
    namespace = "argo"
    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
    }
  }

  spec {
    rule {
      host = "argocd.incoraics.com"

      http {
        path {
          path     = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "argocd-server"
              port {
                number = 443
              }
            }
          }
        }
      }
    }

    tls {
      hosts = ["argocd.incoraics.com"]
      secret_name = "argocd-tls"
    }
  }
}









