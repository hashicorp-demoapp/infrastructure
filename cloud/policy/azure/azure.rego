package azure.database

azure[r] {
  resources := input.planned_values.root_module.child_modules[_].resources[_]
  resources.provider_name = "azurerm"
  r := resources
}