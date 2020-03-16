package gcp.kubernetes

check_oauth_scopes[r] {
	resources := gcp[_]
	r := resources.values.node_config[_].oauth_scopes
}

check_legacy_abac_enabled[r] {
	r := [res.address | res := gcp[_]; res.values.enable_legacy_abac]
}

check_username_and_password[r] {
	usernames := [res | res := gcp[_]; res.values.master_auth[_].username > 0]
	r := [res.address | res := usernames[_]; res.values.master_auth[_].password > 0]
}

check_cluster_client_certificate[r] {
	r := [res | res := gcp[_]; res.values.master_auth[_].client_certificate_config[_].issue_client_certificate]
}