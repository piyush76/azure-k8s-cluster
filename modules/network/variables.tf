
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be created"
}

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "create_application_gateway" {
  type        = bool
  default     = true
  description = "Whether to create an Application Gateway"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the network resources"
}
