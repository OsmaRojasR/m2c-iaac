variable "vpn_gateway_name" {
  description = "Name of the HA VPN Gateway"
  type        = string
}

variable "region" {
  description = "The region where the HA VPN Gateway will be created"
  type        = string
}

variable "network" {
  description = "The VPC network where the VPN will be connected"
  type        = string
}

variable "external_gateway_name" {
  description = "Name for the external VPN gateway"
  type        = string
}

variable "peer_ip_0" {
  description = "Primary external IP address for the first VPN tunnel"
  type        = string
}

variable "peer_ip_1" {
  description = "Primary external IP address for the second VPN tunnel"
  type        = string
}

variable "shared_secret" {
  description = "Shared secret used for the VPN tunnels"
  type        = string
}

variable "vpn_gateway_asn" {
  description = "Local ASN for the HA VPN Gateway"
  type        = number
}

variable "vpn_peer_asn" {
  description = "Remote ASN for the VPN connection"
  type        = number
}
