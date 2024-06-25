resource "google_compute_instance" "bastion" {
  count        = length(var.subnets)
  name         = "${var.instance_name}-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    auto_delete = true
    device_name = "${var.instance_name}-${count.index}"

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
    access_config {
      network_tier = "STANDARD"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/${var.project_id}/regions/${var.region}/subnetworks/${element(var.subnets, count.index)}"
  }

  scheduling {
    automatic_restart   = false
    on_host_maintenance = "MIGRATE"
    preemptible         = var.preemptible
  }

  service_account {
    # email  = var.service_account_email
    scopes = var.service_account_scopes
  }

  shielded_instance_config {
    enable_integrity_monitoring = false
    enable_secure_boot          = false
    enable_vtpm                 = false
  }

  tags = ["http-server", "https-server", "${var.network_name}-allow-ssh", "${var.network_name}-allow-sql"]
}
