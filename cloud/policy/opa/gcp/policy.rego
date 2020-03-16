package gcp.kubernetes

resources_with_null_tags[r] {
	r := [res.address | res := gcp[_]; is_null(res.values.node_config[i].tags)]
}

node_pool_max_node_count[r] {
	resource := gcp[_]
	r := resource.values.autoscaling[_].max_node_count
}
