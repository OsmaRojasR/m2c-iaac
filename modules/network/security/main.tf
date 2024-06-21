resource "google_compute_firewall" "allow_internal" {
  name    = "${var.network_name}-allow-internal"
  network = var.network

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.network_name}-allow-ssh"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_sql" {
  name    = "${var.network_name}-allow-sql"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["1433"]
  }

  source_ranges = ["0.0.0.0/0"]
}
