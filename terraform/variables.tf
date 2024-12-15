variable "aws_region" {
  default = "us-east-1"
  description = "AWS region for the resources."
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket."
}

variable "s3_bucket_tag_name" {
  description = "Name tag for the S3 bucket."
}

variable "environment" {
  description = "Deployment environment (e.g., Production)."
}

variable "index_document_suffix" {
  default = "index.html"
  description = "Index document for the S3 bucket website."
}

variable "error_document_key" {
  default = "index.html"
  description = "Error document key for the S3 bucket website."
}

variable "block_public_acls" {
  default = false
  description = "Block public ACLs setting."
}

variable "block_public_policy" {
  default = false
  description = "Block public policies setting."
}

variable "ignore_public_acls" {
  default = false
  description = "Ignore public ACLs setting."
}

variable "restrict_public_buckets" {
  default = false
  description = "Restrict public buckets setting."
}

variable "lambda_function_name" {
  description = "Name of the Lambda function."
}

variable "lambda_handler" {
  description = "Handler for the Lambda function."
}

variable "lambda_runtime" {
  description = "Runtime environment for the Lambda function."
}

variable "lambda_package_path" {
  description = "Path to the Lambda package ZIP file."
}

variable "lambda_exec_role_name" {
  description = "Name of the IAM role for Lambda execution."
}

variable "api_name" {
  description = "Name of the API Gateway."
}

variable "api_description" {
  description = "Description of the API Gateway."
}
