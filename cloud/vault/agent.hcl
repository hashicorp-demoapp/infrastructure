pid_file = "./pidfile"
exit_after_auth = true

auto_auth {
  method "approle" {
    config = {
      role_id_file_path = "vault/role-id"
      secret_id_file_path = "vault/secret-id"
    }
  }

  sink "file" {
    config = {
      path = "/tmp/vault-demoapp-infra"
    }
  }
}

template {
  contents = <<EOF
    {{ with secret "gcp/key/demoapp-infra" }}
    {{ .Data.private_key_data | base64Decode }}
    {{ end }}
  EOF
  destination = "/tmp/service-account.json"
}