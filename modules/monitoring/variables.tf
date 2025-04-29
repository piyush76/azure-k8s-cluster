
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

variable "retention_in_days" {
  type        = number
  default     = 30
  description = "Log retention period in days"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the monitoring resources"
}
