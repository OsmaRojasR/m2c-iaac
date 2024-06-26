resource "google_cloudbuild_trigger" "filename-trigger" {
  location = "us-central1"

  trigger_template {
    branch_name = "master"
    repo_name   = "JesusELozanoR/m2c-servdocuments"
  }

  filename = "cloudbuild.yaml"
}