package gcp.kubernetes

allowed_scopes = [
	"https://www.googleapis.com/auth/logging.write",
	"https://www.googleapis.com/auth/monitoring",
]

check_oauth_scopes {
	resources := gcp[_]
	oauth_scopes := resources.values.node_config[_].oauth_scopes
	count(oauth_scopes) != count(allowed)
	contains(oauth_scopes[i], allowed[_])
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