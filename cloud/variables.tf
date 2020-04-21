variable "service" {
  type = string
}

variable "gcp" {
  type = map
  default = {
    project  = ""
    location = ""
  }
}

variable "azure" {
  type = map
  default = {
    location = ""
  }
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}