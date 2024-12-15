aws_region = "us-east-1"

s3_bucket_name      = "final-cicd-bucket-8934575"
s3_bucket_tag_name  = "Static Website Bucket"
environment         = "Production"

lambda_function_name = "Function-8934575"
lambda_handler       = "handler.handler"
lambda_runtime       = "nodejs22.x"
lambda_package_path  = "../lambda/package.zip"
lambda_exec_role_name = "lambda_exec_role"

api_name        = "textApi"
api_description = "API for fetching text from Lambda"
