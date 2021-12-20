resource "tfe_notification_configuration" "ec2_slack_notifications" {
  workspace_id     = module.ec2.ec2_workspace_id
  name             = var.ec2_workspace_name
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
