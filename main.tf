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
