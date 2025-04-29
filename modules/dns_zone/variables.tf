variable "dns_zone_name" {
  description = "Name of the DNS zone to create (e.g., dev.apps.azure.incora.com)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the DNS zone will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the DNS zone"
  type        = map(string)
  default     = {}
}