variable "namespace" {
  description = "Kubernetes namespace for the ingress controller"
  type        = string
  default     = "ingress-system"
}

variable "ingress_type" {
  description = "Type of ingress controller to deploy (nginx, traefik, etc.)"
  type        = string
  default     = "nginx"
}

variable "aks_cluster_id" {
  description = "The ID of the AKS cluster where the ingress controller will be deployed"
  type        = string
}

variable "replica_count" {
  description = "Number of ingress controller replicas"
  type        = number
  default     = 2
}

variable "service_type" {
  description = "Kubernetes service type for the ingress controller"
  type        = string
  default     = "LoadBalancer"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "cpu_request" {
  description = "CPU request for the ingress controller"
  type        = string
  default     = "100m"
}

variable "memory_request" {
  description = "Memory request for the ingress controller"
  type        = string
  default     = "128Mi"
}

variable "cpu_limit" {
  description = "CPU limit for the ingress controller"
  type        = string
  default     = "200m"
}

variable "memory_limit" {
  description = "Memory limit for the ingress controller"
  type        = string
  default     = "256Mi"
}
