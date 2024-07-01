resource "google_cloudbuild_worker_pool" "pool" {
  name     = "${var.project_name}-private-pool"
  location = var.region
  
  worker_config {
    disk_size_gb  = 100
    machine_type  = "e2-medium"
    no_external_ip = true
  }

  network_config {
    peered_network = "projects/${var.project_id}/global/networks/${var.network_name}"
  }
}