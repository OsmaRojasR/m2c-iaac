# resource "google_secret_manager_secret" "github_token_secret" {
#   secret_id = "github-token-secret"
#   replication {
#     auto {}
#   }
# }

# resource "google_secret_manager_secret_version" "github_token_secret_version" {
#   secret      = google_secret_manager_secret.github_token_secret.id
#   secret_data = jsonencode({
#     "token": var.github_token
#   })
# }

# data "google_iam_policy" "p4sa_secret_accessor" {
#   binding {
#     role = "roles/secretmanager.secretAccessor"    
#     members = ["serviceAccount:service-${var.project_id}@gcp-sa-cloudbuild.iam.gserviceaccount.com"]
#   }
# }

# resource "google_secret_manager_secret_iam_policy" "policy" {
#   secret_id   = google_secret_manager_secret.github_token_secret.secret_id
#   policy_data = data.google_iam_policy.p4sa_secret_accessor.policy_data
# }

# resource "google_cloudbuildv2_connection" "github_connection" {
#   location = var.region
#   name     = "github-connection"

#   github_config {
#     app_installation_id = var.github_app_installation_id
#     authorizer_credential {
#       oauth_token_secret_version = google_secret_manager_secret_version.github_token_secret_version.id
#     }
#   }
# }

# resource "google_cloudbuildv2_repository" "github_repository" {
#   location           = var.region
#   name               = var.github_repo
#   parent_connection  = google_cloudbuildv2_connection.github_connection.name
#   remote_uri         = "https://github.com/${var.github_owner}/${var.github_repo}.git"
# }


# resource "google_cloudbuild_trigger" "github_trigger" {
#   name     = "m2c-dev-trigger-${var.service_name}"
#   location = var.region

#   github {
#     owner = var.github_owner
#     name  = var.github_repo
#     push {
#       branch = "^master$"
#     }
#   }

#   filename = "cloudbuild.yaml"
# }


resource "google_cloudbuild_trigger" "include_build_logs_trigger" {

  location = var.region
  name     = "${var.project_name}-trigger-${var.service_name}"
  filename = "cloudbuild.yaml"

  github {
    owner = "JesusELozanoR"
    name  = "m2c-servdocuments"
    push {
      branch = "^master$"
    }
  }
}