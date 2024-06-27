variable "service_name" {
  description = "The name of the service"
  type        = string
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "github_owner" {
  description = "The GitHub repository owner"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository name"
  type        = string
}

variable "github_token_access" {
  description = "The GitHub token access"
  type        = string
}

variable "github_app_installation_id" {
  description = "The GitHub App Installation ID"
  type        = number
}
