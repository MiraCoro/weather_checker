output "arn" {
    description = "S3 Bucket ARN"
    value       = aws_s3_bucket.s3_bucket.arn
}

output "id" {
    description = "S3 Bucket ID"
    value       = aws_s3_bucket.s3_bucket.id
}

output "domain" {
    description = "S3 Bucket domain name"
    value       = aws_s3_bucket_website_configuration.s3_bucket.website_domain
  }
