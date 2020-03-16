package main

import data.gcp.kubernetes.resources_with_null_tags
import data.gcp.kubernetes.node_pool_max_node_count
import data.gcp.kubernetes.cluster_node_pool_oauth_scopes
import data.gcp.kubernetes.resources_with_legacy_abac_enabled
import data.gcp.kubernetes.clusters_with_username_and_password_defined
import data.gcp.kubernetes.clusters_with_client_certificate_defined

gke_allowed_scopes = [
	"https://www.googleapis.com/auth/logging.write",
	"https://www.googleapis.com/auth/monitoring",
]

deny[msg] {
	count(resources_with_null_tags[_]) > 0
	msg = sprintf("resource %s must have tags", [resources_with_null_tags[_]])
}

deny[msg] {
	node_pool_max_node_count[_] > 3
	msg = "cluster node pool must have max_node_count less than or equal to 3"
}

deny[msg] {
	count(resources_with_legacy_abac_enabled[_]) > 0
	msg = "cluster must use RBAC and not legacy ABAC"
}

deny[msg] {
	count(clusters_with_username_and_password_defined[_]) > 0
	msg = "cluster must not use basic authentication with password and username"
}

deny[msg] {
	count(clusters_with_client_certificate_defined[_]) > 0
	msg = "cluster must not use client certificate for authentication"
}

deny[msg] {
	scopes := cluster_node_pool_oauth_scopes[_]
	count(scopes) != count(gke_allowed_scopes)
	contains(scopes[i], gke_allowed_scopes[_])
	msg = sprintf("cluster node config must have specific oauth scopes: %v", [gke_allowed_scopes[_]])
}