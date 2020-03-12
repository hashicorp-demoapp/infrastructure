package azure.database

do_not_delete = ["module.database.azurerm_postgresql_database"]

check_delete_resources[r] {
	types := [res | res := azure_resource_changes[_]; startswith(res.address, do_not_delete[_])]
	r := [res.address | res := types[_]; res.change.actions[_] == "delete"]
}

check_tags[r] {
	r := [res.address | res := azure[_]; is_null(res.values.tags)]
}
