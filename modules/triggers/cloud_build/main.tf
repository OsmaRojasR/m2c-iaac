resource "google_cloudbuild_trigger" "filename-trigger" {
  name = "${var.project_name}-trigger-${var.service_name}"
  location = var.region

  trigger_template {
    branch_name = "master"
    repo_name   = "JesusELozanoR/m2c-${var.service_name}`"
  }

  filename = "cloudbuild.yaml"
}

resource "google_cloudbuild_worker_pool" "pool" {
  name = "${var.project_name}-worker-pool-${var.service_name}"
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