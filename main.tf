provider "google" {
  credentials = file(var.credentials_file)
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source       = "./modules/vpc"
  project_id   = var.project_id
  network_name = var.network_name
  region       = var.region
  subnets = var.subnets
  subnet_cidrs = var.subnet_cidrs
}

module "firewall" {
  source       = "./modules/security"
  network      = module.vpc.vpc_id
  network_name = var.network_name
}

module "vpn" {
  source               = "./modules/network/vpn"
  vpn_gateway_name     = var.vpn_gateway_name
  region               = var.region
  network              = var.network_name
  vpn_gateway_asn      = var.vpn_peer_asn - 2
  vpn_peer_asn         = var.vpn_peer_asn
  external_gateway_name = var.external_gateway_name
  peer_ip_0            = var.peer_ip_0
  peer_ip_1            = var.peer_ip_1
  shared_secret        = var.shared_secret
}
