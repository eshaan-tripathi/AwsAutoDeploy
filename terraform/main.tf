provider "aws" {
  region = var.region
}

# ----------------- Lambda -----------------
resource "aws_lambda_function" "this" {
  count = var.service_type == "lambda" ? 1 : 0

  function_name = var.service_name
  filename      = "${path.module}/deploy.zip"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = var.lambda_role_arn
  publish       = true

  lifecycle {
    ignore_changes = [source_code_hash]
  }
}

resource "aws_lambda_alias" "alias" {
  count            = var.service_type == "lambda" ? 1 : 0
  name             = "prod"
  function_name    = aws_lambda_function.this[0].function_name
  function_version = aws_lambda_function.this[0].version
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
