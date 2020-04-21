package azure.database

plan_will_delete_protected_resources(do_not_delete_these_resources) {
	types := [res | res := azure_resource_changes[_]; res.address == do_not_delete_these_resources[_]]
	r := [res.address | res := types[_]; res.change.actions[_] == "delete"]
	count(r) > 0
}

number_of_resources_missing_tags[r] {
	r := [res.address | res := azure[_]; is_null(res.values.tags)]
}
