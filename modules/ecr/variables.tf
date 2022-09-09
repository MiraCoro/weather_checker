variable "repository_name" {
    description = "Name of new repo in ECR."
    type    = string
    default = "lambda-dev"
}

variable "image_tag" {
    description = "Tag for Docker image."
    type    = string
    default = "latest"
}

variable "region" {
    description = "AWS region."
    type    = string
}