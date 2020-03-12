package azure.database

do_not_delete = ["module.database.azurerm_postgresql_database"]

check_delete_resources[r] {
	types := [res | res := azure_resource_changes[_]; startswith(res.address, do_not_delete[_])]
	r := [res.address | res := types[_]; res.change.actions[_] == "delete"]
}

check_tags[r] {
  r := [res.address | res := azure[_]; is_null(res.values.tags)]
}

deny[msg] {
	count(check_delete_resources[_]) > 0
	msg = sprintf("plan will delete protected resource: %s", [check_delete_resources[_]])
}

deny[msg] {
  count(check_tags[_]) > 0
	msg = sprintf("resource %s must have tags", [check_tags[_]])
}
