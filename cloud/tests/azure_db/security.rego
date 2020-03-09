package main

firewall_rule_contains_permissive_allow(resources) {
  contains(resources[i].address, "firewall_rule")
  resources[i].values.start_ip_address = "0.0.0.0"
  resources[i].values.end_ip_address = "255.255.255.255"
}

deny[msg] {
  firewall_rule_contains_permissive_allow(input.planned_values.root_module.child_modules[_].resources)
  msg = "database firewall must have specific CIDR and avoid 0.0.0.0-255.255.255.255"
}

db_password_requirement(resources) {
  contains(resources[i].address, "azurerm_postgresql_server")
  count(resources[i].values.administrator_login_password) < 8
}

deny[msg] {
  db_password_requirement(input.planned_values.root_module.child_modules[_].resources)
  msg = "database password must be between 8 and 128 characters. see https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portal"
}

deny[msg] {
  not input.planned_values.outputs.db_password.sensitive
  not input.planned_values.outputs.db_username.sensitive
  msg = "output of database password and username must be marked as sensitive"
}