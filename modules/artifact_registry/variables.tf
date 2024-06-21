variable "enviroment" {
  description = "Enviroment Name"
  type        = string
}

variable "service_name" {
  description = "Service Name"
  type        = string
}

variable "keep_n_versions" {
  description = "Number of Versions of a DockerFile to Save"
  type        = number
}
