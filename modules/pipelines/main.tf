resource "google_clouddeploy_delivery_pipeline" "primary" {
  name        = "${var.project_name}-pipeline-${var.service_name}"
  project     = var.project_id
  region      = var.region
  description = "Basic-pipeline"

  serial_pipeline {
    stages {
      target_id = google_clouddeploy_target.target.id
      profiles  = ["default"]
    }
  }
}



resource "google_clouddeploy_target" "target" {
  name        = "${var.project_name}-target-${var.service_name}"
  project     = var.project_id
  region      = var.region
  description = "Deploy target for m2c-destiny"

  require_approval = true

  run {
    location   = var.region
    service    = "projects/${var.project_id}/locations/${var.region}/services/my-cloud-run-service"
  }
}