package azure.database

test_should_deny_on_delete {
	count(check_delete_resources[_]) == 1 with input as {"resource_changes": [{"address": "module.database.azurerm_postgresql_database", "provider_name": "azurerm", "change": {"actions": ["delete"]}}]}
}

test_should_pass_on_not_delete {
	count(check_delete_resources[_]) == 0 with input as {"resource_changes": [{"address": "module.database.azurerm_postgresql_database", "provider_name": "azurerm", "change": {"actions": ["create"]}}]}
}

test_should_deny_on_null_tags {
	count(check_tags[_]) == 1 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.database.azurerm_postgresql_firewall_rule.example", "provider_name": "azurerm", "values": {"end_ip_address": "255.255.255.255"}}, {"address": "module.database.azurerm_resource_group.example", "provider_name": "azurerm", "values": {"tags": null}}], "address": "module.database"}]}}}
}

test_should_pass_on_nonexistent_tag_field {
	count(check_tags[_]) == 0 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.database.azurerm_postgresql_firewall_rule.example", "provider_name": "azurerm", "values": {"end_ip_address": "255.255.255.255"}}], "address": "module.database"}]}}}
}
