resource "google_cloudbuild_worker_pool" "pool" {
  name = "${lower(replace(var.project_name, "/[^a-z0-9-]/", "-"))}-worker-pool"
  location = var.region
  worker_config {
    disk_size_gb = 100
    machine_type = "e2-standard-4"
    no_external_ip = false
  }
  network_config {
    peered_network = var.network_name
  }
}