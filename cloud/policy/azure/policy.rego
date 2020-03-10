package azure.database

do_not_delete = [
  "module.database.azurerm_postgresql_database"
]

check_delete_protected(resources, disallowed) {
  startswith(resources[i].address, disallowed[_])
  resources[i].change[0].actions[_] == "delete"
}

deny[msg] {
  check_delete_protected(input.resource_changes, do_not_delete)
  msg = "terraform plan will delete a protected resource"
}

deny[msg] {
  is_null(input.planned_values.root_module.child_modules[_].resources[i].values.tags)
  msg = sprintf("resource %s must have tags", [input.planned_values.root_module.child_modules[_].resources[i].address])
}