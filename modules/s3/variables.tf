variable "bucket_name" {
  description = "S3 bucket name."
  type        = string
  default = "weather-checker-dev-v1-2022"
}

variable "tags" {
  description = "Tags to set on the S3 bucket."
  type        = map(string)
  default     = {
    Purpose   = "weather_checker"
    Env = "test"
  }
}