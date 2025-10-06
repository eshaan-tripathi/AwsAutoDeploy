variable "service_name" {
  description = "Name of the service / resource"
  type        = string
}

variable "service_type" {
  description = "Type of service (lambda or glue)"
  type        = string
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
