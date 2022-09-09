output  "repository_url" {
    description = "URL of new repo in ECR."
    value = "${aws_ecr_repository.lambda_repo.repository_url}@${data.aws_ecr_image.lambda_image.id}"
}