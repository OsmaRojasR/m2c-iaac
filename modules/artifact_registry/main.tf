resource "google_artifact_registry_repository" "my-repo" {
  location      = var.region
  repository_id = "${var.project_name}-repository-docker-${var.service_name}"
  description   = "Repositorio de Imagenes Docker del servicio ${var.service_name}"
  format        = "DOCKER"
  cleanup_policy_dry_run = false
  cleanup_policies {
    id     = "conservacion-condicional "
    action = "KEEP"
    most_recent_versions {
      keep_count            = var.keep_n_versions
    }
  }
  cleanup_policies {
    id     = "eliminado-condicional"
    action = "DELETE"
    condition {
      older_than   = "2592000s"
    }
  }
}