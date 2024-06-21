resource "google_artifact_registry_repository" "my-repo" {
  location      = "us-central1"
  repository_id = "m2c-${var.enviroment}-repository-docker-${var.service_name}"
  description   = "Repositorio de Imagenes Docker del servicio ${var.service_name}"
  format        = "DOCKER"
  cleanup_policy_dry_run = false
  cleanup_policies {
    id     = "Conservacion Condicional "
    action = "KEEP"
    most_recent_versions {
      keep_count            = ${var.keep_n_versions}
    }
  }
  cleanup_policies {
    id     = "Eliminado Condicional"
    action = "DELETE"
    condition {
      older_than   = "7d"
    }
  }
}