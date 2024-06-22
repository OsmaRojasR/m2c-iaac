resource "google_clouddeploy_delivery_pipeline" "primary" {
  provider    = "google-beta"
  location    = var.region
  name        = "${var.project_name}-pipeline-${var.service_name}"
  description = "Basic-pipeline"
  project     = var.project_id

  serial_pipeline {
    stages {

      profiles  = ["example-profile-one"]
      target_id = "${var.project_name}-target-${var.service_name}"
    }
  }
  labels = {
    my_first_label = "example-label-1"
    my_second_label = "example-label-2"
  }
}