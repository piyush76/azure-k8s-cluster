output "dns_zone_id" {
  description = "ID of the created DNS zone"
  value       = azurerm_dns_zone.dns_zone.id
}

output "dns_zone_name" {
  description = "Name of the created DNS zone"
  value       = azurerm_dns_zone.dns_zone.name
}

output "name_servers" {
  description = "List of name servers for the DNS zone"
  value       = azurerm_dns_zone.dns_zone.name_servers
}
