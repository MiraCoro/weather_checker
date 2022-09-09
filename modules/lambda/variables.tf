variable "lambda_name" {
    description = "AWS Lambda Function name."
    type    = string
    default = "weather_checker"
}

variable "image_url"{
    description = "Path to image in ECR."
    type    = string
}