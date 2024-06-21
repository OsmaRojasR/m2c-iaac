output "firewall_rule_internal_id" {
  value = google_compute_firewall.allow_internal.id
}

output "firewall_rule_ssh_id" {
  value = google_compute_firewall.allow_ssh.id
}

output "firewall_rule_sql_id" {
  value = google_compute_firewall.allow_sql.id
}
