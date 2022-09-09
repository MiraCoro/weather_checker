resource "aws_cloudwatch_event_rule" "event" {
  name                = var.cloudwatch_event
  description         = "Runs event every hour"
  schedule_expression = "rate(1 hour)"
}

resource "aws_cloudwatch_event_target" "target" {
  rule      = aws_cloudwatch_event_rule.event.name
  target_id = "lambda"
  arn       = var.lambda_arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.event.arn
}