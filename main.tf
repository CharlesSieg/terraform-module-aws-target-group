resource "aws_lb_target_group" "target_group" {
  name        = "${var.environment}-${var.app_name}-tg"
  port        = var.traffic_port
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  # Check / every 15 seconds and register a failure if an HTTP 200 response is not received within 5 seconds.
  # After 2 failures, flag the target as Unhealthy. After 2 successful checks, flag the target as Healthy again.
  health_check {
    healthy_threshold   = var.health_check_healthy_threshold
    interval            = var.health_check_interval
    matcher             = var.health_check_matcher
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  stickiness {
    cookie_duration = var.session_length
    enabled         = var.stickiness_enabled
    type            = "lb_cookie"
  }

  tags = {
    Application = var.app_name
    Billing     = "${var.environment}-${var.app_name}"
    Environment = var.environment
    Name        = "${var.environment}-${var.app_name}-tg"
    Terraform   = true
  }
}

#
# Creates a CloudWatch alarm to send a notification if any instance becomes
# Unhealthy for longer than 1 minute.
#
resource "aws_cloudwatch_metric_alarm" "UnhealthyInstanceAlarm" {
  alarm_actions             = ["arn:aws:sns:${var.aws_region}:${var.aws_account_id}:${var.environment}_${var.alarm_notification_topic}"]
  alarm_description         = "This alarm monitors for unhealthy instances."
  alarm_name                = "${var.environment}_${var.app_name}_warning-ALB-At-Least-One-Unhealthy-Instance"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  insufficient_data_actions = []
  metric_name               = "state.UnHealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = 60
  statistic                 = "Sum"
  threshold                 = 0

  dimensions = {
    LoadBalancer = "app/${var.alb_arn}"
    TargetGroup  = "targetgroup/${aws_lb_target_group.target_group.arn}"
  }
}
