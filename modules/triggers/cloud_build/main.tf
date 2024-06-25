resource "google_cloudbuild_trigger" "filename-trigger" {
  name = var.project_name
  location = var.region

  trigger_template {
    branch_name = "master"
    repo_name   = "JesusELozanoR/m2c-${var.service_name}`"
  }

  filename = "cloudbuild.yaml"
}