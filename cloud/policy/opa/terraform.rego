package main

import data.terraform.all_expected_sensitive_outputs_marked_as_sensitive

sensitive_outputs = ["db_password", "db_username"]

deny[msg] {
	not all_expected_sensitive_outputs_marked_as_sensitive(sensitive_outputs)
	msg = sprintf("certain outputs must be marked as sensitive: %v", [sensitive_outputs])
}