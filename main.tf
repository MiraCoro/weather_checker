terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 4.29.0"
      }
    }
}
provider "aws" {
    region = var.aws_region
    shared_credentials_files = var.shared_credentials_files
}

module "s3" {
    source = "./modules/s3"
}

module "lambda" {
    source = "./modules/lambda"
    depends_on = [module.s3, module.ecr]
    image_url = module.ecr.repository_url
}

module "cw" {
    source = "./modules/cloud_watch"
    depends_on = [module.s3, module.lambda]
    lambda_name = module.lambda.lambda_name
    lambda_arn = module.lambda.lambda_arn
}

module "ecr" {
    source = "./modules/ecr"
    region = var.aws_region
}
