ingress "consul-http" {
  target = "k8s_cluster.k3s"
  service  = "svc/consul-consul-server"
  
  network {
    name = "network.cloud"
  }

  port {
    local  = 8500
    remote = 8500
    host   = 18500
  }
}

ingress "vault-http" {
  target = "k8s_cluster.k3s"
  service  = "svc/vault"

  network {
    name = "network.cloud"
  }

  port {
    local  = 8200
    remote = 8200
    host   = 18200
  }
}

ingress "product-api-db" {
  target = "k8s_cluster.k3s"
  service  = "svc/postgres"
  
  network {
    name = "network.cloud"
  }

  port {
    local  = 5432
    remote = 5432
    host   = 15432
  }
}

ingress "product-api" {
  target = "k8s_cluster.k3s"
  service  = "svc/products-api-service"
  
  network {
    name = "network.cloud"
  }

  port {
    local  = 9090
    remote = 9090
    host   = 19090
  }
}

ingress "public-api" {
  target = "k8s_cluster.k3s"
  service  = "svc/public-api-service"
  
  network {
    name = "network.cloud"
  }

  port {
    local  = 8080
    remote = 8080
    host   = 18080
  }
}

ingress "frontend" {
  target = "k8s_cluster.k3s"
  service  = "svc/frontend-service"
  
  network {
    name = "network.cloud"
  }

  port {
    local  = 80
    remote = 80
    host   = 10080
  }
}

ingress "prometheus-server" {
  target = "k8s_cluster.k3s"
  service  = "svc/prometheus-server"
  
  network {
    name = "network.cloud"
  }

  port {
    local  = 80
    remote = 80
    host   = 19100
  }
}

ingress "grafana" {
  target = "k8s_cluster.k3s"
  service  = "svc/grafana"
  
  network {
    name = "network.cloud"
  }

  port {
    local  = 80
    remote = 80
    host   = 13000
  }
}

ingress "jaeger" {
  target = "k8s_cluster.k3s"
  service  = "svc/jaeger"
  
  network {
    name = "network.cloud"
  }

  port {
    local  = 16686
    remote = 16686
    host   = 16686
  }
  
  port {
    local  = 9411
    remote = 9411
    host   = 19411
  }
}