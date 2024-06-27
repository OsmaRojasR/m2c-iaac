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
  depends_on = [ module.vpc ]
}

module "vpn" {
  source               = "./modules/network/vpn"
  vpn_gateway_name     = var.vpn_gateway_name
  region               = var.region
  network              = module.vpc.vpc_id
  vpn_gateway_asn      = var.vpn_peer_asn - 2
  vpn_peer_asn         = var.vpn_peer_asn
  external_gateway_name = var.external_gateway_name
  peer_ip_0            = var.peer_ip_0
  peer_ip_1            = var.peer_ip_1
  shared_secret        = var.shared_secret

  depends_on = [ module.vpc ]
}

module "vm" {
  source       = "./modules/compute/vm"
  project_id   = var.project_id
  instance_name = "m2c-vm-bastion"
  region = var.region
  zone         = var.zone
  network_name = var.network_name
  subnets = var.subnets
  depends_on = [ module.vpc, module.firewall ]
}

module "storage" {
  source       = "./modules/storage"
  project_name = var.project_name
}

module "workerpool" {
  source = "./modules/triggers/worker_pool"  
  project_id = var.project_id
  network_name = var.network_name
  region = var.region
  depends_on = [ module.vpc ]
}

### Componentes para Despliegue Continuo

module "cloudbuild" {
  source       = "./modules/triggers/cloud_build"
  project_id   = var.project_id
  region       = var.region
  service_name = "service-docs"
  github_app_installation_id = var.github_app_installation_id
  github_owner = var.github_owner
  github_repo = var.github_repo
  github_token_access = var.github_token_access
}

module "pipelines" {
  source       = "./modules/pipelines"
  project_id   = var.project_id
  project_name = var.project_name
  region       = var.region
  service_name = "servdocuments"
}

module "notification" {
  source      = "./modules/notifications"
  project_id  = var.project_id
  region      = var.region
  pipeline_id = module.pipelines.pipeline_id
  email       = "eduardo.lozano@beyondtech.consulting"
}

module "artifact_registry" {
  source          = "./modules/artifact_registry"
  project_name    = var.project_name
  region          = var.region  
  service_name    = "servdocuments"
  keep_n_versions = 3
}
