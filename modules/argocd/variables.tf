variable "namespace" {
  description = "Namespace for ArgoCD deployment"
  type        = string
  default     = "argo"
}

variable "argocd_chart_version" {
  description = "Version of the ArgoCD Helm chart"
  type        = string
  default     = "5.46.7"  # Use a specific version for stability
}

variable "service_type" {
  description = "Kubernetes service type for ArgoCD server"
  type        = string
  default     = "LoadBalancer"
}
variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "argocd"
}
variable "labels" {
  description = "Labels to add to all resources"
  type        = map(string)
  default     = {}
}

variable "insecure" {
  description = "Run ArgoCD server in insecure mode"
  type        = bool
  default     = false
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
      memory = "256Mi"
    }
    requests = {
      cpu    = "250m"
      memory = "256Mi"
    }
  }
}

variable "controller_resources" {
  description = "Resources for ArgoCD controller"
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
      cpu    = "500m"
      memory = "512Mi"
    }
  }
}

variable "repo_server_resources" {
  description = "Resources for ArgoCD repo server"
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

variable "enable_ha" {
  description = "Enable high availability"
  type        = bool
  default     = true
}

variable "argocd_url" {
  description = "ArgoCD external URL"
  type        = string
  default     = ""
}

variable "azure_client_id" {
  description = "Azure AD client ID for OIDC authentication"
  type        = string
  default     = ""
}

variable "azure_client_secret" {
  description = "Azure AD client secret for OIDC authentication"
  type        = string
  default     = ""
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure AD tenant ID for OIDC authentication"
  type        = string
  default     = ""
}
variable "helm_values" {
  description = "Additional values to pass to the Helm chart"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "helm_sensitive_values" {
  description = "Sensitive values to pass to the Helm chart"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "wait_for_deployment" {
  description = "Wait for the deployment to be ready"
  type        = bool
  default     = true
}

variable "timeout" {
  description = "Timeout for Helm deployment"
  type        = number
  default     = 900
}



