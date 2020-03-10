package main

deny[msg] {
  resources := azure[_]
  contains(resources.address, "firewall_rule")
  resources.values.start_ip_address = "0.0.0.0"
  resources.values.end_ip_address = "255.255.255.255"
  msg = "database firewall must have specific CIDR and avoid 0.0.0.0-255.255.255.255"
}

deny[msg] {
  resources := azure[_]
  contains(resources.address, "azurerm_postgresql_server")
  count(resources.values.administrator_login_password) < 8
  msg = "database password must be between 8 and 128 characters. see https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portal"
}

deny[msg] {
  not input.planned_values.outputs.db_password.sensitive
  not input.planned_values.outputs.db_username.sensitive
  msg = "output of database password and username must be marked as sensitive"
}