package main

import data.gcp.kubernetes.check_tags
import data.gcp.kubernetes.check_max_node_count
import data.gcp.kubernetes.check_oauth_scopes
import data.gcp.kubernetes.check_legacy_abac_enabled
import data.gcp.kubernetes.check_username_and_password
import data.gcp.kubernetes.check_cluster_client_certificate

deny[msg] {
	count(check_tags[_]) > 0
	msg = sprintf("resource %s must have tags", [check_tags[_]])
}

deny[msg] {
	check_max_node_count[_] > 3
	msg = "cluster node pool must have max_node_count less than or equal to 3"
}

deny[msg] {
	count(check_legacy_abac_enabled[_]) > 0
	msg = "cluster must use RBAC and not legacy ABAC"
}

deny[msg] {
	count(check_username_and_password[_]) > 0
	msg = "cluster must not use basic authentication with password and username"
}

deny[msg] {
	count(check_cluster_client_certificate[_]) > 0
	msg = "cluster must not use client certificate for authentication"
}

deny[msg] {
	check_oauth_scopes
	msg = sprintf("cluster node config must have specific oauth scopes")
}