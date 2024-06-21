variable "network_name" {
  description = "Name of the VPC"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "subnets" {
  description = "List of subnets"
  type        = list(string)
}

variable "subnet_cidrs" {
  description = "List of subnet CIDR ranges"
  type        = list(string)
}
