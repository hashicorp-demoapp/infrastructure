package gcp.kubernetes

test_should_count_1_cluster_with_legacy_abac_enabled {
	count(resources_with_legacy_abac_enabled[_]) == 1 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"enable_legacy_abac":true}}],"address":"module.kubernetes"}]}}}
}

test_should_count_0_cluster_with_legacy_abac_enabled {
	count(resources_with_legacy_abac_enabled[_]) == 0 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"enable_legacy_abac":false}}],"address":"module.kubernetes"}]}}}
}

test_should_count_1_cluster_with_username_and_password {
	count(clusters_with_username_and_password_defined[_]) == 1 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"master_auth":[{"client_certificate_config":[{"issue_client_certificate":false}],"password":"Testing!123","username":"admin"}]}}],"address":"module.kubernetes"}]}}}
}

test_should_count_0_cluster_with_username_and_password {
	count(clusters_with_username_and_password_defined[_]) == 0 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"master_auth":[{"client_certificate_config":[{"issue_client_certificate":false}],"password":"","username":""}]}}],"address":"module.kubernetes"}]}}}
}

test_should_count_1_cluster_with_client_certificate {
	count(clusters_with_client_certificate_defined[_]) == 1 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"master_auth":[{"client_certificate_config":[{"issue_client_certificate":true}],"password":"Testing!123","username":"admin"}]}}],"address":"module.kubernetes"}]}}}
}

test_should_count_0_cluster_with_no_client_certificate {
	count(clusters_with_client_certificate_defined[_]) == 0 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"address":"module.kubernetes.google_container_cluster.engineering","provider_name":"google-beta","values":{"master_auth":[{"client_certificate_config":[{"issue_client_certificate":false}],"password":"Testing!123","username":"admin"}]}}],"address":"module.kubernetes"}]}}}
}

test_should_return_1_oauth_scope_for_node_pool {
  count(cluster_node_pool_oauth_scopes[_]) == 1 with input as {"planned_values":{"root_module":{"child_modules":[{"resources":[{"provider_name":"google-beta","values":{"node_config":[{"oauth_scopes":["https://www.googleapis.com/auth/monitoring"]}]}}],"address":"module.kubernetes"}]}}}
}