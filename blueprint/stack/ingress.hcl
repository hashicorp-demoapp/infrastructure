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

ingress "product-api-db" {
  target = "cluster.k3s"
  service  = "svc/postgres"

  port {
    local  = 5432
    remote = 5432
    host   = 15432
  }
}

ingress "product-api" {
  target = "cluster.k3s"
  service  = "svc/web-service"

  port {
    local  = 9090
    remote = 9090
    host   = 19090
  }
}