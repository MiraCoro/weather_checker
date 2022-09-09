output "policy_arn" {
    description = "AWS Lambda policy ARN"
    value       = aws_iam_policy.iam_policy_for_lambda.arn
}

output "lambda_name" {
    description = "AWS Lambda name"
    value = aws_lambda_function.terraform_lambda_func.function_name
}

output "lambda_arn" {
    description = "AWS Lambda arn"
    value = aws_lambda_function.terraform_lambda_func.arn
}
