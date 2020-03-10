package gcp.kubernetes

allowed_scopes = [
  "https://www.googleapis.com/auth/logging.write",
  "https://www.googleapis.com/auth/monitoring"
]

deny[msg] {
  resources := gcp[_]
  resources.values.enable_legacy_abac
  msg = "cluster must use RBAC and not legacy ABAC"
}

deny[msg] {
  resources := gcp[_]
  count(resources.values.master_auth[_].username) > 0
  count(resources.values.master_auth[_].password) > 0
  msg = "cluster must not use basic authentication with password and username"
}

deny[msg] {
  resources := gcp[_]
  resources.values.master_auth[_].client_certificate_config[_].issue_client_certificate
  msg = "cluster must not use client certificate for authentication"
}

check_oauth_scopes(allowed) {
  resources := gcp[_]
  oauth_scopes := resources.values.node_config[_].oauth_scopes
  count(oauth_scopes) != count(allowed)
  contains(oauth_scopes[i], allowed[_])
}

deny[msg] {
  check_oauth_scopes(allowed_scopes)
  msg = sprintf("cluster node config must have specific oauth scopes: %v", [allowed_scopes[_]])
}
