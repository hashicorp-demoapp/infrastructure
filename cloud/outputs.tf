output "db_name" {
  value = module.database.name
}

output "db_endpoint" {
  value = module.database.endpoint
}

output "db_username" {
  value     = var.db_username
  sensitive = true
}

output "db_password" {
  value     = var.db_password
  sensitive = true
}

output "db_server" {
  value = module.database.server
}

output "google_location" {
  value = var.gcp.location
}

output "cluster_name" {
  value = var.service
}