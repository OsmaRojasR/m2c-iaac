variable "project_id" {
  description = "Project ID of GCP"
  type        = string
}

variable "service_name" {
  description = "Service Name"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC"
  type        = string
}

variable "region" {
  description = "Region of the pipeline"
  type        = string
}