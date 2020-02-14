exec_remote "setup_vault" {
  depends_on = ["helm.vault"]

  network  {
    name = "network.cloud"
  }

  cmd = "/scripts/setup_vault.sh"

  image {
    name = "shipyardrun/tools:latest"
  }

  volume {
    source = "./scripts"
    destination = "/scripts"
  }
  
  volume {
    source = "${env("HOME")}/.shipyard/config/k3s/kubeconfig-docker.yaml"
    destination = "/root/.kube/config"
  }

  env  {
    key = "VAULT_ADDR"
    value = "http://vault-http.ingress.shipyard:8200"
  }
  
  env  {
    key = "VAULT_TOKEN"
    value = "root"
  }
}