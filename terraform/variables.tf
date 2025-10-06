# terraform/variables.tf

variable "service_name" {
  type = string
}

variable "service_type" {
  type = string
}

variable "region" {
  type = string
}

variable "lambda_role_arn" {
  type = string
}

variable "lambda_runtime" {
  type    = string
  default = "nodejs18.x"
}

variable "lambda_handler" {
  type    = string
  default = "index.handler"
}
