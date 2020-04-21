package azure.database

test_should_deny_will_delete_protected_resource {
	do_not_delete = ["module.database.azurerm_postgresql_database"]
	plan_will_delete_protected_resources(do_not_delete) with input as {"resource_changes": [{"address": "module.database.azurerm_postgresql_database", "provider_name": "azurerm", "change": {"actions": ["delete"]}}]}
}

test_should_pass_plan_does_not_delete_protected_resource {
	do_not_delete = []
	not plan_will_delete_protected_resources(do_not_delete) with input as {"resource_changes": [{"address": "module.database.azurerm_postgresql_database", "provider_name": "azurerm", "change": {"actions": ["delete"]}}]}
}

test_should_record_resource_missing_tags {
	count(number_of_resources_missing_tags[_]) == 1 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.database.azurerm_postgresql_firewall_rule.example", "provider_name": "azurerm", "values": {"end_ip_address": "255.255.255.255"}}, {"address": "module.database.azurerm_resource_group.example", "provider_name": "azurerm", "values": {"tags": null}}], "address": "module.database"}]}}}
}

test_should_record_no_resources_missing_tags {
	count(number_of_resources_missing_tags[_]) == 0 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.database.azurerm_postgresql_firewall_rule.example", "provider_name": "azurerm", "values": {"end_ip_address": "255.255.255.255"}}], "address": "module.database"}]}}}
}
