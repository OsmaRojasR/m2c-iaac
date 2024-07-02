resource "google_clouddeploy_target" "primary" {
  location          = var.region
  name              = "${var.project_name}-delivery-target-${var.service_name}"
  deploy_parameters = {}
  description       = "Destino de despliegue del servicio ${var.service_name}"
  execution_configs {
    usages            = ["RENDER", "DEPLOY"]
    execution_timeout = "3600s"
  }
  project          = var.project_id
  require_approval = false
  run {
    location = "projects/${var.project_id}/locations/${var.region}"
  }
  provider          = google-beta
}

resource "google_clouddeploy_delivery_pipeline" "pipeline" {
  name     = "${var.project_name}-delivery-pipeline-${var.service_name}"
  location = var.region
  description       = "Canalizador de entraga del servicio ${var.service_name}"
  serial_pipeline {
    stages {
      target_id = "${var.project_name}-delivery-target-${var.service_name}"
      profiles  = ["m2c-qa-${var.service_name}-run-dev"]
    }
  }
  depends_on = [google_clouddeploy_target.primary]
}