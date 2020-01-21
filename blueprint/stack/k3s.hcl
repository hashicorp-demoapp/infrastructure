cluster "k3s" {
  driver  = "k3s" // default
  version = "v1.0.1"

  nodes = 1 // default

  network = "network.cloud"

  // push images from local docker to k3s on create
  image {
    name = "hashicorpdemoapp/product-api:v0.0.10"
  }
  
  image {
    name = "hashicorpdemoapp/product-api-db:v0.0.10"
  }
}
