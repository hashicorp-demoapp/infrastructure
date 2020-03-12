package gcp.kubernetes

check_tags[r] {
	r := [res.address | res := gcp[_]; is_null(res.values.node_config[i].tags)]
}

check_max_node_count[r] {
	resource := gcp[_]
	r := resource.values.autoscaling[_].max_node_count
}
