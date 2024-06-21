resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  mtu                     = 1460
}

resource "google_compute_subnetwork" "subnetwork" {
  count         = length(var.subnets)
  name          = element(var.subnets, count.index)
  ip_cidr_range = element(var.subnet_cidrs, count.index)
  region        = var.region
  network       = google_compute_network.vpc_network.id
}
