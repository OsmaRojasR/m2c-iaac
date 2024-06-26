resource "google_cloudbuild_worker_pool" "pool" {
  name     = "m2c-dev-worker-pool"
  location = var.region
  worker_config {
    disk_size_gb = 100
    machine_type = "e2-standard-4"
    no_external_ip = false
  }
  network_config {
    peered_network = "projects/${var.project_id}/global/networks/${var.network_name}"
    peered_network_ip_range = "/29"
  }
}