package main

check_tags[r] {
  resource := gcp[_]
  is_null(resource.values.node_config[_].tags)
  r := resource.address
}

deny[msg] {
  count(check_tags[_]) > 0
  msg = sprintf("missing tags: %s", [check_tags[_]])
}

deny[msg] {
  resource := gcp[_]
  resource.values.autoscaling[_].max_node_count > 3
  msg = "cluster node pool must have max_node_count less than or equal to 3"
}