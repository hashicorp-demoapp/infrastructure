resource "azurerm_resource_group" "example" {
  name     = var.name
  location = var.location
}

resource "azurerm_postgresql_server" "example" {
  name                = "${var.name}-postgres-server"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku_name = "B_Gen5_2"

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = var.username
  administrator_login_password = var.password
  version                      = "11"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_postgresql_database" "example" {
  name                = var.name
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_postgresql_server.example.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "example" {
  name                = var.name
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_postgresql_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}