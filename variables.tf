variable "aws_region" {
    description = "AWS region for all resources."
    type    = string
    default = "us-east-1"
}

variable "shared_credentials_files" {
    description = "Path to credentials file."
    type    = list(string)
    default =  ["/Users/mira/.aws/credentials"]
}
