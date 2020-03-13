package azure.database

test_should_count_1_non_permissive_firewall_rules {
	count(number_of_non_permissive_database_firewall_rules[_]) == 1 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.database.azurerm_postgresql_firewall_rule.example", "type": "azurerm_postgresql_firewall_rule", "provider_name": "azurerm", "values": {"end_ip_address": "255.255.255.255", "start_ip_address": "0.0.0.0"}}], "address": "module.database"}]}}}
}

test_should_count_0_non_permissive_firewall_rules {
	count(number_of_non_permissive_database_firewall_rules[_]) == 0 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.database.azurerm_postgresql_firewall_rule.example", "type": "azurerm_postgresql_firewall_rule", "provider_name": "azurerm", "values": {"end_ip_address": "10.0.0.0", "start_ip_address": "10.0.0.0"}}], "address": "module.database"}]}}}
}

test_should_return_database_password_length {
	length_of_database_server_password[_] == 5 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.database.azurerm_postgresql_server.example", "type": "azurerm_postgresql_server", "provider_name": "azurerm", "values": {"administrator_login_password": "short"}}], "address": "module.database"}]}}}
}