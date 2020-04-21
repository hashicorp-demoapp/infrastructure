package azure.database

number_of_non_permissive_database_firewall_rules[r] {
	firewall_rules := [res | res := azure[_]; res.type == "azurerm_postgresql_firewall_rule"]
	start_ip := [res | res := firewall_rules[_]; res.values.start_ip_address == "0.0.0.0"]
	r := [res | res := start_ip[_]; res.values.end_ip_address == "255.255.255.255"]
}

length_of_database_server_password[r] {
	databases := [res | res := azure[_]; res.type == "azurerm_postgresql_server"]
	r := count(databases[i].values.administrator_login_password)
}
