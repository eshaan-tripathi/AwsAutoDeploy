variable "service_name" {
  description = "Name of the service / resource"
  type        = string
  default     = "esh-lambda-demo"
}

variable "service_type" {
  description = "Type of service (lambda, s3, glue, ec2)"
  type        = string
  default     = "lambda"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda execution"
  type        = string
  default     = "arn:aws:iam::612572392212:role/AWSLambdaExecutionRole"
}
