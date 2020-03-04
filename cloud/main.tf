terraform {
  required_version = "~>0.12"
  backend "remote" {}
}

provider "google" {
  version = "~> 3.10"
  project = var.gcp.project
}

provider "azurerm" {
  version = "~> 2.0"
  features {}
}

module "kubernetes" {
  source         = "./gcp_k8s"
  location       = var.gcp.location
  google_project = var.gcp.project
  cluster_name   = var.service
  username       = "admin"
  password       = var.db_password
}

module "database" {
  source   = "./azure_db"
  location = var.azure.location
  name     = var.service
  username = var.db_username
  password = var.db_password
}