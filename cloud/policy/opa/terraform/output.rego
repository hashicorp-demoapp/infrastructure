package terraform

outputs[r] {
	r := input.planned_values.outputs
}

check_if_output_is_not_sensitive(outputs) {
	some key
  val := outputs[key]
  not val.sensitive
}

all_expected_sensitive_outputs_marked_as_sensitive(sensitive_outputs) {
	should_be_sensitive := object.filter(outputs[_], sensitive_outputs)
	not check_if_output_is_not_sensitive(should_be_sensitive)
}