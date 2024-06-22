variable "project_name"{
  description = "The name of the project"
  type        = string
}

variable "location" {
  description = "The location of the bucket"
  type        = string
  default = "US"
}