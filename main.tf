provider "google" {
  credentials = file(var.credentials_file)
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source       = "./modules/network/vpc"
  project_id   = var.project_id
  network_name = var.network_name
  region       = var.region
  subnets = var.subnets
  subnet_cidrs = var.subnet_cidrs
}

module "firewall" {
  source       = "./modules/network/security"
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

module "vm" {
  source       = "./modules/compute/vm"
  project_id   = var.project_id
  instance_name = "m2c-vm-bastion"
  region = var.region
  zone         = var.zones[0]
  network_name = var.network_name
  subnetwork = var.subnets[0]
  subnets = var.subnet_cidrs
}

module "storage" {
  source       = "./modules/storage"
  project_name = var.project_name
}

module "workerpool" {
  source = "./modules/triggers/worker_pool"
  project_name = var.project_name
  region = var.region
  network_name = var.network_name
  service_name = "servdocuments"
}


module "cloudbuild" {
  source = "./modules/triggers/cloud_build"
  project_name = var.project_name
  region = var.region
  network_name = var.network_name
  service_name = "servdocuments"
}

module "pipelines" {
  source       = "./modules/pipelines"
  project_id = var.project_id
  project_name = var.project_name
  region = var.region
  service_name = "servdocuments"
}

module "notification" {
  source = "./modules/notifications"
  project_id = var.project_id
  region = var.region
  pipeline_id = module.pipelines.pipeline_id
  email = "eduardo.lozano@beyondtech.consulting"
}


module "artifact_registry" {
  source = "./modules/artifact_registry"
  project_name = var.project_name
  region = var.region  
  service_name = "servdocuments"
  keep_n_versions = 3
}
