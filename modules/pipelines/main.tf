resource "google_clouddeploy_delivery_pipeline" "primary" {
  location    = "${var.region}"
  name        = "m2c-${var.enviroment}-pipeline-${var.service_name}"
  description = "Basic-pipeline"
  project     = "var.project_id"

  serial_pipeline {
    stages {
        deploy_parameters {
            match_target_labels = {}
        }

      profiles  = ["example-profile-one"]
      target_id = "m2c-${var.enviroment}-target-${var.service_name}"
    }
  }

  labels = {
    my_first_label = "example-label-1"
    my_second_label = "example-label-2"
  }
  provider    = google-beta
}