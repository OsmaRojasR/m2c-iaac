resource "google_compute_ha_vpn_gateway" "ha_vpn_gateway" {
  name    = var.vpn_gateway_name
  region  = var.region
  network = var.network
}

resource "google_compute_external_vpn_gateway" "external_gateway" {
  name = var.external_gateway_name
  redundancy_type = "TWO_IPS_REDUNDANCY"

  interface {
    id         = 0
    ip_address = var.peer_ip_0
  }

  interface {
    id         = 1
    ip_address = var.peer_ip_1
  }
}

resource "google_compute_router" "router" {
  name    = "${var.vpn_gateway_name}-router"
  region  = var.region
  network = var.network

  bgp {
    asn = var.vpn_gateway_asn
  }
}

resource "google_compute_vpn_tunnel" "tunnel_0" {
  name                  = "${var.vpn_gateway_name}-tunnel-0"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha_vpn_gateway.id
  peer_external_gateway = google_compute_external_vpn_gateway.external_gateway.id
  peer_gcp_gateway      = google_compute_router.router.id
  shared_secret         = var.shared_secret
  router                = google_compute_router.router.name
}

resource "google_compute_vpn_tunnel" "tunnel_1" {
  name                  = "${var.vpn_gateway_name}-tunnel-1"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha_vpn_gateway.id
  peer_external_gateway = google_compute_external_vpn_gateway.external_gateway.id
  peer_gcp_gateway      = google_compute_router.router.id
  shared_secret         = var.shared_secret
  router                = google_compute_router.router.name
}

resource "google_compute_router_peer" "bgp_peer_0" {
  name                  = "${var.vpn_gateway_name}-bgp-peer-0"
  router                = google_compute_router.router.name
  region                = var.region
  peer_asn              = var.vpn_peer_asn
  peer_ip_address       = var.peer_ip_0
  advertised_route_priority = 100
  interface             = google_compute_vpn_tunnel.tunnel_0.id
}

resource "google_compute_router_peer" "bgp_peer_1" {
  name                  = "${var.vpn_gateway_name}-bgp-peer-1"
  router                = google_compute_router.router.name
  region                = var.region
  peer_asn              = var.vpn_peer_asn
  peer_ip_address       = var.peer_ip_1
  advertised_route_priority = 100
  interface             = google_compute_vpn_tunnel.tunnel_1.id
}
