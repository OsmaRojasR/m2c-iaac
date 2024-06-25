resource "google_compute_instance" "bastion" {
  for_each = { for idx, subnet in var.subnets : idx => subnet }

  name         = "${var.instance_name}-${each.key}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    auto_delete = true
    device_name = "${var.instance_name}-${each.key}"

    initialize_params {
      image = var.image
      size  = var.disk_size
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  network_interface {
    subnetwork = "projects/${var.project_id}/regions/${var.region}/subnetworks/${each.value}"

    access_config {
      network_tier = "STANDARD"
    }
  }

  scheduling {
    automatic_restart   = false
    on_host_maintenance = "MIGRATE"
    preemptible         = var.preemptible
  }
  shielded_instance_config {
    enable_integrity_monitoring = false
    enable_secure_boot          = false
    enable_vtpm                 = false
  }

  tags = ["http-server", "https-server", "${var.network_name}-allow-ssh", "${var.network_name}-allow-sql"]
}
