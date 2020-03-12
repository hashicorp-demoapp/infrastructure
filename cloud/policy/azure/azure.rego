package azure.database

azure[r] {
	resources := input.planned_values.root_module.child_modules[_].resources[_]
	resources.provider_name == "azurerm"
	r := resources
}

outputs[r] {
	resources := input.planned_values.outputs
	r := resources
}

azure_resource_changes[r] {
	resources := input.resource_changes[_]
	resources.provider_name == "azurerm"
	r := resources
}
