package azure.database

test_should_deny_open_firewall {
	count(check_firewall_rules[_]) == 1 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.database.azurerm_postgresql_firewall_rule.example", "type": "azurerm_postgresql_firewall_rule", "provider_name": "azurerm", "values": {"end_ip_address": "255.255.255.255", "start_ip_address": "0.0.0.0"}}], "address": "module.database"}]}}}
}

test_should_pass_with_restricted_firewall {
	count(check_firewall_rules[_]) == 0 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.database.azurerm_postgresql_firewall_rule.example", "type": "azurerm_postgresql_firewall_rule", "provider_name": "azurerm", "values": {"end_ip_address": "10.0.0.0", "start_ip_address": "10.0.0.0"}}], "address": "module.database"}]}}}
}

test_should_return_database_password_length {
	check_database_password_length[_] == 5 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.database.azurerm_postgresql_server.example", "type": "azurerm_postgresql_server", "provider_name": "azurerm", "values": {"administrator_login_password": "short"}}], "address": "module.database"}]}}}
}

test_should_deny_plaintext_output {
	count(check_sensitive_outputs[_]) == 1 with input as {"planned_values": {"outputs": {"db_password": {"sensitive": false}, "test": {"sensitive": true}}}}
}

test_should_pass_with_masked_outputs {
	count(check_sensitive_outputs[_]) == 0 with input as {"planned_values": {"outputs": {"db_password": {"sensitive": true}, "db_username": {"sensitive": true}, "test": {"sensitive": false}}}}
}
