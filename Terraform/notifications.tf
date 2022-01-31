resource "tfe_notification_configuration" "servers_slack_notifications" {
  workspace_id     = module.servers.servers_workspace_id
  name             = var.servers_workspace_name
  enabled          = true
  destination_type = "slack"
  triggers = [
    "run:created",
    "run:planning",
    "run:needs_attention",
    "run:applying",
    "run:completed",
    "run:errored"
  ]
  url = var.slack_webhook_url
}
resource "tfe_notification_configuration" "vpc_slack_notifications" {
  workspace_id     = module.vpc.vpc_workspace_id
  name             = var.vpc_workspace_name
  enabled          = true
  destination_type = "slack"
  triggers = [
    "run:created",
    "run:planning",
    "run:needs_attention",
    "run:applying",
    "run:completed",
    "run:errored"
  ]
  url = var.slack_webhook_url
}
resource "tfe_notification_configuration" "k8s_slack_notifications" {
  workspace_id     = module.eks.kubernetes_workspace_id
  name             = var.kubernetes_workspace_name
  enabled          = true
  destination_type = "slack"
  triggers = [
    "run:created",
    "run:planning",
    "run:needs_attention",
    "run:applying",
    "run:completed",
    "run:errored"
  ]
  url = var.slack_webhook_url
}

resource "tfe_notification_configuration" "rds_slack_notifications" {
  workspace_id     = module.rds.rds_workspace_id
  name             = var.rds_workspace_name
  enabled          = true
  destination_type = "slack"
  triggers = [
    "run:created",
    "run:planning",
    "run:needs_attention",
    "run:applying",
    "run:completed",
    "run:errored"
  ]
  url = var.slack_webhook_url
}
