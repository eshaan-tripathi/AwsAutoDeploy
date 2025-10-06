provider "aws" {
  region = var.region
}

# ----------------- Lambda -----------------
resource "aws_lambda_function" "this" {
  count = var.service_type == "lambda" ? 1 : 0

  function_name = var.service_name
  filename      = "${path.module}/src/deploy.zip"   # Fixed path to match workflow
  source_code_hash = filebase64sha256("${path.module}/src/deploy.zip") 
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = var.lambda_role_arn
  publish       = true
}

resource "aws_lambda_alias" "alias" {
  count            = var.service_type == "lambda" ? 1 : 0
  name             = "prod"
  function_name    = aws_lambda_function.this[0].function_name
  function_version = aws_lambda_function.this[0].version
}

# ----------------- S3 -----------------
resource "aws_s3_bucket" "this" {
  count  = var.service_type == "s3" ? 1 : 0
  bucket = var.service_name

  tags = {
    Name = var.service_name
  }
}

# Use aws_s3_bucket_acl instead of deprecated 'acl'
resource "aws_s3_bucket_acl" "this_acl" {
  count  = var.service_type == "s3" ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  acl    = "private"
}

# ----------------- Glue -----------------
resource "aws_glue_job" "this" {
  count    = var.service_type == "glue" ? 1 : 0
  name     = var.service_name
  role_arn = var.lambda_role_arn

  command {
    name            = "glueetl"
    script_location = "s3://my-bucket/${var.service_name}/script.py"
    python_version  = "3"
  }

  max_retries = 1
}

# ----------------- EC2 -----------------
resource "aws_instance" "this" {
  count         = var.service_type == "ec2" ? 1 : 0
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  tags = {
    Name = var.service_name
  }
}
