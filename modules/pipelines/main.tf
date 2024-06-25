resource "google_clouddeploy_delivery_pipeline" "primary" {
  name        = "${lower(replace(var.project_name, "/[^a-z0-9-]/", "-"))}-pipeline"
  project     = var.project_id
  location      = var.region
  description = "Basic-pipeline"
  provider    = google-beta
  serial_pipeline {
    stages {
      target_id = google_clouddeploy_target.target.id
      profiles  = ["default"]
    }
  }
}

resource "google_clouddeploy_target" "target" {
  name        = "${lower(replace(var.project_name, "/[^a-z0-9-]/", "-"))}-target"
  project     = var.project_id
  location      = var.region
  description = "Deploy target for m2c-destiny"
  require_approval = true


  run {
    location    = "projects/${var.project_id}/locations/${var.region}"  
  }
}