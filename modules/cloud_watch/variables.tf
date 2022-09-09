variable cloudwatch_event {
    description = "Cloudwatch event rule name."
    type        = string
    default = "lambda_trigger"
}

variable lambda_name {
    description = "Lambda function to trigger"
    type        = string
}

variable lambda_arn {
    description = "Lambda arn"
    type        = string
}