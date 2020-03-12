package main

import data.azure.database.check_delete_resources
import data.azure.database.check_tags
import data.azure.database.check_firewall_rules
import data.azure.database.check_database_password_length
import data.azure.database.check_sensitive_outputs

deny[msg] {
	count(check_delete_resources[_]) > 0
	msg = sprintf("plan will delete protected resource: %s", [check_delete_resources[_]])
}

deny[msg] {
	count(check_tags[_]) > 0
	msg = sprintf("resource %s must have tags", [check_tags[_]])
}


deny[msg] {
	count(check_firewall_rules[_]) > 0
	msg = "database firewall must have specific CIDR and avoid 0.0.0.0-255.255.255.255"
}

deny[msg] {
	check_database_password_length[_] < 8
	msg = "database server password must be between 8 and 128 characters. see https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portal"
}

deny[msg] {
	count(check_sensitive_outputs[r]) > 0
	msg = "output of database password and username must be marked as sensitive"
}