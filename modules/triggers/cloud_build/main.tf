resource "google_cloudbuild_trigger" "filename-trigger" {
  name = "${lower(replace(var.project_name, "/[^a-z0-9-]/", "-"))}-trigger-${var.service_name}"
  location = var.region

  trigger_template {
    branch_name = "master"
    repo_name   = "JesusELozanoR/m2c-${var.service_name}`"
  }

  filename = "cloudbuild.yaml"
}