k8s_config "application" {
  cluster = "k8s_cluster.k3s"
	paths = ["./k8s_config"]
	wait_until_ready = true

  health_check {
    timeout = "60s"
    pods = ["service=postgres"]
  }
}