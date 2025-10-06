variable "service_name" {
  type = string
}
variable "service_type" {
  type = string
}
variable "region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  region = var.region
}

# ----------------- Lambda -----------------
resource "aws_lambda_function" "service" {
  count             = var.service_type == "lambda" ? 1 : 0
  function_name     = var.service_name
  filename          = "auto-deploy.zip"
  handler           = "index.handler"
  runtime           = "nodejs20.x"
  role              = "arn:aws:iam::612572392212:role/AWSLambdaExecutionRole"
  source_code_hash  = filebase64sha256("auto-deploy.zip")
  publish           = true
}

resource "aws_lambda_alias" "alias" {
  count            = var.service_type == "lambda" ? 1 : 0
  name             = "prod"
  function_name    = var.service_name
  function_version = aws_lambda_function.service[0].version
}

# ----------------- Glue -----------------
resource "aws_glue_job" "service" {
  count = var.service_type == "glue" ? 1 : 0
  name  = var.service_name
  role_arn = "arn:aws:iam::612572392212:role/AWSGlueServiceRole"

  command {
    name            = "glueetl"
    script_location = "s3://my-bucket/${var.service_name}/script.py"
    python_version  = "3"
  }
}

# ----------------- S3 -----------------
resource "aws_s3_bucket" "service" {
  count  = var.service_type == "s3" ? 1 : 0
  bucket = var.service_name
  acl    = "private"
  tags = {
    Name = var.service_name
  }
}

# ----------------- EC2 -----------------
resource "aws_instance" "service" {
  count         = var.service_type == "ec2" ? 1 : 0
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  tags = {
    Name = var.service_name
  }
}
