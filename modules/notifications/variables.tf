variable "emails" {
  description = "List of emails of approvers"
  type        = list(string)
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "region" {
  description = "Region of the pipeline"
  type        = string
}

variable "service_name" {
  description = "Service Name"
  type        = string
}