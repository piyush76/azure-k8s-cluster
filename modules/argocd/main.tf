
provider "kubernetes" {
}

provider "helm" {
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
    labels = var.namespace_labels
  }
}

resource "helm_release" "argocd" {
  name       = var.release_name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  timeout    = var.helm_timeout
  atomic     = var.helm_atomic
  wait       = var.helm_wait

  set {
    name  = "server.service.type"
    value = var.server_service_type
  }

  dynamic "set" {
    for_each = var.server_service_type == "LoadBalancer" && var.server_service_annotations != {} ? [1] : []
    content {
      name  = "server.service.annotations"
      value = yamlencode(var.server_service_annotations)
    }
  }

  set {
    name  = "server.extraArgs"
    value = "{${join(",", [for k, v in var.server_extra_args : "\"${k}=${v}\""])}}"
  }

  dynamic "set" {
    for_each = var.admin_password != "" ? [1] : []
    content {
      name  = "configs.secret.argocdServerAdminPassword"
      value = var.admin_password_bcrypt ? var.admin_password : bcrypt(var.admin_password)
    }
  }

  set {
    name  = "controller.replicas"
    value = var.ha_enabled ? var.ha_controller_replicas : 1
  }

  set {
    name  = "server.replicas"
    value = var.ha_enabled ? var.ha_server_replicas : 1
  }

  set {
    name  = "repoServer.replicas"
    value = var.ha_enabled ? var.ha_repo_replicas : 1
  }

  set {
    name  = "applicationSet.replicas"
    value = var.ha_enabled ? var.ha_appset_replicas : 1
  }

  set {
    name  = "server.resources.limits.cpu"
    value = var.server_resources.limits.cpu
  }

  set {
    name  = "server.resources.limits.memory"
    value = var.server_resources.limits.memory
  }

  set {
    name  = "server.resources.requests.cpu"
    value = var.server_resources.requests.cpu
  }

  set {
    name  = "server.resources.requests.memory"
    value = var.server_resources.requests.memory
  }

  set {
    name  = "redis.enabled"
    value = var.ha_enabled
  }

  set {
    name  = "server.ingress.enabled"
    value = var.ingress_enabled
  }

  dynamic "set" {
    for_each = var.ingress_enabled ? [1] : []
    content {
      name  = "server.ingress.hosts[0]"
      value = var.ingress_hostname
    }
  }

  dynamic "set" {
    for_each = var.ingress_enabled && var.ingress_tls_enabled ? [1] : []
    content {
      name  = "server.ingress.tls[0].hosts[0]"
      value = var.ingress_hostname
    }
  }

  dynamic "set" {
    for_each = var.ingress_enabled && var.ingress_tls_enabled ? [1] : []
    content {
      name  = "server.ingress.tls[0].secretName"
      value = var.ingress_tls_secret_name
    }
  }

  dynamic "set" {
    for_each = var.ingress_enabled && var.ingress_annotations != {} ? [1] : []
    content {
      name  = "server.ingress.annotations"
      value = yamlencode(var.ingress_annotations)
    }
  }

  set {
    name  = "server.rbacConfig.policy\\.csv"
    value = var.rbac_policy
  }

  dynamic "set" {
    for_each = var.config_override
    content {
      name  = "server.config.${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.repositories
    content {
      name  = "configs.repositories.${set.key}.url"
      value = set.value.url
    }
  }

  dynamic "set" {
    for_each = {
      for k, v in var.repositories : k => v if lookup(v, "username", "") != "" && lookup(v, "password", "") != ""
    }
    content {
      name  = "configs.repositories.${set.key}.usernameSecret.name" 
      value = kubernetes_secret.repo_creds[set.key].metadata[0].name
    }
  }

  dynamic "set" {
    for_each = {
      for k, v in var.repositories : k => v if lookup(v, "username", "") != "" && lookup(v, "password", "") != ""
    }
    content {
      name  = "configs.repositories.${set.key}.usernameSecret.key"
      value = "username"
    }
  }

  dynamic "set" {
    for_each = {
      for k, v in var.repositories : k => v if lookup(v, "username", "") != "" && lookup(v, "password", "") != ""
    }
    content {
      name  = "configs.repositories.${set.key}.passwordSecret.name"
      value = kubernetes_secret.repo_creds[set.key].metadata[0].name
    }
  }

  dynamic "set" {
    for_each = {
      for k, v in var.repositories : k => v if lookup(v, "username", "") != "" && lookup(v, "password", "") != ""
    }
    content {
      name  = "configs.repositories.${set.key}.passwordSecret.key"
      value = "password"
    }
  }

  dynamic "set" {
    for_each = var.extra_set_values
    content {
      name  = set.key
      value = set.value
    }
  }

  values = var.values_file != "" ? [file(var.values_file)] : []
}

resource "kubernetes_secret" "repo_creds" {
  for_each = {
    for k, v in var.repositories : k => v if lookup(v, "username", "") != "" && lookup(v, "password", "") != ""
  }

  metadata {
    name      = "argocd-repo-creds-${each.key}"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }

  data = {
    username = each.value.username
    password = each.value.password
  }
}

resource "kubernetes_manifest" "applications" {
  for_each = var.applications

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = each.key
      namespace = kubernetes_namespace.argocd.metadata[0].name
      finalizers = ["resources-finalizer.argocd.argoproj.io"]
    }
    spec = each.value
  }

  depends_on = [helm_release.argocd]
}









