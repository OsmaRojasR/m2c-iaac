resource "google_clouddeploy_target" "deploy_target" {
  name        = "m2c-delivery-pipeline"
  project     = var.project_id
  location      = var.region
  description = "Deploy target for m2c-destiny"
  require_approval = true


  run {
    location    = "projects/${var.project_id}/locations/${var.region}"  
  }
}

resource "google_clouddeploy_delivery_pipeline" "deploy_primary" {
  name        = "m2c-delivery-pipeline"  
  project     = var.project_id
  location      = var.region
  description = "Basic pipeline"
  provider    = google-beta
  serial_pipeline {
    stages {
      target_id = google_clouddeploy_target.target.id
      profiles  = ["default"]
    }
  }
}