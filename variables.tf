variable "alarm_notification_topic" {
  description = "Name for SNS topic on which to send alarm notifications."
  type        = string
}

variable "alb_arn" {
  description = "The ARN of the application load balancer."
  type        = string
}

variable "app_name" {
  description = "application name"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account number in which the infrastructure will be provisioned."
  type        = string
}

variable "aws_region" {
  description = "The AWS region in which the infrastructure will be provisioned."
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive successful health checks required before marking an unhealthy instance as healthy."
  type        = string
}

variable "health_check_interval" {
  description = "The amount of time in seconds between health checks."
  type        = string
}

variable "health_check_matcher" {
  description = "The acceptable HTTP codes for a succesful health check."
  type        = string
}

variable "health_check_path" {
  description = "The path on which to make the health check request"
  type        = string
}

variable "health_check_port" {
  description = "The port on which to make the health check request"
  type        = string
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive failed health checks required before marking a healthy instance as unhealthy."
  type        = string
}

variable "session_length" {
  default     = 360
  description = "The length of time in seconds for which a session is sticky."
  type        = number
}

variable "stickiness_enabled" {
  default     = false
  description = "Determines whether sticky sessions are enabled on the target group."
  type        = bool
}

variable "traffic_port" {
  description = "The port on which the load balancer should route traffic"
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}
