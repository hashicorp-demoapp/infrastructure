package terraform

test_should_pass_because_test_output_is_marked_sensitive {
	sensitive_outputs := ["test"]
	all_expected_sensitive_outputs_marked_as_sensitive(sensitive_outputs) with input as {"planned_values": {"outputs": {"test": {"sensitive": true}}}}
}

test_should_deny_because_test_output_is_marked_sensitive {
	sensitive_outputs := ["test"]
	not all_expected_sensitive_outputs_marked_as_sensitive(sensitive_outputs) with input as {"planned_values": {"outputs": {"test": {"sensitive": false}}}}
}