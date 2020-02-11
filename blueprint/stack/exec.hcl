remote_exec "setup_vault" {
  network = "network.cloud"
  cmd = "/scripts/setup_vault.sh"

  image {
    name = "shipyardrun/tools:latest"
  }

  volume {
    source = "./scripts"
    destination = "/scripts"
  }
  
  volume {
    source = "${k8s_config("k3s")}"
    destination = "/root/.kube/config"
  }

  env  {
    key = "VAULT_ADDR"
    value = "http://vault-http.cloud.shipyard:8200"
  }
  
  env  {
    key = "VAULT_TOKEN"
    value = "root"
  }
}