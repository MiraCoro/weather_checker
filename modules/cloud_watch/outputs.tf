output  "aws_cloudwatch_event_rule" {
    description = "Cloudwatch event rule name."
    value = aws_cloudwatch_event_rule.event.name
}