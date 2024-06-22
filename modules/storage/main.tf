resource "google_storage_bucket" "static-site" {
  name     = "m2c-${var.project_name}-storage"
  location = "US"
  
}