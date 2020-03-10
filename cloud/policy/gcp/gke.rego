package gcp.kubernetes

gcp[r] {
  resources := input.planned_values.root_module.child_modules[_].resources[_]
  resources.provider_name = "google-beta"
  r := resources
}