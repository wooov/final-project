variable "bastion_ami" {default = "ami-0e38c97339cddf4bd"}
variable "bastion_instance_type" {default = "t3.micro"}
variable "bastion_key_name" {default = "ecs_app.pem"}
variable "bastion_volume_size" {default = 8}
variable "slack_webhook_url" {
    description = "Slack webhook url"
    default = "https://app.slack.com/client/T04TD1LPFJT/C04U66KC79P/rimeto_profile/U04TQK19TB7"
}