package gcp.kubernetes

cluster_node_pool_oauth_scopes[r] {
	resources := gcp[_]
	r := resources.values.node_config[_].oauth_scopes
}

resources_with_legacy_abac_enabled[r] {
	r := [res.address | res := gcp[_]; res.values.enable_legacy_abac]
}

clusters_with_username_and_password_defined[r] {
	usernames := [res | res := gcp[_]; count(res.values.master_auth[_].username) > 0]
	r := [res.address | res := usernames[_]; count(res.values.master_auth[_].password) > 0]
}

clusters_with_client_certificate_defined[r] {
	r := [res | res := gcp[_]; res.values.master_auth[_].client_certificate_config[_].issue_client_certificate]
}