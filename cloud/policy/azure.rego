package main

import data.azure.database.length_of_database_server_password
import data.azure.database.number_of_non_permissive_database_firewall_rules
import data.azure.database.plan_will_delete_protected_resources
import data.azure.database.number_of_resources_missing_tags

do_not_delete_these_resources = ["module.database.azurerm_postgresql_database.example"]

deny[msg] {
	plan_will_delete_protected_resources(do_not_delete_these_resources)
	msg = sprintf("plan will delete a protected resource: %v", [do_not_delete_these_resources[_]])
}

deny[msg] {
	count(number_of_resources_missing_tags[_]) > 0
	msg = sprintf("resource %v must have tags", [number_of_resources_missing_tags[_]])
}

deny[msg] {
	count(number_of_non_permissive_database_firewall_rules[_]) > 0
	msg = "database firewall must have specific CIDR and avoid 0.0.0.0-255.255.255.255"
}

deny[msg] {
	length_of_database_server_password[_] < 8
	msg = "database server password must be between 8 and 128 characters. see https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portal"
}