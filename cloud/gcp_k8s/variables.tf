variable "location" {
  type        = string
  description = "Google region to deploy cluster"
}

variable "cluster_name" {
  type        = string
  description = "Name of cluster"
}

variable "google_project" {
  type        = string
  description = "Google project to deploy cluster"
}

variable "username" {
  type        = string
  default     = ""
  description = "username for cluster"
}

variable "password" {
  type        = string
  default     = ""
  description = "password for cluster"
}