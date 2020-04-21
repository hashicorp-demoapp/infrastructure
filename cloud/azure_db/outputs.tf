output "endpoint" {
  value = azurerm_postgresql_server.example.fqdn
}

output "server" {
  value = azurerm_postgresql_server.example.name
}

output "name" {
  value = azurerm_postgresql_database.example.name
}