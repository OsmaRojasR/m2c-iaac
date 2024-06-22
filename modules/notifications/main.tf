resource "google_monitoring_notification_channel" "basic" {
  display_name = "email-${var.email}"
  type         = "email"
  labels = {
    email_address = "${var.email}"
  }
  force_delete = false
}


resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = "My Alert Policy"
  combiner     = "AND"
  conditions {
    display_name = "test condition"
    condition_threshold {
      filter     = "logName=projects${var.project_id}/logs/clouddeploy.googleapis.com%2Frollout_update AND resource.type= clouddeploy.googleapis.com/DeliveryPipeline AND resource.labels.pipeline_id=${var.pipeline_id} AND resource.labels.location=${var.region} AND jsonPayload.rolloutUpdateType=APPROVAL_REQUIRED"
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  user_labels = {
    foo = "bar"
  }

}