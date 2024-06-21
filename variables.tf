variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where GCP resources will be created."
  type        = string
}

variable "credentials_file" {
  description = "Path to the credentials file"
  type        = string
}

variable "subnets" {
  description = "List of subnets"
  type        = list(string)
}

variable "subnet_cidrs" {
  description = "List of subnet CIDRs"
  type        = list(string)
}

variable "network_name" {
  description = "Name of the VPC"
  type        = string
}
