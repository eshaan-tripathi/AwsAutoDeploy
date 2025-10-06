terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "esh-terra"
    key    = "lambda-glue/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

# Lambda Deployment
resource "aws_lambda_function" "demo_lambda" {
  filename         = var.lambda_zip
  function_name    = "demo_service"
  role             = var.lambda_role
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  source_code_hash = filebase64sha256(var.lambda_zip)
}

# Glue Deployment
resource "aws_glue_job" "demo_glue" {
  name     = "demo_glue"
  role_arn = var.glue_role
  command {
    name            = "glueetl"
    script_location = var.glue_script_path
  }
}
