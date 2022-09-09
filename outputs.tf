output "s3_arn" {
    description = "S3 Bucket ARN"
    value       = module.s3.arn
}

output "s3_name" {
    description = "S3 Bucket ID"
    value       = module.s3.id
}

output "s3_domain" {
    description = "S3 Bucket domain name"
    value       = module.s3.domain
}

output "lambda_policy_arn" {
    description = "AWS Lambda policy ARN"
    value       = module.lambda.policy_arn
}

output lambda_name{
    description = "AWS Lambda name"
    value       = module.lambda.lambda_name
}

output "lambda_arn" {
    description = "AWS Lambda arn"
    value = module.lambda.lambda_arn
}

output "repository_url" {
    description = "ECR repo url"
    value = module.ecr.repository_url
}

output "aws_cloudwatch_event_name" {
    description = "Cloudwatch event rule name."
    value = module.cw.aws_cloudwatch_event_rule
}