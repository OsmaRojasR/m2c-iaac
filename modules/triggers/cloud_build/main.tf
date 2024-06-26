resource "google_cloudbuild_trigger" "filename-trigger" {
  name = "m2c-dev-trigger-${var.service_name}"
  location = "us-central1"

  github {
    owner       = "JesusELozanoR"
    name        = "m2c-servdocuments"
    push {
      branch = "^master$"
    }
  }

  filename = "cloudbuild.yaml"
}