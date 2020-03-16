package gcp.kubernetes

test_should_deny_legacy_abac {
	count(check_legacy_abac_enabled[_]) > 0 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"enable_legacy_abac":true}}],"address":"module.kubernetes"}]}}}
}

test_should_pass_with_rbac {
	count(check_legacy_abac_enabled[_]) == 0 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"enable_legacy_abac":false}}],"address":"module.kubernetes"}]}}}
}

test_should_deny_cluster_with_username_and_password {
	count(check_username_and_password[_]) == 1 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"master_auth":[{"client_certificate_config":[{"issue_client_certificate":false}],"password":"Testing!123","username":"admin"}]}}],"address":"module.kubernetes"}]}}}
}

test_should_deny_cluster_with_client_certificate {
	count(check_cluster_client_certificate[_]) == 1 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"master_auth":[{"client_certificate_config":[{"issue_client_certificate":true}],"password":"Testing!123","username":"admin"}]}}],"address":"module.kubernetes"}]}}}
}

test_should_pass_with_no_client_certificate {
	count(check_cluster_client_certificate[_]) == 0 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"master_auth":[{"client_certificate_config":[{"issue_client_certificate":false}],"password":"Testing!123","username":"admin"}]}}],"address":"module.kubernetes"}]}}}
}

test_should_pass_with_no_client_certificate {
	count(check_cluster_client_certificate[_]) == 0 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"master_auth":[{"client_certificate_config":[{"issue_client_certificate":false}],"password":"Testing!123","username":"admin"}]}}],"address":"module.kubernetes"}]}}}
}

test_should_return_oauth_scopes {
  count(check_oauth_scopes[_]) == 1 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"provider_name":"google-beta","values":{"node_config":[{"oauth_scopes":["https://www.googleapis.com/auth/monitoring"]}]}}],"address":"module.kubernetes"}]}}}
}