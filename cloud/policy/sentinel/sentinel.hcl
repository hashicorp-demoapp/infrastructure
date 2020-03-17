policy "database" {
    enforcement_level = "hard-mandatory"
}

policy "terraform" {
    enforcement_level = "hard-mandatory"
}

policy "gke-container-cluster" {
    enforcement_level = "hard-mandatory"
}

policy "gke-node-pool" {
    enforcement_level = "soft-mandatory"
}

policy "tags" {
    enforcement_level = "soft-mandatory"
}