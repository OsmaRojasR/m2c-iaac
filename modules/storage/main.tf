resource "google_storage_bucket" "static-site" {
  name     = "${var.project_name}-storage"
  location = "US"
  
}