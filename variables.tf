variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "region" {
  description = "The region where GCP resources will be created."
  type        = string
}

variable "zone" {
  description = "Zone in which to create resources"
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

variable "vpn_gateway_name" {
  description = "The name of the VPN gateway"
  type        = string
}

variable "vpn_peer_asn" {
  description = "The ASN of the peer VPN gateway"
  type        = number
}

variable "external_gateway_name" {
  description = "The name of the external VPN gateway"
  type        = string
}

variable "peer_ip_0" {
  description = "The IP address of the peer VPN gateway"
  type        = string
}

variable "peer_ip_1" {
  description = "The IP address of the peer VPN gateway"
  type        = string
}

variable "shared_secret" {
  description = "The shared secret for the VPN connection"
  type        = string
}

variable "service_names" {
  description = "List of service names to iterate over"
  type        = list(string)
  default     = ["servdocuments", "simplepipeline"]
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
