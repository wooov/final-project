resource "aws_cloudwatch_metric_alarm" "my_alarm" {
  alarm_name                = "my-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors RDS cpu utilization"
  alarm_actions             = [aws_sns_topic.topic.arn]
  ok_actions                = [aws_sns_topic.topic.arn]
  insufficient_data_actions = [aws_sns_topic.topic.arn]
}
