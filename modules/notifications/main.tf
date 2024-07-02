resource "google_monitoring_notification_channel" "basic" {
  for_each = toset(var.emails)
  display_name = "${var.project_name}-channel-email-${split("@", each.value)[0]}"
  type         = "email"
  labels = {
    email_address = "${each.value}"
  }
  force_delete = false
}

locals {
  notification_channel_ids = [
    for id in google_monitoring_notification_channel.basic : id.id
  ]
}

resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = "${var.project_name}-alert-policy-${var.service_name}"
  combiner     = "OR"
  enabled      = true

  documentation {
    #content  = "# Aprobación de despliegue\n\nSe requiere de la aprobación para el despliegue del ambiente DEV del servicio **ServDocuments**\n\n**Proyecto:** ${resource.project}\n**Servicio:** Cloud Build\n**Repositorio:** [m2c-servdocuments](https://github.com/JesusELozanoR/m2c-servdocuments)\n# [Compilaciones Por Aprobar](https://console.cloud.google.com/deploy/delivery-pipelines/us-central1/m2c-qa-servdocuments-pipeline/targets/m2c-qa-servdocuments-run-dev/approvals?authuser=1&hl=es&project=came-devops-qa-421116)\n\n"
    content  = "Template de Aprobacion"
    mime_type = "text/markdown"
  }

  conditions {
    display_name = "Rollout approval required in m2c-qa-servdocuments-pipeline pipeline"
    condition_matched_log {
      filter = "logName=\"projects/${var.project_id}/logs/clouddeploy.googleapis.com%2Frollout_update\" AND resource.type=\"clouddeploy.googleapis.com/DeliveryPipeline\" AND resource.labels.pipeline_id=\"${var.project_name}-delivery-pipeline-${var.service_name}\" AND resource.labels.location=\"${var.region}\" AND jsonPayload.rolloutUpdateType=\"APPROVAL_REQUIRED\""
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
    auto_close = "604800s"
  }

  notification_channels = local.notification_channel_ids

  user_labels = {
    environment = "${var.project_name}"
  }
  depends_on=[google_monitoring_notification_channel.basic]
}