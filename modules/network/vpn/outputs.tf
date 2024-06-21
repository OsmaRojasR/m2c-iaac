output "ha_vpn_gateway_id" {
  value = google_compute_ha_vpn_gateway.ha_vpn_gateway.id
}

output "vpn_tunnel_id_0" {
  value = google_compute_vpn_tunnel.tunnel_0.id
}

output "vpn_tunnel_id_1" {
  value = google_compute_vpn_tunnel.tunnel_1.id
}
