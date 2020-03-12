package azure.database

sensitive_outputs = ["db_password", "db_username"]

check_firewall_rules[r] {
	firewall_rules := [res | res := azure[_]; res.type == "azurerm_postgresql_firewall_rule"]
	start_ip := [res | res := firewall_rules[_]; res.values.start_ip_address == "0.0.0.0"]
	r := [res | res := start_ip[_]; res.values.end_ip_address == "255.255.255.255"]
}

check_database_password_length[r] {
	databases := [res | res := azure[_]; res.type == "azurerm_postgresql_server"]
	r := count(databases[i].values.administrator_login_password)
}

has_key(x, k) {
	_ = x[k]
}

check_sensitive_outputs[r] {
	check_sensitive := [res[sensitive_outputs[i]] | res := outputs[_]; has_key(res, sensitive_outputs[_])]
	r := [res | res := check_sensitive[_]; not res.sensitive]
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
