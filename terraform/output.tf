output "lambda_name" {
  value = aws_lambda_function.demo_service.function_name
}

output "glue_job_name" {
  value = aws_glue_job.demo_glue.name
}
