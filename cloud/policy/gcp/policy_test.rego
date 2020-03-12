package gcp.kubernetes

test_should_deny_on_null_tags {
	count(check_tags[_]) == 1 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.kubernetes.google_container_cluster.engineering", "type": "google_container_cluster", "provider_name": "google-beta", "values": {"description": null}}, {"address": "module.kubernetes.google_container_node_pool.engineering_preemptible_nodes", "type": "google_container_node_pool", "provider_name": "google-beta", "values": {"node_config": [{"tags": null}]}}], "address": "module.kubernetes"}]}}}
}

test_should_pass_on_nonexistent_tags {
	count(check_tags[_]) == 0 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"address": "module.kubernetes.google_container_cluster.engineering", "type": "google_container_cluster", "provider_name": "google-beta", "values": {"description": null}}], "address": "module.kubernetes"}]}}}
}

test_should_return_max_node_count {
	check_max_node_count[_] == 2 with input as {"planned_values": {"root_module": {"child_modules": [{"resources": [{"provider_name": "google-beta", "values": {"autoscaling": [{"max_node_count": 2, "min_node_count": 1}]}}], "address": "module.kubernetes"}]}}}
}
