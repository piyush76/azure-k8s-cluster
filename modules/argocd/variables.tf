variable "namespace" {
  description = "Namespace for ArgoCD deployment"
  type        = string
  default     = "argo"
}

variable "namespace_labels" {
  description = "Labels to add to the ArgoCD namespace"
  type        = map(string)
  default     = {
    "app.kubernetes.io/name" = "argocd"
    "app.kubernetes.io/part-of" = "argocd"
  }
}

variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "Version of the ArgoCD Helm chart"
  type        = string
  default     = "5.46.7"  # Use a specific version for stability
}

variable "helm_timeout" {
  description = "Timeout for Helm operations in seconds"
  type        = number
  default     = 900
}

variable "helm_atomic" {
  description = "Whether to use atomic installation for Helm"
  type        = bool
  default     = false
}

variable "helm_wait" {
  description = "Whether to wait for resources to be ready"
  type        = bool
  default     = true
}

variable "server_service_type" {
  description = "Kubernetes service type for ArgoCD server"
  type        = string
  default     = "ClusterIP"
}

variable "server_service_annotations" {
  description = "Annotations for the ArgoCD server service"
  type        = map(string)
  default     = {}
}

variable "server_extra_args" {
  description = "Extra arguments for the ArgoCD server"
  type        = map(string)
  default     = {
    "insecure" = "true"
  }
}

variable "admin_password" {
  description = "Admin password for ArgoCD"
  type        = string
  default     = ""
  sensitive   = true
}

variable "admin_password_bcrypt" {
  description = "Whether the admin password is already bcrypt hashed"
  type        = bool
  default     = false
}

variable "ha_enabled" {
  description = "Enable high availability for ArgoCD"
  type        = bool
  default     = false
}

variable "ha_controller_replicas" {
  description = "Number of controller replicas when HA is enabled"
  type        = number
  default     = 2
}

variable "ha_server_replicas" {
  description = "Number of server replicas when HA is enabled"
  type        = number
  default     = 2
}

variable "ha_repo_replicas" {
  description = "Number of repo server replicas when HA is enabled"
  type        = number
  default     = 2
}

variable "ha_appset_replicas" {
  description = "Number of applicationset controller replicas when HA is enabled"
  type        = number
  default     = 2
}

variable "server_resources" {
  description = "Resources for ArgoCD server"
  type = object({
    limits = object({
      cpu    = string
      memory = string
    })
    requests = object({
      cpu    = string
      memory = string
    })
  })
  default = {
    limits = {
      cpu    = "500m"
      memory = "512Mi"
    }
    requests = {
      cpu    = "250m"
      memory = "256Mi"
    }
  }
}

variable "ingress_enabled" {
  description = "Enable ingress for ArgoCD server"
  type        = bool
  default     = false
}

variable "ingress_hostname" {
  description = "Hostname for ArgoCD ingress"
  type        = string
  default     = "argocd.example.com"
}

variable "ingress_tls_enabled" {
  description = "Enable TLS for ArgoCD ingress"
  type        = bool
  default     = false
}

variable "ingress_tls_secret_name" {
  description = "Name of the TLS secret for ArgoCD ingress"
  type        = string
  default     = "argocd-tls"
}

variable "ingress_annotations" {
  description = "Annotations for ArgoCD ingress"
  type        = map(string)
  default     = {}
}

variable "rbac_policy" {
  description = "RBAC policy for ArgoCD"
  type        = string
  default     = ""
}

variable "config_override" {
  description = "Override ArgoCD server configuration"
  type        = map(string)
  default     = {}
}

variable "repositories" {
  description = "Git repositories to configure in ArgoCD"
  type        = map(any)
  default     = {}
}

variable "extra_set_values" {
  description = "Additional values to set in the Helm chart"
  type        = map(string)
  default     = {}
}

variable "values_file" {
  description = "Path to a values file for the Helm chart"
  type        = string
  default     = ""
}

variable "applications" {
  description = "ArgoCD applications to create"
  type        = map(any)
  default     = {}
}



