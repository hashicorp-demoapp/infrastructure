package main

import data.azure.database.length_of_database_server_password
import data.azure.database.check_delete_resources
import data.azure.database.number_of_non_permissive_database_firewall_rules
import data.azure.database.check_tags

deny[msg] {
	count(check_delete_resources[_]) > 0
	msg = sprintf("plan will delete protected resource: %s", [check_delete_resources[_]])
}

deny[msg] {
	count(check_tags[_]) > 0
	msg = sprintf("resource %s must have tags", [check_tags[_]])
}

deny[msg] {
	count(number_of_non_permissive_database_firewall_rules[_]) > 0
	msg = "database firewall must have specific CIDR and avoid 0.0.0.0-255.255.255.255"
}

deny[msg] {
	length_of_database_server_password[_] < 8
	msg = "database server password must be between 8 and 128 characters. see https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portal"
}