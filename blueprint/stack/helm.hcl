helm "consul" {
  cluster = "k8s_cluster.k3s"
  chart = "./helm/consul-helm-0.16.2"
  values = "./helm/consul-values.yaml"
  
  health_check {
    timeout = "60s"
    pods = ["release=consul"]
  }
}

helm "vault" {
  cluster = "k8s_cluster.k3s"
  chart = "./helm/vault-helm-0.3.3"
  values = "./helm/vault-values.yaml"

  health_check {
    timeout = "60s"
    pods = ["app.kubernetes.io/name=vault"]
  }
}

helm "prometheus" {
  cluster = "k8s_cluster.k3s"
  chart = "./helm/prometheus"
  values= "./helm/prometheus-values.yaml"
}

helm "grafana" {
  cluster = "k8s_cluster.k3s"
  chart = "./helm/grafana"
  values= "./helm/grafana-values.yaml"
}