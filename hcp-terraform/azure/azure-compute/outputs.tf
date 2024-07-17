output "catapp_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "catapp_url" {
  value = azurerm_public_ip.public_ip.fqdn
}