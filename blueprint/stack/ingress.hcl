ingress "consul-http" {
  target = "cluster.k3s"
  service  = "svc/consul-consul-server"

  port {
    local  = 8500
    remote = 8500
    host   = 18500
  }
}

ingress "vault-http" {
  target = "cluster.k3s"
  service  = "svc/vault"

  port {
    local  = 8200
    remote = 8200
    host   = 18200
  }
}